class Vocabulaire < ActiveRecord::Base

  paginates_per 40

  MAX_ESSAIS = 16
  SUCCES = 0.5
  ECHEC = 2

  validates :mot_directeur, presence: {message: 'Le mot directeur est obligatoire'}
  validates :francais, presence: {message: 'Le mot ou expression en français est obligatoire'}
  validates :italien, presence: {message: 'La traduction italienne est obligatoire'}
  validates :compteur, numericality: { greater_than: 0, message: 'Le compteur doit être un entier positif' }

  def self.aleatoire(compteur_min, date_min)
    (rand * Vocabulaire.where("created_at >= ? and compteur >= ?",\
      date_min,compteur_min).sum('compteur')).ceil
  end

  def self.deux_colonnes(vocabulaires)
    i = 0
    liste = []
    vocabulaires.each do |v|
      if i< Vocabulaire.default_per_page/2
        liste[i] = {gauche: v}
      else
        liste[i-Vocabulaire.default_per_page/2][:droite] = v
      end
      i += 1
    end
    liste
  end

  def self.question(id)
    @vocabulaire = Vocabulaire.find(id)
  end

  def self.tirage(num,compteur_min, date_min)
    @dico = Vocabulaire.where("created_at >= ? and compteur >= ?",\
      date_min,compteur_min).order(:mot_directeur, :francais)
    @dico.each do |mot|
      if mot.compteur >= num
        return mot
      else
        num -= mot.compteur
      end
    end
    return false
  end

  def score(ok,inutile)
    if ok
      facteur = Vocabulaire::SUCCES
    else
      facteur = Vocabulaire::ECHEC
      Erreur.create(code: 'vocabulaire', ref: id) unless Erreur.where(ref: id).first
    end
    if (self.compteur * facteur).round >= 1
      self.compteur = (self.compteur * facteur).round
    else
      self.compteur = 1
    end
    self
  end

end
