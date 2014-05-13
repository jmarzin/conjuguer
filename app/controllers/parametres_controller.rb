class ParametresController < ApplicationController
  before_action :set_session, only: [:edit]
  # GET /parametres/edit
  def edit
    @voc_compteur_min = session[:voc_compteur_min]
    @voc_date_min = session[:voc_date_min]
    @conj_compteur_min = session[:conj_compteur_min]
    @conj_date_min = session[:conj_date_min]
    @voc_nb = Vocabulaire.where("created_at >= ? and compteur >= ?",@voc_date_min,@voc_compteur_min).count
    @conj_nb = Conjugaison.where("created_at >= ? and essais_verbe >= ?",@conj_date_min,@conj_compteur_min).count
  end

  def update
    @avert = ''
    @voc_compteur_min = params[:voc_compteur_min]
    @voc_date_min = params[:voc_date_min][:year]+'-'+params[:voc_date_min][:month]+'-'+params[:voc_date_min][:day]
    @conj_compteur_min = params[:conj_compteur_min]
    @conj_date_min = params[:conj_date_min][:year]+'-'+params[:conj_date_min][:month]+'-'+params[:conj_date_min][:day]
    @voc_nb = Vocabulaire.where("created_at >= ? and compteur >= ?",@voc_date_min,@voc_compteur_min).count
    @conj_nb = Conjugaison.where("created_at >= ? and essais_verbe >= ?",@conj_date_min,@conj_compteur_min).count
    if @conj_nb == 0
      @avert = 'Paramètres trop restrictifs pour la conjugaison'
    end
    if @voc_nb == 0
      if @avert == ''
        @avert = 'Paramètres trop restrictifs pour le vocabulaire'
      else
        @avert += ' et pour le vocabulaire'
      end
    end
    if @avert == ''
      session[:voc_compteur_min] = params[:voc_compteur_min]
      session[:voc_date_min] = params[:voc_date_min][:year]+'-'+params[:voc_date_min][:month]+'-'+params[:voc_date_min][:day]
      session[:conj_compteur_min] = params[:conj_compteur_min]
      session[:conj_date_min] = params[:conj_date_min][:year]+'-'+params[:conj_date_min][:month]+'-'+params[:conj_date_min][:day]
    end
    render action: 'edit'
  end

  private
    def set_session
      session[:voc_compteur_min] ||= 0
      session[:voc_date_min] ||= Vocabulaire.minimum('created_at').to_s
      session[:conj_compteur_min] ||= 0
      session[:conj_date_min] ||= Vocabulaire.minimum('created_at').to_s
    end
end
