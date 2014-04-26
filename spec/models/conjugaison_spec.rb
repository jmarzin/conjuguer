require 'spec_helper'

describe Conjugaison do
  it "l'infinitif ne peut pas être blanc" do
    expect(FactoryGirl.build(:conjugaison, infinitif: '')).to have(1).errors_on(:infinitif)
  end
  it "le détail est obligatoire" do
    expect(FactoryGirl.build(:conjugaison, detail: '')).to have(1).errors_on(:detail)
  end
  it "l'infinitif est unique" do
    FactoryGirl.create(:avere)
    expect(Conjugaison.new(infinitif: 'avere')).to have(1).errors_on(:infinitif)
  end
  it "une constante donne le nombre d'essais maximum" do
    expect(Conjugaison::Max_essais.class).to eq(Fixnum)
  end
  it "les formes sont décrites dans un tableau" do
    expect(Verbe::Formes).to be_a_kind_of(Array)
  end
  it "il y a 51 formes" do
    expect(Verbe::Formes.size).to eq(50)
  end
  it "la fonction rang_forme('forme') renvoie le rang de la forme 'forme'" do
    expect(Verbe.rang_forme('ind.pres.s1')).to eq(0)
  end
  it "les compteurs ne sont pas changés par la sauvegarde" do
    @conjugaison = FactoryGirl.build(:conjugaison)
    tab = @conjugaison.compteurs
    @conjugaison.save!
    expect(@conjugaison.compteurs).to eq(tab)
  end
  it "les compteurs sont initialisés s'ils n'existent pas" do
    @conjugaison = FactoryGirl.create(:conjugaison)
    Conjugaison.all.first.update( compteurs: '' )
    expect(Conjugaison.all.first.compteurs.size).to eq(50)
  end
  it "le tirage de la 20ème forme donne ind.pres.s1" do
    @conjugaison = FactoryGirl.create(:avere)
    expect(@conjugaison.tirage(20)).to eq(['ind.pres.s1','Io ho (20)'])
  end
  it "le tirage de la 21ème forme donne ind.pres.s2" do
    @conjugaison = FactoryGirl.create(:avere)
    expect(@conjugaison.tirage(21)).to eq(['ind.pres.s2','Tu hai (20)'])
  end
  it "le tirage du rang égal au nombre d'essais du verbe donne faux" do
    @conjugaison = FactoryGirl.create(:avere)
    expect(@conjugaison.tirage(@conjugaison.essais_verbe + 1)).to be_false
  end
  it "le tirage du rang égal au nombre d'essais du verbe -1 donne avuto" do
    @conjugaison = FactoryGirl.create(:avere)
    expect(@conjugaison.tirage(@conjugaison.essais_verbe)).to eq(['ppass','Avuto (20)'])
  end
end