require 'spec_helper'

describe Erreur do
  context 'Conjugaison' do
    before(:each) do
      @conjugaison = FactoryGirl.create(:avere)
      @conjugaison.score(false,'ind.pres.s1')
    end
    it "l'enregistrement d'une erreur crée l'enregistrement d'une erreur" do
      expect(Erreur.count).to eq(1)
    end
    it "l'erreur enregristrer comprend le code C et l'id de la conjugaison" do
      expect([Erreur.first.code, Erreur.first.ref]).to eq(['C',@conjugaison.id])
    end
  end
  context 'Vocabulaire' do
    before(:each) do
      @vocabulaire = FactoryGirl.create(:vocabulaire)
      @vocabulaire.score(false,'')
    end
    it "l'enregistrement d'une erreur crée l'enregistrement d'une erreur" do
      expect(Erreur.count).to eq(1)
    end
    it "l'erreur enregristrer comprend le code V et l'id du mot ou de l'expression" do
      expect([Erreur.first.code, Erreur.first.ref]).to eq(['V',@vocabulaire.id])
    end
  end
end
