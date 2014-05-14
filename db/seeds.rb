# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Conjugaison.destroy_all
Vocabulaire.destroy_all
Erreur.destroy_all
v=Verbe.new('avere')

#liste = ['avere','lavorare','temere','credere','servire','finire','essere','venire','dovere','potere',\
#  'volere','sapere','stare','andare','dare','fare','dire','udire','uscire']
liste = ['lavorare']
liste.each do |f|
  @c = Conjugaison.create(infinitif: f, verbe: YAML.load(IO.read('db/verbes/'+f+'.yml')))
  @c.essais_verbe = 0
  @c.verbe.compteurs.each {|e| @c.essais_verbe += e}
  @c.save
end
liste = [\
['papier','les papiers (état civil)',20,'i documenti'],
['carte',"une carte d'identité",20,"una carta d'identità"],
['passeport','un passeport',20,'un passaporto'],
['prénom','un prénom',20,'un nome'],
['nom','un nom de famille',20,'un cognome'],
['surnom','un surnom',20,'un nomignolo/un soprannome'],
['sexe','un sexe (état civil)',20,'un sesso'],
['homme','un homme',20,'un uomo'],
['femme','une femme',20,'una donna'],
['adresse',"une adresse (postale)",20,'un indirizzo'],
['coordonnée','les coordonnées (état civil)',20,'i recàpiti'],
['âge','un âge (état civil)',20,"un'età"],
['naissance','une date de naissance',20,'una data di nàscita'],
['naissance','un lieu de naissance',20,'un luogo di nàscita'],
['naissance','né à',20,'nato a'],
['marié','marié',20,'sposato/coniugato'],
['célibataire','un célibataire',20,'un single/un célibe'],
['célibataire','une célibataire',20,'una single/una nùbile'],
['veuf','veuf',20,'védovo'],
['séparé','séparé',20,'separato'],
['divorcé','divorcé',20,'divorziato'],
['appeler',"s'appeler",20,'chiamarsi'],
['présenter','se présenter',20,'presentarsi'],
['fille','une vieille fille',20,'una zitella'],
['garçon','un vieux garçon',20,'uno scàpolo'],
['taille','une taille (aspect physique)',20,"un'altezza"],
['poids','un poids',20,'un peso'],
['oeil','un oeil, les yeux',20,'un òcchio, gli occhi'],
['cheveux','les cheveux',20,'i capelli'],
['moustache','la moustache',20,'i baffi'],
['barbe','une barbe',20,'una barba'],
['grand','grand (taille)',20,'alto'],
['petit','petit (taille)',20,'basso'],
['élancé','élancé',20,'slanciato'],
['trapu','trapu',20,'tozzo/tarchiato'],
['gros','gros',20,'grasso'],
['maigre','maigre',20,'magro'],
['musclé','musclé',20,'muscoloso'],
['costaud','costaud',20,'robusto'],
['mince','mince',20,'snello'],
['foncé','foncé',20,'scuro'],
['clair','clair',20,'claro'],
['noir','noir',20,'nero'],
['brun','brun',20,'moro'],
['châtain','châtain',20,'castano'],
['blond','blond',20,'biondo'],
['roux','roux',20,'rosso'],
['long','long',20,'lungo'],
['court','court',20,'corto'],
['poilu','poilu',20,'peloso'],
['chauve','chauve',20,'calvo/pelato'],
['beau','beau',20,'bello'],
['joli','joli/mignon',20,'carino'],
['séduisant','séduisant',20,'attraente'],
['moche','moche',20,'brutto'],
['jeune','jeune',20,'giòvane'],
['vieux','vieux',20,'vécchio'],
['peser','peser',20,'pesare'],
['grossir','grossir',20,'ingrassare'],
['maigrir','maigrir',20,'dimagrire'],
['ressembler à','somigliare a/assomigliare a',20,''],
['individu','un individu',20,'un indivìduo'],
['caractère','un caractère',20,'un caràttere'],
['tempérament','un tempérament',20,"un'ìndole"],
['qualité','une qualité',20,'una qualità/una virtù'],
['défaut','un défaut',20,'un difetto'],
['manie','une manie',20,'una mania'],
['extraverti','extraverti',20,'estroverso'],
['optimiste','optimiste',20,'ottimista'],
['joyeux','joyeux',20,'allegro'],
['sympathique','sympatique',20,'simpàtico'],
['agréable','agréable',20,'gradévole'],
['amusant','amusant',20,'divertente'],
['drôle','drôle',20,'buffo'],
['doux','doux',20,'dolce'],
['calme','calme',20,'calmo'],
['sincère','sincère',20,'sincero'],
['généreux','généreux',20,'generoso'],
['serviable','serviable',20,'serviziévole'],
['élevé','bien élevé',20,'educato'],
['raffiné','raffiné',20,'raffinato'],
['introverti','introverti',20,'introverso'],
['timide','timide',20,'tìmido'],
['taciturne','taciturne',20,'taciturno'],
['pessimiste','pessimiste',20,'pessimista'],
['antipathique','antipathique',20,'antipàtico'],
['désagréable','désagréable',20,'sgradévole'],
['ennuyeux','ennuyeux',20,'noioso'],
['colérique','colérique',20,'collérico'],
['intolérant','intolérant/intransigeant',20,'insofferente'],
['hypocrite','hypocrite',20,'ipòcrita'],
['menteur','menteur',20,'bugiardo'],
['radin','radin',20,'tìrchio'],
['égoïste','égoïste',20,'egoista'],
['vulgaire','vulgaire',20,'volgare'],
['susceptible','susceptible',20,'permaloso'],
['vaniteux','vaniteux',20,'vanitoso'],
['dépensier','dépensier',20,'spendaccione'],
['sembler','sembler',20,'sembrare'],
['comporter','se comporter',20,'comportarsi']
]
# 17
liste.each do |m|
  @m = Vocabulaire.create(mot_directeur: m[0], francais: m[1], compteur: m[2], italien: m[3])
  @m.save
end