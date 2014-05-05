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
['microbi','les microbes',20,'i mìcrobi'],
['legatorìa','la boutique de relieur',20,'la legatorìa'],
['gloria','la gloire',20,'la gloria'],
['sinfonìa','la symphonie',20,'la sinfonìa'],
['copia',"l'abondance",20,'la copia'],
['Tunisìa','la Tunisie',20,'la Tunisìa'],
['Libia','la Lybie',20,'la Libia'],
['Ungherìa','la Hongrie',20,'la Ungherìa'],
['Germania',"l'Allemagne",20,'la Germania'],
['tabaccherìa','le bureau de tabac',20,'la tabaccherìa'],
['ortografìa',"l'ortographe",20,"l'ortografìa"],
['geometrìa','la géométrie',20,'la geometrìa'],
['poesìa','la poésie',20,'la poesìa'],
['caramella','le bonbon',20,'la caramella'],
['canticchiare','chantonner',20,'canticchiare'],
['scàtola','la boîte',20,'la scàtola'],
['càndido','ingénu',20,'càndido'],
['candidamente','ingénument',20,'candidamente'],
['finale','final',20,'finale'],
['finalmente','finalement',20,'finalmente'],
['città','la ville',20,'la città'],
['virtù','la vertu',20,'la virtù'],
['così','ainsi',20,'così'],
['perché','pourquoi, parce que',20,'perché'],
['gilè','le gilet',20,'il gilè'],
['da','de, depuis',20,'da'],
['dì','le jour',20,'il dì'],
['di','de',20,'di'],
['e','et',20,'e'],
['là','là',20,'là'],
['la','la',20,'la'],
['lì','là',20,'lì'],
['né','ni',20,'né'],
['sì','oui, certes',20,'sì'],
['si','se (pronominal)',20,'si'],
['sé','soi',20,'sé'],
['se','si (conjonction)',20,'se']
]
# 17
liste.each do |m|
  @m = Vocabulaire.create(mot_directeur: m[0], francais: m[1], compteur: m[2], italien: m[3])
  @m.save
end