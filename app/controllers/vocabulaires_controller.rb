class VocabulairesController < ApplicationController

  before_action :set_vocabulaire, only: [:show, :edit, :update, :destroy]
  before_action :set_session, only: [:index]
  unless Rails.env.test?
    before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
    before_action :verifie_utilisateur, only: [:new, :edit, :update, :destroy]
  end

  # GET /vocabulaires
  # GET /vocabulaires.json
  def index
    session[:page] = (params[:page] ||= session[:page])
    @vocabulaires = Vocabulaire.where("created_at >= ? and compteur >= ?",\
      session[:voc_date_min],session[:voc_compteur_min]).order(:mot_directeur).page params[:page]
  end

  # GET /vocabulaires/1
  # GET /vocabulaires/1.json
  def show
  end

  # GET /vocabulaires/new
  def new
    @vocabulaire = Vocabulaire.new
  end

  # GET /vocabulaires/1/edit
  def edit
  end

  # POST /vocabulaires
  # POST /vocabulaires.json
  def create
    @vocabulaire = Vocabulaire.new(vocabulaire_params)

    respond_to do |format|
      if @vocabulaire.save
        format.html { redirect_to @vocabulaire, notice: 'Vocabulaire was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vocabulaire }
      else
        format.html { render action: 'new' }
        format.json { render json: @vocabulaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vocabulaires/1
  # PATCH/PUT /vocabulaires/1.json
  def update
    respond_to do |format|
      if @vocabulaire.update(vocabulaire_params)
        format.html { redirect_to @vocabulaire, notice: 'Vocabulaire was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vocabulaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vocabulaires/1
  # DELETE /vocabulaires/1.json
  def destroy
    @vocabulaire.destroy
    respond_to do |format|
      format.html { redirect_to vocabulaires_url }
      format.json { head :no_content }
    end
  end

  # GET/vocabulaires/sauve
  def sauve
    unless Rails.env.production?
      Vocabulaire.sauve
    end
    redirect_to :action => 'index'
  end


  private

    def set_session
      session[:voc_compteur_min] ||= 0
      session[:voc_date_min] ||= Vocabulaire.minimum('created_at').to_s
#      session[:conj_compteur_min] ||= 0
#      session[:conj_date_min] ||= Conjugaison.minimum('created_at').to_s
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_vocabulaire
      @vocabulaire = Vocabulaire.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vocabulaire_params
      params.require(:vocabulaire).permit(:mot_directeur, :compteur, :francais, :italien)
    end

    def verifie_utilisateur
      unless current_user.email == 'jacques.marzin@free.fr'
        redirect_to :action => 'index'
      end
    end

end
