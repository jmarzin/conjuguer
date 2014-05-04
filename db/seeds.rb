# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


liste = ['avere','lavorare','temere','credere','servire','finire','essere','venire','dovere','potere',\
  'volere','sapere','stare','andare','dare','fare','dire','udire','uscire']
liste.each do |f|
  @c = Conjugaison.create(infinitif: f, verbe: YAML.load(IO.read('db/verbes/'+f+'.yml')))
  @c.essais_verbe = 0
  @c.verbe.compteurs.each {|e| @c.essais_verbe += e}
  @c.save
end
liste = [\
['tàvolo','la table',20,'il tàvolo'],
['bellezza','la beauté',20,'la bellezza'],
['città','la ville',20,'la città'],
['vedere','voir',20,'vedere'],
['piacévole','agréable',20,'piacévole'],
['ordinare','ils ordonnent',20,'òrdinano'],
['ordinare','ordonne-le-moi',20,'òrdinamelo'],
['ordinare','ordonne-le-moi là',20,'òrdinamicelo'],
['leggerezza','la légèreté',20,'la leggerezza'],
['amabile','aimable',20,'amàbile'],
['giustìzia','la justice',20,'la giustìzia'],
['lodévole','louable',20,'lodévole'],
['astròlogo','un astrologue',20,'un astròlogo'],
['geògrafo','le géographe',20,'il geògrafo'],
['àncora','une ancre',20,"un'àncora"],
['prìncipi','les princes',20,'i prìncipi'],
['principi','les principes',20,'i principi'],
['pàttino','le patin',20,'il pàttino'],
['pattino','le pédalo',20,'il pattino'],
['cuculo','le coucou',20,'il cuculo'],
['microbi','les microbes',20,'i mìcrobi']
]
# 15
liste.each do |m|
  @m = Vocabulaire.create(mot_directeur: m[0], francais: m[1], compteur: m[2], italien: m[3])
  @m.save
end