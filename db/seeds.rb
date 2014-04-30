# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Dir.foreach('db/verbes') do |f|
liste = ['avere','lavorare','temere','credere','servire','finire','essere','venire','dovere','potere',\
  'volere','sapere','stare','andare','dare','fare','dire','udire','uscire']
liste.each do |f|
  @c = Conjugaison.create(infinitif: f, verbe: YAML.load(IO.read('db/verbes/'+f+'.yml')))
  @c.essais_verbe = 0
  @c.verbe.compteurs.each {|e| @c.essais_verbe += e}
  @c.save!
end
