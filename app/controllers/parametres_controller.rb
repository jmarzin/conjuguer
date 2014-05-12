class ParametresController < ApplicationController

  # GET /parametres/edit
  def edit
    session[:parametres] ||= {voc_compteur_min: 0,voc_date_min: Time.at(0),conj_compteur_min: 0,conj_date_min: Time.at(0)}
  end

  def update

  end
end
