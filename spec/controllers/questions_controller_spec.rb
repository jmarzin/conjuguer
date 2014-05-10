require 'spec_helper'

describe QuestionsController do

  describe "GET 'conjugaison'" do
    it "returns http success" do
      FactoryGirl.create(:avere)
      get :conjugaison
      expect(assigns(:resultat)).to be_a(Hash)
    end
  end

  describe "GET 'vocabulaire'" do
    it "returns http success" do
      FactoryGirl.create(:vocabulaire)
      get :vocabulaire
      response.should be_success
    end
  end

  describe "GET 'lance'" do
    it "returns http succes" do
      get :lance
      response.should be_success
    end
  end
  describe "POST verification" do
    it "reçoit une réponse comme paramètre" do
      post :verification, {session: {type: 'conjugaison'}}
    end
  end

end
