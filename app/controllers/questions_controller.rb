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
    if session[:type] == 'conjugaison'
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
    else
      respond_to do |format|
        if params[:reponse]
          @mot = Vocabulaire.find(params[:id])
          if params[:attendu] == params[:reponse].downcase.strip
            params[:message] = true
            session[:bonnes_reponses] += 1
            @mot.succes.save!
          else
            params[:message] = false
            session[:mauvaises_reponses] += 1
            @mot.erreur.save!
          end
          format.html {render action: 'vocabulaire'}
        else
          format.html {redirect_to action: 'vocabulaire'}
        end
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
