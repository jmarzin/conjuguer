require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ConjugaisonsController do

  # This should return the minimal set of attributes required to create a valid
  # Conjugaison. As you add validations to Conjugaison, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "infinitif" => "MyString", "detail" => "détail" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ConjugaisonsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all conjugaisons as @conjugaisons" do
      conjugaison = Conjugaison.create! valid_attributes
      get :index, {}, valid_session
      assigns(:conjugaisons).should eq([conjugaison])
    end
  end

  describe "GET show" do
    it "assigns the requested conjugaison as @conjugaison" do
      conjugaison = Conjugaison.create! valid_attributes
      get :show, {:id => conjugaison.to_param}, valid_session
      assigns(:conjugaison).should eq(conjugaison)
    end
  end

  describe "GET new" do
    it "assigns a new conjugaison as @conjugaison" do
      get :new, {}, valid_session
      assigns(:conjugaison).should be_a_new(Conjugaison)
    end
    it "le tableau des essais est chargé" do
      get :new, {}, valid_session
      expect(assigns(:conjugaison).compteurs).to be_a(Array)
    end
  end

  describe "GET edit" do
    it "assigns the requested conjugaison as @conjugaison" do
      conjugaison = Conjugaison.create! valid_attributes
      get :edit, {:id => conjugaison.to_param}, valid_session
      assigns(:conjugaison).should eq(conjugaison)
    end
  end

  describe "GET question" do
    it "envoie un paramètre qui est une conjugaison" do
      FactoryGirl.create(:avere)
      get :question, {}, valid_session
      expect(assigns(:resultat)).to be_a(Hash)
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested conjugaison" do
      conjugaison = Conjugaison.create! valid_attributes
      expect {
        delete :destroy, {:id => conjugaison.to_param}, valid_session
      }.to change(Conjugaison, :count).by(-1)
    end

    it "redirects to the conjugaisons list" do
      conjugaison = Conjugaison.create! valid_attributes
      delete :destroy, {:id => conjugaison.to_param}, valid_session
      response.should redirect_to(conjugaisons_url)
    end
  end
end
