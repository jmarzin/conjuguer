class ConjugaisonsController < ApplicationController
  before_action :set_conjugaison, only: [:show, :edit, :update, :destroy]

  # GET /conjugaisons
  # GET /conjugaisons.json
  def index
    @conjugaisons = Conjugaison.all
  end

  # GET /conjugaisons/1
  # GET /conjugaisons/1.json
  def show
  end

  # GET /conjugaisons/new
  def new
    @conjugaison = Conjugaison.new
  end

  # GET /conjugaisons/1/edit
  def edit
  end

  # POST /conjugaisons
  # POST /conjugaisons.json
  def create
    @conjugaison = Conjugaison.new(conjugaison_params)

    respond_to do |format|
      if @conjugaison.save
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
      if @conjugaison.update(conjugaison_params)
        format.html { redirect_to @conjugaison, notice: 'Conjugaison was successfully updated.' }
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
