class Vocabulaire < ActiveRecord::Base

  MAX_ESSAIS = 20
  SUCCES = -1
  ECHEC = +1

  validates :mot_directeur, presence: {message: 'Le mot directeur est obligatoire'}
  validates :francais, presence: {message: 'Le mot ou expression en français est obligatoire'}
  validates :italien, presence: {message: 'La traduction italienne est obligatoire'}
  validates :compteur, numericality: { greater_than: 0, message: 'Le compteur doit être un entier positif' }

  def self.aleatoire
    (rand * Vocabulaire.sum('compteur')).ceil
  end

  def self.tirage(num)
    @dico = Vocabulaire.order(:mot_directeur, :francais)
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
      inc = Vocabulaire::SUCCES
    else
      inc = Vocabulaire::ECHEC
    end
    if self.compteur + inc >= 1
      self.compteur += inc
    else
      self.compteur = 1
    end
    self
  end

end
