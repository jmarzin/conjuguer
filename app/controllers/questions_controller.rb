class QuestionsController < ApplicationController
  if not Rails.env.test?
    before_action :authenticate_user!
    before_action :verifie_utilisateur
  end
  # GET/question
  def conjugaison
    session[:type] = 'conjugaison'
    if not session.has_key?(:debut)
      session[:debut] = Time.now.to_i
      session[:bonnes_reponses], session[:mauvaises_reponses] = 0,0
    end
    @resultat = Conjugaison.tirage(Conjugaison.aleatoire)
    params[:id] = @resultat[:conjugaison].id
    params[:infinitif] = @resultat[:conjugaison].infinitif
    params[:attendu] = @resultat[:attendu]
    params[:forme] = @resultat[:forme]
    params[:question] = Verbe.en_clair(@resultat[:forme])+@resultat[:conjugaison].infinitif+' ?'
  end

  def vocabulaire
    session[:type] = 'vocabulaire'
    if not session.has_key?(:debut)
      session[:debut] = Time.now.to_i
      session[:bonnes_reponses],session[:mauvaises_reponses] = 0,0
    end
    @resultat = Vocabulaire.tirage(Vocabulaire.aleatoire)
    params[:id] = @resultat.id
    params[:question] = @resultat.francais
    params[:attendu] = @resultat.italien
  end

  # POST/verification
  def verification
    respond_to do |format|
      if params[:reponse]
        if session[:type] == 'conjugaison'
          @objet = Conjugaison.find(params[:id])
        else
          @objet = Vocabulaire.find(params[:id])
        end
        params[:message] = (params[:attendu] == params[:reponse].downcase.strip)
        if params[:message]
          session[:bonnes_reponses] += 1
        else
          session[:mauvaises_reponses] += 1
        end
        @objet.score(params[:message],params[:forme]).save!
        format.html { render action: session[:type] }
      else
        session[:type] = 'conjugaison' unless session[:type]
        format.html { redirect_to action: session[:type] }
      end
    end
  end

  private
  def verifie_utilisateur
    if current_user.email != 'jacques.marzin@free.fr'
      redirect_to :action => 'index'
    end
  end

end