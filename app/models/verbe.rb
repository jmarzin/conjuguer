class Verbe

  FORMES = %w(
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
    Verbe::FORMES.find_index(string)
  end

  def initialize(conjugue)
    if conjugue.class == Hash
      @conj = conjugue[:conj]
      @compteurs = conjugue[:compteurs]
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
      @compteurs = Array.new(Verbe::FORMES.size,Conjugaison::MAX_ESSAIS)
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

  def compteurs
    @compteurs
  end

  def self.en_clair(string)
    case string
      when 'ger'
        texte = 'Gérondif '
      when 'ppass'
        texte = 'Participe passé '
      else
        case string[-2,2]
          when 's1'
            texte = '1ère p. sing. '
          when 's2'
            texte = '2ème p. sing. '
          when 's3'
            texte = '3ème p. sing. '
          when 'p1'
            texte = '1ère p. plur. '
          when 'p2'
            texte = '2ème p. plur. '
          else 'p3'
            texte = '3ème p. plur. '
        end
        case string[0..2]
          when 'imp'
            texte += 'impér. '
          else
            /\.(.*)\./.match(string)
            case $1
              when 'pres'
                texte += 'prés. '
              when 'imp'
                texte += 'imparf. '
              when 'parf'
                texte += 'parf. '
              else
                texte += 'fut. '
            end
            case string[0..2]
              when 'ind'
                texte += 'indic. '
              when 'sub'
                texte += 'subj. '
              else
                texte += 'cond. '
            end
        end
    end
    return texte += 'verbe '
  end

  def show(string)
    debut = string[0..2]
    texte = ''
    if %w(imp ger ppa).include?(debut)
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
        else
          texte += 'loro '
      end
    end
    texte += eval('self.'+string)
    essais = self.compteurs[Verbe.rang_forme(string)]
    texte += " (#{essais})" if essais != 0
    texte.capitalize
  end
end
