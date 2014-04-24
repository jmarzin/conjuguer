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

class Verbe
  def initialize(conjugue)
    if conjugue.class == Conjugaison
      begin
        @conj = Marshal.load(conjugue.detail)
      rescue
      end
    elsif conjugue.class == Array
      @conj = conjugue
    else
      @conj = [conjugue,'','','']
      @conj << Mode.new([Temps.new(Array.new(8,'')),\
          Temps.new(Array.new(8,'')),\
          Temps.new(Array.new(8,'')),\
          Temps.new(Array.new(8,''))])
      @conj << Mode.new([Temps.new(Array.new(8,'')),\
          Temps.new(Array.new(8,''))])
      @conj << Mode.new([Temps.new(Array.new(8,''))])
      @conj << Temps.new(['','','---','','','','',''])
#      IO.write('db/avere.bin',Marshal.dump(@conj), binmode: true)
#    Conjugaison.create(infinitif: 'avere', essais: 20, detail: Marshal.dump(@conj))
    end
  end

  def conj
    @conj
  end

  def inf
    @conj[0]
  end
  def ppres
    @conj[1]
  end
  def ppass
    @conj[2]
  end
  def ger
    @conj[3]
  end
  def ind
    @conj[4]
  end
  def sub
    @conj[5]
  end
  def cond
    @conj[6]
  end
  def imp
    @conj[7]
  end
  def show(string)
    debut = string[0..2]
    texte = ''
    if ['imp','ger','ppa'].include?(debut)
    else
      if debut == 'sub'
        texte = 'che '
      end
      case string[-2,2]
        when 's1'
          texte += 'io '
        when 's2'
          texte += 'tu '
        when 's3'
          texte += 'lui/lei '
        when 'p1'
          texte += 'noi '
        when 'p2'
          texte += 'voi '
        when 'p3'
          texte += 'loro '
      end
    end
    texte += eval('self.'+string)
    texte.capitalize
  end
end
class Conjugaison < ActiveRecord::Base
  validates :infinitif, presence: {message: "L'infinitif est obligatoire"}
  validates :detail, presence: {message: "Le détail de la conjugaison est obligatoire"}
  validates :infinitif, uniqueness: {message: "L'infinitif doit être unique"}

  before_save :ser_deser_compteurs
  after_save :ser_deser_compteurs
  after_find :verifie_compteurs

  Formes = %w(
    ind.pres.s1 ind.pres.s2 ind.pres.s3 ind.pres.p1 ind.pres.p2 ind.pres.p3
    ind.imp.s1 ind.imp.s2 ind.imp.s3 ind.imp.p1 ind.imp.p2 ind.imp.p3
    ind.parf.s1 ind.parf.s2 ind.parf.s3 ind.parf.p1 ind.parf.p2 ind.parf.p3
    ind.fut.s1 ind.fut.s2 ind.fut.s3 ind.fut.p1 ind.fut.p2 ind.fut.p3
    sub.pres.s1 sub.pres.s2 sub.pres.s3 sub.pres.p1 sub.pres.p2 sub.pres.p3
    sub.imp.s1 sub.imp.s2 sub.imp.s3 sub.imp.p1 sub.imp.p2 sub.imp.p3
    imp.s1 imp.s2 imp.s3 imp.p1 imp.p2 imp.p3
    cond.pres.s1 cond.pres.s2 cond.pres.s3 cond.pres.p1 cond.pres.p2 cond.pres.p3
    ger ppass)

  def self.rang_forme(string)
    Conjugaison::Formes.find_index(string)
  end

  def maj(conjugaison_params, params)
    t = [self.infinitif]
    t << params['ppres']
    t << params['ppass']
    t << params['ger']
    pres = [params['ind']['pres']['radical']]
    pres << params['ind']['pres']['voyelle_thematique']
    pres += params['ind']['pres']['personnes']
    imp = [params['ind']['imp']['radical']]
    imp << params['ind']['imp']['voyelle_thematique']
    imp += params['ind']['imp']['personnes']
    parf = [params['ind']['parf']['radical']]
    parf << params['ind']['parf']['voyelle_thematique']
    parf += params['ind']['parf']['personnes']
    fut = [params['ind']['fut']['radical']]
    fut << params['ind']['fut']['voyelle_thematique']
    fut += params['ind']['fut']['personnes']
    t << Mode.new([Temps.new(pres),Temps.new(imp),Temps.new(parf),Temps.new(fut)])
    pres = [params['sub']['pres']['radical']]
    pres << params['sub']['pres']['voyelle_thematique']
    pres += params['sub']['pres']['personnes']
    imp = [params['sub']['imp']['radical']]
    imp << params['sub']['imp']['voyelle_thematique']
    imp += params['sub']['imp']['personnes']
    t << Mode.new([Temps.new(pres),Temps.new(imp)])
    pres = [params['cond']['pres']['radical']]
    pres << params['cond']['pres']['voyelle_thematique']
    pres += params['cond']['pres']['personnes']
    t << Mode.new([Temps.new(pres)])
    pres = [params['imp']['radical']]
    pres << params['imp']['voyelle_thematique']
    pres += params['imp']['personnes']
    t << Temps.new(pres)
    conjugaison_params['detail'] = Marshal.dump(Verbe.new(t).conj)
    self.update(conjugaison_params)
  end

  protected
  def ser_deser_compteurs
    if self.compteurs.class == Array
      self.compteurs = Marshal.dump(self.compteurs)
    else
      begin
        self.compteurs = Marshal.restore(self.compteurs)
      rescue
      end
    end
  end
  def verifie_compteurs
    if self.compteurs == nil or self.compteurs == ''
      self.compteurs = Array.new(Conjugaison::Formes.size,20)
    else
      ser_deser_compteurs
    end
  end
end
