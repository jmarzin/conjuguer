class ConjugaisonsController < ApplicationController
  before_action :set_conjugaison, only: [:show, :edit, :update, :destroy, :copie]
  before_action :set_session, only: [:index]
  unless Rails.env.test?
    before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :copie]
    before_action :verifie_utilisateur, only: [:new, :edit, :update, :destroy, :copie]
  end

  # GET /conjugaisons
  # GET /conjugaisons.json
  def index
    @conjugaisons = Conjugaison.order(:id)
  end

  # GET /conjugaisons/1
  # GET /conjugaisons/1.json
  def show
  end

  # GET /conjugaisons/new
  def new
    @conjugaison = Conjugaison.new(infinitif: '',\
      essais_verbe: Verbe::FORMES.size * Conjugaison::MAX_ESSAIS, verbe: Verbe.new(''))
  end


  # GET/conjugaison/1/copie
  def copie
    @copie = Conjugaison.new(\
      infinitif: 'Copie de ' + @conjugaison.infinitif,\
       essais_verbe: @conjugaison.essais_verbe,\
       verbe: @conjugaison.verbe)
    @copie.save
    redirect_to :action => 'edit', :id => @copie.id
  end

  # GET/conjugaisons/sauve
  def sauve
    unless Rails.env.production?
      Conjugaison.sauve
    end
    redirect_to :action => 'index'
  end

  #GET/conjugaisons/aligne
  def aligne
    Conjugaison.aligne('avere')
    redirect_to :action => 'index'
  end

  # GET /conjugaisons/1/edit
  def edit
  end

  # POST /conjugaisons
  # POST /conjugaisons.json
  def create
    @conjugaison = Conjugaison.new(conjugaison_params)

    respond_to do |format|
      if @conjugaison.maj(conjugaison_params, params)
        format.html { redirect_to @conjugaison, notice: 'Conjugaison was successfully created.' }
        format.json { render action: 'show', status: :created, location: @conjugaison }
      else
        format.html { render action: 'new' }
        format.json { render json: @conjugaison.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conjugaisons/1
  # PATCH/PUT /conjugaisons/1.json
  def update
    respond_to do |format|
      if @conjugaison.maj(conjugaison_params, params)
        format.html { redirect_to @conjugaison, notice: 'La conjugaison a bien été mise à jour.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @conjugaison.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conjugaisons/1
  # DELETE /conjugaisons/1.json
  def destroy
    @conjugaison.destroy
    respond_to do |format|
      format.html { redirect_to conjugaisons_url }
      format.json { head :no_content }
    end
  end

  private
    def set_session
      session[:voc_compteur_min] ||= 0
      session[:voc_date_min] ||= Vocabulaire.minimum('created_at').to_s
      session[:conj_compteur_min] ||= 0
      session[:conj_date_min] ||= Vocabulaire.minimum('created_at').to_s
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_conjugaison
      @conjugaison = Conjugaison.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conjugaison_params
      params.require(:conjugaison).permit(:infinitif, :essais_verbe, :verbe)
    end

    def verifie_utilisateur
      unless current_user.email == 'jacques.marzin@free.fr'
        redirect_to :action => 'index'
      end
    end

end
