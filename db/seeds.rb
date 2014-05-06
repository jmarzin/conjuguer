# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Conjugaison.destroy_all
Vocabulaire.destroy_all

liste = ['avere','lavorare','temere','credere','servire','finire','essere','venire','dovere','potere',\
  'volere','sapere','stare','andare','dare','fare','dire','udire','uscire']
liste.each do |f|
  @c = Conjugaison.create(infinitif: f, verbe: YAML.load(IO.read('db/verbes/'+f+'.yml')))
  @c.essais_verbe = 0
  @c.verbe.compteurs.each {|e| @c.essais_verbe += e}
  @c.save
end
liste = [\
['table','la table',20,'il tàvolo'],
['beauté','la beauté',20,'la bellezza'],
['ville','la ville',20,'la città'],
['voir','voir',20,'vedere'],
['agréable','agréable',20,'piacévole'],
['ordonner','ils ordonnent',20,'òrdinano'],
['ordonner','ordonne-le-moi',20,'òrdinamelo'],
['ordonner','ordonne-le-moi là',20,'òrdinamicelo'],
['légèreté','la légèreté',20,'la leggerezza'],
['aimable','aimable',20,'amàbile'],
['justice','la justice',20,'la giustìzia'],
['louable','louable',20,'lodévole'],
['astrologue','un astrologue',20,'un astròlogo'],
['géographe','le géographe',20,'il geògrafo'],
['ancre','une ancre',20,"un'àncora"],
['prince','les princes',20,'i prìncipi'],
['principe','les principes',20,'i principi'],
['patin','le patin',20,'il pàttino'],
['pédalo','le pédalo',20,'il pattino'],
['coucou','le coucou',20,'il cuculo'],
['microbe','les microbes',20,'i mìcrobi'],
['relieur','la boutique de relieur',20,'la legatorìa'],
['gloire','la gloire',20,'la gloria'],
['symphonie','la symphonie',20,'la sinfonìa'],
['abondance',"l'abondance",20,'la copia'],
['Tunisie','la Tunisie',20,'la Tunisìa'],
['Lybie','la Lybie',20,'la Libia'],
['Hongrie','la Hongrie',20,'la Ungherìa'],
['Allemagne',"l'Allemagne",20,'la Germania'],
['tabac','le bureau de tabac',20,'la tabaccherìa'],
['orthographe',"l'ortographe",20,"l'ortografìa"],
['geometrie','la géométrie',20,'la geometrìa'],
['poésie','la poésie',20,'la poesìa'],
['bonbon','le bonbon',20,'la caramella'],
['chantonner','chantonner',20,'canticchiare'],
['boîte','la boîte',20,'la scàtola'],
['ingénu','ingénu',20,'càndido'],
['ingénument','ingénument',20,'candidamente'],
['final','final',20,'finale'],
['finalement','finalement',20,'finalmente'],
['vertu','la vertu',20,'la virtù'],
['ainsi','ainsi',20,'così'],
['pourquoi','pourquoi, parce que',20,'perché'],
['gilet','le gilet',20,'il gilè'],
['depuis','de, depuis',20,'da'],
['jour','le jour',20,'il dì'],
['de','de',20,'di'],
['et','et',20,'e'],
['là','là',20,'là/lì'],
['la','la',20,'la'],
['ni','ni',20,'né'],
['oui','oui, certes',20,'sì'],
['se','se (pronominal)',20,'si'],
['soi','soi',20,'sé'],
['si','si (conjonction)',20,'se']
]
# 17
liste.each do |m|
  @m = Vocabulaire.create(mot_directeur: m[0], francais: m[1], compteur: m[2], italien: m[3])
  @m.save
end