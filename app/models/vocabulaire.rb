class Vocabulaire < ActiveRecord::Base

  Max_essais = 20
  Succes = -1
  Erreur = +1

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
  def succes
    self.compteur += Vocabulaire::Succes
    self
  end
  def erreur
    self.compteur += Vocabulaire::Erreur
    self
  end
end
