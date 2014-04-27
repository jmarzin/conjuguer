class Temps
  attr_accessor :radical, :voyelle_thematique, :personnes
  def initialize(tableau)
    @radical = tableau[0]
    @voyelle_thematique = tableau[1]
    @personnes = tableau.drop(2)
  end
  def s1
    (personnes[0] == '---') ? @personnes[0] : @radical+@voyelle_thematique+@personnes[0]
  end
  def s2
    (personnes[1] == '---') ? @personnes[1] : @radical+@voyelle_thematique+@personnes[1]
  end
  def s3
    (personnes[2] == '---') ? @personnes[2] : @radical+@voyelle_thematique+@personnes[2]
  end
  def p1
    (personnes[3] == '---') ? @personnes[3] : @radical+@voyelle_thematique+@personnes[3]
  end
  def p2
    (personnes[4] == '---') ? @personnes[4] : @radical+@voyelle_thematique+@personnes[4]
  end
  def p3
    (personnes[5] == '---') ? @personnes[5] : @radical+@voyelle_thematique+@personnes[5]
  end
  def to_s
    s1+' '+s2+' '+s3+' '+p1+' '+p2+' '+p3
  end
end

class Mode
  def initialize(tableau)
    @mode = []
    tableau.each {|el| @mode << el}
  end
  def pres
    @mode[0]
  end
  def imp
    @mode[1]
  end
  def parf
    @mode[2]
  end
  def fut
    @mode[3]
  end
end


class Conjugaison < ActiveRecord::Base

  Max_essais = 20

  validates :infinitif, presence: {message: "L'infinitif est obligatoire"}
  validates :verbe, presence: {message: "Le détail de la conjugaison est obligatoire"}
  validates :infinitif, uniqueness: {message: "L'infinitif doit être unique"}

  before_save :ser_deser_verbe
  after_save :ser_deser_verbe
  after_find :ser_deser_verbe

  def maj(conjugaison_params, params)
    total_essais = 0
    params['formes'].each_with_index do |f, i|
      if f == '---'
        params['compteurs'][i] = 0
      else
        params['compteurs'][i] = params['compteurs'][i].to_i
        total_essais += params['compteurs'][i]
      end
    end
    t1 = [self.infinitif,'']
    t1 << params['formes'][49]
    t1 << params['formes'][48]
    pres = [params['ind']['pres']['radical']]
    pres << params['ind']['pres']['voyelle_thematique']
    pres += params['formes'][0..5]
    imp = [params['ind']['imp']['radical']]
    imp << params['ind']['imp']['voyelle_thematique']
    imp += params['formes'][6..11]
    parf = [params['ind']['parf']['radical']]
    parf << params['ind']['parf']['voyelle_thematique']
    parf += params['formes'][12..17]
    fut = [params['ind']['fut']['radical']]
    fut << params['ind']['fut']['voyelle_thematique']
    fut += params['formes'][18..23]
    t1 << Mode.new([Temps.new(pres),Temps.new(imp),Temps.new(parf),Temps.new(fut)])
    pres = [params['sub']['pres']['radical']]
    pres << params['sub']['pres']['voyelle_thematique']
    pres += params['formes'][24..29]
    imp = [params['sub']['imp']['radical']]
    imp << params['sub']['imp']['voyelle_thematique']
    imp += params['formes'][30..35]
    t1 << Mode.new([Temps.new(pres),Temps.new(imp)])
    pres = [params['cond']['pres']['radical']]
    pres << params['cond']['pres']['voyelle_thematique']
    pres += params['formes'][42..47]
    t1 << Mode.new([Temps.new(pres)])
    pres = [params['imp']['radical']]
    pres << params['imp']['voyelle_thematique']
    pres += params['formes'][36..41]
    t1 << Temps.new(pres)

    conjugaison_params['essais_verbe'] = total_essais
    conjugaison_params['verbe'] = Verbe.new({conj: t1,compteurs: params['compteurs']})
    self.update(conjugaison_params)
  end

  def self.aleatoire
    (rand * Conjugaison.sum("essais_verbe")).ceil
  end

  def tirage(num)
    i=0
    while num > verbe.compteurs[i] do
      num -= verbe.compteurs[i]
      i += 1
      if i == Verbe::Formes.size then return false end
    end

    {forme: Verbe::Formes[i],texte: verbe.show(Verbe::Formes[i]),\
      attendu: eval("verbe.#{Verbe::Formes[i]}")}
  end

  def self.tirage(num)
    @conjugaisons = Conjugaison.all
    i = num
    @conjugaisons.each do |c|
      return {conjugaison: c, rang: i}.merge(c.tirage(i)) if c.essais_verbe >= i
      i -= c.essais_verbe
    end
  end

  def erreur(string)
    verbe.compteurs[Verbe.rang_forme(string)] += 1
    self.essais_verbe += 1
    self
  end

  def succes(string)
    verbe.compteurs[Verbe.rang_forme(string)] -= 1 unless verbe.compteurs[Verbe.rang_forme(string)] == 1
    self.essais_verbe -= 1
    self
  end

  protected
  def ser_deser_verbe
    if self.verbe.class == Verbe
      self.verbe = Marshal.dump(self.verbe)
    else
      begin
        self.verbe = Marshal.restore(self.verbe)
      rescue
      end
    end
  end
end
