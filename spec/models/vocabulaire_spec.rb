require 'spec_helper'

describe Vocabulaire do
  context 'cas simples' do
    it "Le nombre maximum initial d'essais est un entier" do
      expect(Vocabulaire::MAX_ESSAIS).to be_a(Integer)
    end
    it 'Le mot_directeur est obligatoire' do
      expect(FactoryGirl.build(:vocabulaire, mot_directeur: '')).to have(1).errors_on(:mot_directeur)
    end
    it 'Le texte français est obligatoire' do
      expect(FactoryGirl.build(:vocabulaire, francais: '')).to have(1).errors_on(:francais)
    end
    it 'Le texte italien est obligatoire' do
      expect(FactoryGirl.build(:vocabulaire, italien: '')).to have(1).errors_on(:italien)
    end
    it 'Le compteur est obligatoire' do
      expect(FactoryGirl.build(:vocabulaire, compteur: nil)).to have(1).errors_on(:compteur)
    end
    it 'Le compteur est supérieur à 0' do
      expect(FactoryGirl.build(:vocabulaire, compteur: 0)).to have(1).errors_on(:compteur)
    end
  end
  context "Tirage d'un mot" do
    before(:each) do
      FactoryGirl.create(:vocabulaire, mot_directeur: 'mot 1', francais: '3')
      FactoryGirl.create(:vocabulaire, mot_directeur: 'mot 2')
      FactoryGirl.create(:vocabulaire, mot_directeur: 'mot 1', francais: '1')
      FactoryGirl.create(:vocabulaire, mot_directeur: 'avant les autres')
    end
    it 'Le tirage du 16ème donne avant les autres' do
      expect(Vocabulaire.tirage(16).mot_directeur).to eq('avant les autres')
    end
    it 'Le tirage du 17ème donne mot 1 et 1' do
      @mot = Vocabulaire.tirage(17)
      expect([@mot.mot_directeur,@mot.francais]).to eq(['mot 1','1'])
    end
    it 'Le tirage du 33ème donne mot 1 et 3' do
      @mot = Vocabulaire.tirage(33)
      expect([@mot.mot_directeur,@mot.francais]).to eq(['mot 1','3'])
    end
    it 'Le tirage du 49ème donne mot 2' do
      expect(Vocabulaire.tirage(49).mot_directeur).to eq('mot 2')
    end
    it 'Le tirage du 65ème donne false' do
      expect(Vocabulaire.tirage(65)).to be_false
    end
  end
#  context 'Tenue à la charge' do
#    it "on peut tirer 1 parmi 3000 en moins d'une seconde" do
#      (1..3000).each do
#        FactoryGirl.create(:vocabulaire, mot_directeur: 'mot_directeur', francais: 'texte en français à traduire',\
#          italien: 'texte traduit en italien', compteur: 20)
#      end
#      deb = Time.now
#      Vocabulaire.tirage(195500)
#      fin = Time.now
#      expect((fin-deb)<1).to be_true
#    end
#  end
end
