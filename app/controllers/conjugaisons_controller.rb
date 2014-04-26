class ConjugaisonsController < ApplicationController
  before_action :set_conjugaison, only: [:show, :edit, :update, :destroy, :copie]

  # GET /conjugaisons
  # GET /conjugaisons.json
  def index
    @conjugaisons = Conjugaison.all
  end

  # GET /conjugaisons/1
  # GET /conjugaisons/1.json
  def show
    begin
      @verbe = Verbe.new(@conjugaison)
    rescue
    end
  end

  # GET /conjugaisons/new
  def new
    @verbe = Verbe.new('')
    @conjugaison = Conjugaison.new(infinitif: '', \
      essais_verbe: Verbe::Formes.size * 20, detail: Marshal.dump(@verbe),
      compteurs: Array.new(Verbe::Formes.size, 20))
  end

  # GET/question
  def question
    @resultat = Conjugaison.tirage(Conjugaison.aleatoire)
    params[:id] = @resultat[:conjugaison].id
    params[:attendu] = @resultat[:attendu]
    params[:forme] = @resultat[:forme]
    params[:question] = Verbe.en_clair(@resultat[:forme])+@resultat[:conjugaison].infinitif+' ?'
  end

  # POST/verification
  def verification
    respond_to do |format|
      if params[:reponse]
        @conjugaison = Conjugaison.find(params[:id])
        if params[:attendu] == params[:reponse].downcase
          params[:message] = true
          @conjugaison.succes(params[:forme]).save!
        else
          params[:message] = false
          @conjugaison.erreur(params[:forme]).save!
        end

        format.html { render action: 'question' }
      else
        format.html { redirect_to action: 'question'}
      end
    end
  end

  # GET/conjugaison/1/copie
  def copie
    @copie = Conjugaison.new(\
      infinitif: 'Copie de ' + @conjugaison.infinitif,\
       essais_verbe: @conjugaison.essais_verbe,\
       detail: @conjugaison.detail,\
       compteurs: @conjugaison.compteurs)
    @copie.save
    redirect_to :action => "edit", :id => @copie.id
  end

  # GET /conjugaisons/1/edit
  def edit
    begin
      @verbe = Verbe.new(@conjugaison)
    rescue
    end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_conjugaison
      @conjugaison = Conjugaison.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conjugaison_params
      params.require(:conjugaison).permit(:infinitif, :essais, :detail)
    end
end
