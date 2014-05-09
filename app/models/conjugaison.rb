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

  MAX_ESSAIS = 20
  SUCCES = -1
  ECHEC = +1

  validates :infinitif, presence: {message: "L'infinitif est obligatoire"}
  validates :verbe, presence: {message: "Le détail de la conjugaison est obligatoire"}
  validates :infinitif, uniqueness: {message: "L'infinitif doit être unique"}

  before_save :ser_verbe
  after_save :deser_verbe
  after_find :deser_verbe

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
      return false if i == Verbe::FORMES.size
    end
    {forme: Verbe::FORMES[i],texte: verbe.show(Verbe::FORMES[i]),\
      attendu: eval("verbe.#{Verbe::FORMES[i]}")}
  end

  def self.tirage(num)
    @conjugaisons = Conjugaison.order(:id)
    i = num
    @conjugaisons.each do |c|
      return {conjugaison: c, rang: i}.merge(c.tirage(i)) if c.essais_verbe >= i
      i -= c.essais_verbe
    end
    return false
  end

  def self.accepte?(reponse, attendu)
    return if reponse == ''
    reponses = reponse.downcase.strip.split('/')
    attendus = attendu.downcase.strip.split('/')
    resultat = true
    reponses.each do |rep|
      resultat = resultat && attendus.include?(rep)
    end
    resultat
  end

  def score(ok,string)
    if ok
      inc = Conjugaison::SUCCES
    else
      inc = Conjugaison::ECHEC
      Erreur.create(code: 'C',ref: id)
    end
    if verbe.compteurs[Verbe.rang_forme(string)] + inc >= 1
      verbe.compteurs[Verbe.rang_forme(string)] += inc
      self.essais_verbe += inc
    else
      verbe.compteurs[Verbe.rang_forme(string)] = 1
      self.essais_verbe += 1 + inc
    end
    self
  end

  def self.duree(heure_debut)
    duree = Time.at(Time.now - heure_debut)
    texte = ''
    if duree.hour > 1
      texte += "#{duree.hour - 1} h "
    end
    if duree.min > 0
      texte += "#{duree.min} min "
    end
    if duree.sec > 0
      texte += "#{duree.sec} sec"
    end
    texte
  end

  def self.stats(bonnes, mauvaises)
    texte = ''
    if bonnes+mauvaises > 0
      if bonnes + mauvaises > 1
        texte += "#{bonnes + mauvaises} questions, "
      else
        texte += "1 question, "
      end
      texte += "#{(bonnes*100/(bonnes + mauvaises)).ceil} % de réussite"
    end
    texte
  end

  def self.sauve
    liste = File.new('db/verbes/liste_verbes.txt',mode='w')
    Conjugaison.order(:id).each do |c|
      IO.write(liste,c.infinitif+"\n"+c.essais_verbe.to_s+"\n",liste.size)
      IO.write('db/verbes/'+c.infinitif+'.yml',YAML.dump(c.verbe))
    end
    return true
  end

  def self.aligne(matrice)
    @matrice = Conjugaison.where(infinitif: matrice).take
    Conjugaison.all.each do |conj|
      if conj.infinitif != matrice
        conj.essais_verbe = 0
        conj.verbe.compteurs.each_index do |i|
          if conj.verbe.compteurs[i] > 0
            conj.verbe.compteurs[i] = @matrice.verbe.compteurs[i]
            conj.essais_verbe += conj.verbe.compteurs[i]
          end
        end
      end
      conj.save!
    end
  end

  protected

  def ser_verbe
    if self.verbe.class == Verbe
      self.verbe = YAML.dump(self.verbe)
    end
  end

  def deser_verbe
    begin
      self.verbe = YAML.load(self.verbe)
    rescue
    end
  end

end
