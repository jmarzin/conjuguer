class QuestionsController < ApplicationController
  if not Rails.env.test?
    before_action :authenticate_user!
    before_action :verifie_utilisateur
  end
  # GET/question
  def conjugaison
    if not session.has_key?(:debut)
      session[:type] = 'conjugaison'
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

  # POST/verification
  def verification
    respond_to do |format|
      if params[:reponse]
        @conjugaison = Conjugaison.find(params[:id])
        if params[:attendu] == params[:reponse].downcase.strip
          params[:message] = true
          session[:bonnes_reponses] += 1
          @conjugaison.succes(params[:forme]).save!
        else
          params[:message] = false
          session[:mauvaises_reponses] += 1
          @conjugaison.erreur(params[:forme]).save!
        end

        format.html { render action: 'conjugaison' }
      else
        format.html { redirect_to action: 'conjugaison'}
      end
    end
  end

  def vocabulaire
  end

  private
  def verifie_utilisateur
    if current_user.email != 'jacques.marzin@free.fr'
      redirect_to :action => "index"
    end
  end

end
