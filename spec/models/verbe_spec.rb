require_relative '../spec_helper'

describe "Le verbe avere" do
  before(:each) do
    @avere = FactoryGirl.build(:avere)
  end
#  it "sauve le verbe avere" do
#    expect(IO.binwrite('db/avere.bin',Marshal.dump(@avere.verbe))).to be_true
#  end
  it "a comme infinitif avere" do
    expect(@avere.verbe.inf).to eq("avere")
  end
  it "a comme participe présent avente" do
    expect(@avere.verbe.ppres).to eq("avente")
  end
  it "a comme participe passé avuto" do
    expect(@avere.verbe.ppass).to eq('avuto')
  end
  it "a comme gérondif avendo" do
    expect(@avere.verbe.ger).to eq('avendo')
  end
  it "a un mode indicatif" do
    expect(@avere.verbe.ind).to be_a_kind_of(Mode)
  end
  it "a un présent de l'indicatif" do
    expect(@avere.verbe.ind.pres).to be_a_kind_of(Temps)
  end
  it "le présent de l'indicatif se conjugue ho hai ha abbiamo avete hanno" do
    expect(@avere.verbe.ind.pres.to_s).to eq('ho hai ha abbiamo avete hanno')
  end
  it "la 1ère personne du singulier du présent de l'indicatif est ho" do
    expect(@avere.verbe.ind.pres.s1).to eq('ho')
  end
  it "la 2ème personne du singulier du présent de l'indicatif est hai" do
    expect(@avere.verbe.ind.pres.s2).to eq('hai')
  end
  it "la 3ème personne du singulier du présent de l'indicatif est ha" do
    expect(@avere.verbe.ind.pres.s3).to eq('ha')
  end
  it "la 1ère personne du pluriel du présent de l'indicatif est abbiamo" do
    expect(@avere.verbe.ind.pres.p1).to eq('abbiamo')
  end
  it "la 2ème personne du pluriel du présent de l'indicatif est avete" do
    expect(@avere.verbe.ind.pres.p2).to eq('avete')
  end
  it "la 3ème personne du pluriel du présent de l'indicatif est hanno" do
    expect(@avere.verbe.ind.pres.p3).to eq('hanno')
  end
  it "a un imparfait de l'indicatif" do
    expect(@avere.verbe.ind.imp).to be_a_kind_of(Temps)
  end
  it "l'imparfait de l'indicatif se conjugue avevo avevi aveva avevamo avevate avevano" do
    expect(@avere.verbe.ind.imp.to_s).to eq('avevo avevi aveva avevamo avevate avevano')
  end
  it "a un parfait de l'indicatif" do
    expect(@avere.verbe.ind.parf).to be_a_kind_of(Temps)
  end
  it "le parfait de l'indicatif se conjugue ebbi avesti ebbe avemmo aveste ebbero" do
    expect(@avere.verbe.ind.parf.to_s).to eq('ebbi avesti ebbe avemmo aveste ebbero')
  end
  it "a un futur de l'indicatif" do
    expect(@avere.verbe.ind.fut).to be_a_kind_of(Temps)
  end
  it "le futur de l'indicatif se conjugue avrò avrai avrà avremo avrete avranno" do
    expect(@avere.verbe.ind.fut.to_s).to eq('avrò avrai avrà avremo avrete avranno')
  end
  it "a un mode subjonctif" do
    expect(@avere.verbe.sub).to be_a_kind_of(Mode)
  end
  it 'a un présent du subjonctif' do
    expect(@avere.verbe.sub.pres).to be_a_kind_of(Temps)
  end
  it "la présent du subjonctif se conjugue abbia abbia abbia abbiamo abbiate abbiano" do
    expect(@avere.verbe.sub.pres.to_s).to eq('abbia abbia abbia abbiamo abbiate abbiano')
  end
  it 'a un imparfait du subjonctif' do
    expect(@avere.verbe.sub.imp).to be_a_kind_of(Temps)
  end
  it "l'imparfait du subjonctif se conjugue avessi avessi avesse avessimo aveste avessero" do
    expect(@avere.verbe.sub.imp.to_s).to eq('avessi avessi avesse avessimo aveste avessero')
  end
  it "a un mode conditionnel" do
    expect(@avere.verbe.cond).to be_a_kind_of(Mode)
  end
  it "a un présent du conditionnel" do
    expect(@avere.verbe.cond.pres).to be_a_kind_of(Temps)
  end
  it "le présent du conditionnel se conjugue avrei avresti avrebbe avremmo avreste avrebbero" do
    expect(@avere.verbe.cond.pres.to_s).to eq('avrei avresti avrebbe avremmo avreste avrebbero')
  end
  it "a un mode impératif qu'on traite comme un temps" do
    expect(@avere.verbe.imp).to be_a_kind_of(Temps)
  end
  it "l'impératif se conjugue --- abbi abbia abbiamo abbiate abbiano" do
    expect(@avere.verbe.imp.to_s).to eq('--- abbi abbia abbiamo abbiate abbiano')
  end
  it "une méthode permet de créer le champ d'affichage" do
    expect(@avere.verbe.show("ind.pres.s1")).to eq("Io ho (#{Conjugaison::MAX_ESSAIS})")
  end
  it "on utilise la fonction rand pour tirer au sort" do
    min = 100
    max = 0
    (1..1000).each do |i|
      j = (rand * 100).ceil
      min = j if j < min
      max = j if j > max
    end
    expect(min).to eq(1)
    expect(max).to eq(100)
  end
end
