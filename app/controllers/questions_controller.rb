class QuestionsController < ApplicationController
  unless Rails.env.test?
    before_action :authenticate_user!
    before_action :verifie_utilisateur
    before_action :set_session, only: [:lance,:conjugaison,:vocabulaire]
  end

  # GET/questions/lance
  def lance
    session[:revision] = true
    if session[:debut]
      @erreur = Erreur.where("created_at < ?", Time.at(session[:debut])).first
    else
      @erreur = Erreur.first
    end
    if @erreur
      session[:id]=@erreur.ref
      session[:type]=@erreur.code
      session[:forme]=@erreur.forme
      @erreur.destroy
      redirect_to action: session[:type]
    else
      if (rand*4).ceil > 3
       redirect_to action: 'conjugaison'
      else
        redirect_to action: 'vocabulaire'
      end
    end
  end

  # GET/questions/conjugaison
  def conjugaison
    session[:type] = 'conjugaison'
    if session[:id]
      @resultat = Conjugaison.question(session[:id], session[:forme])
      session[:id]=nil
    else
      @resultat = Conjugaison.tirage(Conjugaison.aleatoire)
    end
    unless session.has_key?(:debut)
      session[:debut] = Time.now.to_i
      session[:bonnes_reponses], session[:mauvaises_reponses] = 0,0
    end
    params[:id] = @resultat[:conjugaison].id
    params[:infinitif] = @resultat[:conjugaison].infinitif
    params[:attendu] = @resultat[:attendu]
    params[:forme] = @resultat[:forme]
    params[:question] = Verbe.en_clair(@resultat[:forme])+@resultat[:conjugaison].infinitif+' ?'
  end

  #GET/questions/vocabulaire
  def vocabulaire
    session[:type] = 'vocabulaire'
    if session[:id]
      @resultat = Vocabulaire.question(session[:id])
      session[:id]=nil
    else
      @resultat = Vocabulaire.tirage(Vocabulaire.aleatoire)
    end
    unless session.has_key?(:debut)
      session[:debut] = Time.now.to_i
      session[:bonnes_reponses],session[:mauvaises_reponses] = 0,0
    end
    params[:id] = @resultat.id
    params[:question] = @resultat.francais
    params[:attendu] = @resultat.italien
  end

  # POST/questions/verification
  def verification

    if params[:reponse]
      if session[:type] == 'conjugaison'
        @objet = Conjugaison.find(params[:id])
      else
        @objet = Vocabulaire.find(params[:id])
      end
      params[:message] = Conjugaison.accepte?(params[:reponse],params[:attendu])
      if params[:message]
        session[:bonnes_reponses] += 1
      else
        session[:mauvaises_reponses] += 1
      end
      @objet.score(params[:message],params[:forme]).save
      render action: session[:type]
    else
      if session[:revision] then
        redirect_to action: 'lance'
      else
        session[:type] = 'conjugaison' unless session[:type]
        redirect_to action: session[:type]
      end
    end
  end

  private
  def verifie_utilisateur
    unless current_user.email == 'jacques.marzin@free.fr'
      redirect_to 'conjugaisons'
    end
  end

  def set_session
    session[:voc_compteur_min] ||= 0
    session[:voc_date_min] ||= Vocabulaire.minimum('created_at').to_s
    session[:conj_compteur_min] ||= 0
    session[:conj_date_min] ||= Vocabulaire.minimum('created_at').to_s
  end

end

