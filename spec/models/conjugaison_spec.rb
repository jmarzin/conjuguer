require 'spec_helper'

describe Conjugaison do
  context 'la fonction accepte? indique si la réponse est acceptable' do
    it "cas d'une réponse simple et d'une réponse attendue simple" do
      expect(Conjugaison.accepte?('avere','avere')).to be_true
    end
    it "cas d'une réponse simple juste et d'une réponse attendue multiple" do
      expect(Conjugaison.accepte?('avere','avere/essere')).to be_true
    end
    it "cas d'une réponse simple fausse et d'une réponse attentue multiple" do
      expect(Conjugaison.accepte?('avere','essere/dare')).to be_false
    end
    it "cas d'une réponse multiple juste et d'une réponse attendue multiple" do
      expect(Conjugaison.accepte?('avere/essere','essere/avere')).to be_true
    end
  end
  context 'tests simples' do
    it "la durée du test est restituée en clair" do
      expect(Conjugaison.duree(Time.now - 183)).to match(/\d* min \d* sec/)
    end
    it "le taux de réussite n'est pas calculé s'il n'y a pas de questions" do
      expect(Conjugaison.stats(0,0)).to eq ('')
    end
    it "le taux de réussite est calculé s'il y a des questions" do
      expect(Conjugaison.stats(50,50)).to eq ('100 questions, 50 % de réussite')
    end
    it "l'infinitif ne peut pas être blanc" do
     expect(FactoryGirl.build(:conjugaison, infinitif: '')).to have(1).errors_on(:infinitif)
    end
    it "le détail est obligatoire" do
      expect(FactoryGirl.build(:conjugaison, verbe: '')).to have(1).errors_on(:verbe)
    end
    it "l'infinitif est unique" do
     FactoryGirl.create(:avere)
      expect(Conjugaison.new(infinitif: 'avere')).to have(1).errors_on(:infinitif)
    end
    it "une constante donne le nombre d'essais maximum" do
      expect(Conjugaison::MAX_ESSAIS.class).to eq(Fixnum)
    end
    it "les formes sont décrites dans un tableau" do
      expect(Verbe::FORMES).to be_a_kind_of(Array)
    end
    it "il y a 51 formes" do
      expect(Verbe::FORMES.size).to eq(50)
    end
    it "la fonction rang_forme('forme') renvoie le rang de la forme 'forme'" do
      expect(Verbe.rang_forme('ind.pres.s1')).to eq(0)
    end
  end
  context 'tests avec une conjugaison en base' do
    before(:each) do
      @conjugaison = FactoryGirl.create(:avere)
    end
    it "les compteurs ne sont pas changés par la sauvegarde" do
      tab = @conjugaison.verbe.compteurs
      @conjugaison.save!
      expect(@conjugaison.verbe.compteurs).to eq(tab)
    end
    it "le tirage de la 20ème forme donne ind.pres.s1" do
      expect(@conjugaison.tirage(16)).to eq({forme: 'ind.pres.s1',texte: 'Io ho (16)',attendu: 'ho'})
    end
    it "le tirage de la 21ème forme donne ind.pres.s2" do
      expect(@conjugaison.tirage(17)).to eq({forme: 'ind.pres.s2',texte: 'Tu hai (16)',attendu: 'hai'})
    end
    it "le tirage du rang égal au nombre d'essais du verbe donne faux" do
      expect(@conjugaison.tirage(@conjugaison.essais_verbe + 1)).to be_false
    end
    it "le tirage du rang égal au nombre d'essais du verbe -1 donne avuto" do
      expect(@conjugaison.tirage(@conjugaison.essais_verbe)).to eq({forme: 'ppass',texte: 'Avuto (16)',attendu: 'avuto'})
    end
    it "l'enregistrement d'une erreur incrémente le compteur des essais" do
      @conjugaison.score(false,'ind.pres.s1')
      expect(@conjugaison.verbe.compteurs[Verbe.rang_forme('ind.pres.s1')]).to\
        eq(Conjugaison::MAX_ESSAIS*2)
    end
    it "l'enregistrement d'un succès décrémente le compteur des essais" do
      @conjugaison.score(true,'ind.pres.s1')
      expect(@conjugaison.verbe.compteurs[Verbe.rang_forme('ind.pres.s1')]).to\
        eq(Conjugaison::MAX_ESSAIS/2)
    end
    it "le compteur minimum est 1" do
      (1..Conjugaison::MAX_ESSAIS+5).each {@conjugaison.score(true,'ind.pres.s1')}
      expect(@conjugaison.verbe.compteurs[Verbe.rang_forme('ind.pres.s1')]).to eq(1)
    end
    it "la fonction en_clair envoie le nom de la forme en français" do
      expect(Verbe.en_clair('ind.pres.s1')).to eq("1ère p. sing. prés. indic. verbe ")
    end
  end
  context 'tests avec 2 verbes en base' do
    before(:each) do
      @conjugaison = FactoryGirl.create(:avere)
      @conjugaison = FactoryGirl.create(:avere, infinitif: 'copie de avere')
    end
    it 'le tirage général de 800 donne le verbe avere et le rang 800' do
      resultat = Conjugaison.tirage(800,0,'2010-01-01')
      expect(resultat[:conjugaison].infinitif).to eq('avere')
      expect(resultat[:rang]).to eq(800)
    end
    it 'le tirage général de 801 donne le verbe copie de avere et le rang 1' do
      resultat = Conjugaison.tirage(801,0,'2010-01-01')
      expect(resultat[:conjugaison].infinitif).to eq('copie de avere')
      expect(resultat[:rang]).to eq(1)
    end
    it 'le tirage de 800 donne la forme ppass' do
      resultat = Conjugaison.tirage(800,0,'2010-01-01')
      expect(resultat[:conjugaison].tirage(resultat[:rang])[:forme]).to eq('ppass')
    end
    it 'le tirage de 801 donne la forme ind.pres.s1' do
      resultat = Conjugaison.tirage(801,0,'2010-01-01')
      expect(resultat[:conjugaison].tirage(resultat[:rang])[:forme]).to eq('ind.pres.s1')
    end
    it 'le resultat est complet' do
      resultat = Conjugaison.tirage(801,0,'2010-01-01')
      expect(resultat[:forme]+resultat[:texte]).to eq('ind.pres.s1Io ho (16)')
    end
    it "la fonction aléatoire renvoie un nombre > 1 et <= nombre total d'essais" do
      min = 10000
      max = 0
      @c = Conjugaison.all.first
      @c.essais_verbe = 10
      @c.save!
      @c = Conjugaison.all.last
      @c.essais_verbe = 20
      @c.save!
      (1..100).each do
        i = Conjugaison.aleatoire(0,'2010-01-01')
        min = i if min > i
        max = i if max < i
      end
      expect(min*100+max).to eq(130)
    end
    it "la fonction aligne_avere reproduit sur les tous les verbes les compteurs de avere" do
      @avere=Conjugaison.where(infinitif: 'avere').take
      tot = 0
      @avere.verbe.compteurs.each_index { |i| @avere.verbe.compteurs[i]=i+1;tot += i+1 }
      @avere.essais_verbe = tot
      @avere.save!
      Conjugaison.aligne('avere')
      @copie=Conjugaison.where(infinitif: 'copie de avere').take
      expect([@copie.verbe.compteurs,@copie.essais_verbe]).to\
       eq([@avere.verbe.compteurs,@avere.essais_verbe])
    end
  end
end