class Temps
  def initialize(tableau)
    @radical = tableau[0]
    @voyelle_thematique = tableau[1]
    @personnes = tableau.drop(2)
  end
  def s1
    @radical+@voyelle_thematique+@personnes[0]
  end
  def s2
    @radical+@voyelle_thematique+@personnes[1]
  end
  def s3
    @radical+@voyelle_thematique+@personnes[2]
  end
  def p1
    @radical+@voyelle_thematique+@personnes[3]
  end
  def p2
    @radical+@voyelle_thematique+@personnes[4]
  end
  def p3
    @radical+@voyelle_thematique+@personnes[5]
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
    @conj = Marshal.load(conjugue.detail)
#    @conj = [infinitif,'avente','avuto','avendo']
#    @conj << Mode.new([Temps.new(['','','ho', 'hai','ha','abbiamo','avete','hanno']),\
#        Temps.new(%w(av e vo vi va vamo vate vano)),\
#        Temps.new(['','','ebbi','avesti','ebbe','avemmo','aveste','ebbero']),\
#        Temps.new(['av','','rò','rai','rà','remo','rete','ranno'])])
#    @conj << Mode.new([Temps.new(['','','abbia','abbia','abbia','abbiamo','abbiate','abbiano']),\
#        Temps.new(['av','','essi','essi','esse','essimo','este','essero'])])
#    @conj << Mode.new([Temps.new(['av','','rei','resti','rebbe','remmo','reste','rebbero'])])
#    @conj << Temps.new(['','','---','abbi','abbia','abbiamo','abbiate','abbiano'])
#    IO.write('db/avere.bin',Marshal.dump(@conj), binmode: true)
#    Conjugaison.create(infinitif: 'avere', essais: 20, detail: Marshal.dump(@conj))
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