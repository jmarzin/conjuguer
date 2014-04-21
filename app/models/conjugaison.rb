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
end
class Conjugaison < ActiveRecord::Base
  validates :infinitif, presence: {message: "L'infinitif est obligatoire"}
  validates :detail, presence: {message: "Le détail de la conjugaison est obligatoire"}
  validates :infinitif, uniqueness: {message: "L'infinitif doit être unique"}
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
end