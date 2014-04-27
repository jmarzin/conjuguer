FactoryGirl.define do
  factory :conjugaison do
    infinitif 'avere'
    essais_verbe    Verbe::Formes.size * Conjugaison::Max_essais
#    detail    IO.binread('db/avere.bin')
#    compteurs Array.new(Verbe::Formes.size,Conjugaison::Max_essais)

    trait   :avere do
#      detail  {
#        @conj = ['avere','avente','avuto','avendo']
#        @conj << Mode.new([Temps.new(['','','ho', 'hai','ha','abbiamo','avete','hanno']),\
#          Temps.new(%w(av e vo vi va vamo vate vano)),\
#          Temps.new(['','','ebbi','avesti','ebbe','avemmo','aveste','ebbero']),\
#          Temps.new(['av','','rò','rai','rà','remo','rete','ranno'])])
#        @conj << Mode.new([Temps.new(['','','abbia','abbia','abbia','abbiamo','abbiate','abbiano']),\
#          Temps.new(['av','','essi','essi','esse','essimo','este','essero'])])
#        @conj << Mode.new([Temps.new(['av','','rei','resti','rebbe','remmo','reste','rebbero'])])
#        @conj << Temps.new(['','','---','abbi','abbia','abbiamo','abbiate','abbiano'])
#        Marshal.dump(@conj)
#      }
      verbe {
        @conj = ['avere','avente','avuto','avendo']
        @conj << Mode.new([Temps.new(['','','ho', 'hai','ha','abbiamo','avete','hanno']),\
          Temps.new(%w(av e vo vi va vamo vate vano)),\
          Temps.new(['','','ebbi','avesti','ebbe','avemmo','aveste','ebbero']),\
          Temps.new(['av','','rò','rai','rà','remo','rete','ranno'])])
        @conj << Mode.new([Temps.new(['','','abbia','abbia','abbia','abbiamo','abbiate','abbiano']),\
          Temps.new(['av','','essi','essi','esse','essimo','este','essero'])])
        @conj << Mode.new([Temps.new(['av','','rei','resti','rebbe','remmo','reste','rebbero'])])
        @conj << Temps.new(['','','---','abbi','abbia','abbiamo','abbiate','abbiano'])
        Verbe.new({conj: @conj, compteurs: Array.new(Verbe::Formes.size,Conjugaison::Max_essais)})
      }
    end
    factory :avere,    traits: [:avere]
  end
end