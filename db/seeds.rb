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
['papier','les papiers (état civil)',8,'i documenti'],
['carte',"une carte d'identité",8,"una carta d'identità"],
['passeport','un passeport',8,'un passaporto'],
['prénom','un prénom',8,'un nome'],
['nom','un nom de famille',8,'un cognome'],
['surnom','un surnom',8,'un nomignolo/un soprannome'],
['sexe','un sexe (état civil)',8,'un sesso'],
['homme','un homme',8,'un uomo'],
['femme','une femme',8,'una donna'],
['adresse',"une adresse (postale)",8,'un indirizzo'],
['coordonnée','les coordonnées (état civil)',8,'i recàpiti'],
['âge','un âge (état civil)',8,"un'età"],
['naissance','une date de naissance',8,'una data di nàscita'],
['naissance','un lieu de naissance',8,'un luogo di nàscita'],
['naissance','né à',8,'nato a'],
['marié','marié',8,'sposato/coniugato'],
['célibataire','un célibataire',8,'un single/un célibe'],
['célibataire','une célibataire',8,'una single/una nùbile'],
['veuf','veuf',8,'védovo'],
['séparé','séparé',8,'separato'],
['divorcé','divorcé',8,'divorziato'],
['appeler',"s'appeler",8,'chiamarsi'],
['présenter','se présenter',8,'presentarsi'],
['fille','une vieille fille',8,'una zitella'],
['garçon','un vieux garçon',8,'uno scàpolo'],
['taille','une taille (aspect physique)',8,"un'altezza"],
['poids','un poids',8,'un peso'],
['oeil','un oeil, les yeux',8,'un òcchio, gli occhi'],
['cheveux','les cheveux',8,'i capelli'],
['moustache','la moustache',8,'i baffi'],
['barbe','une barbe',8,'una barba'],
['grand','grand (taille)',8,'alto'],
['petit','petit (taille)',8,'basso'],
['élancé','élancé',8,'slanciato'],
['trapu','trapu',8,'tozzo/tarchiato'],
['gros','gros',8,'grasso'],
['maigre','maigre',8,'magro'],
['musclé','musclé',8,'muscoloso'],
['costaud','costaud',8,'robusto'],
['mince','mince',8,'snello'],
['foncé','foncé',8,'scuro'],
['clair','clair',8,'claro'],
['noir','noir',8,'nero'],
['brun','brun',8,'moro'],
['châtain','châtain',8,'castano'],
['blond','blond',8,'biondo'],
['roux','roux',8,'rosso'],
['long','long',8,'lungo'],
['court','court',8,'corto'],
['poilu','poilu',8,'peloso'],
['chauve','chauve',8,'calvo/pelato'],
['beau','beau',8,'bello'],
['joli','joli/mignon',8,'carino'],
['séduisant','séduisant',8,'attraente'],
['moche','moche',8,'brutto'],
['jeune','jeune',8,'giòvane'],
['vieux','vieux',8,'vécchio'],
['peser','peser',8,'pesare'],
['grossir','grossir',8,'ingrassare'],
['maigrir','maigrir',8,'dimagrire'],
['ressembler à','somigliare a/assomigliare a',8,''],
['individu','un individu',8,'un indivìduo'],
['caractère','un caractère',8,'un caràttere'],
['tempérament','un tempérament',8,"un'ìndole"],
['qualité','une qualité',8,'una qualità/una virtù'],
['défaut','un défaut',8,'un difetto'],
['manie','une manie',8,'una mania'],
['extraverti','extraverti',8,'estroverso'],
['optimiste','optimiste',8,'ottimista'],
['joyeux','joyeux',8,'allegro'],
['sympathique','sympatique',8,'simpàtico'],
['agréable','agréable',8,'gradévole'],
['amusant','amusant',8,'divertente'],
['drôle','drôle',8,'buffo'],
['doux','doux',8,'dolce'],
['calme','calme',8,'calmo'],
['sincère','sincère',8,'sincero'],
['généreux','généreux',8,'generoso'],
['serviable','serviable',8,'serviziévole'],
['élevé','bien élevé',8,'educato'],
['raffiné','raffiné',8,'raffinato'],
['introverti','introverti',8,'introverso'],
['timide','timide',8,'tìmido'],
['taciturne','taciturne',8,'taciturno'],
['pessimiste','pessimiste',8,'pessimista'],
['antipathique','antipathique',8,'antipàtico'],
['désagréable','désagréable',8,'sgradévole'],
['ennuyeux','ennuyeux',8,'noioso'],
['colérique','colérique',8,'collérico'],
['intolérant','intolérant/intransigeant',8,'insofferente'],
['hypocrite','hypocrite',8,'ipòcrita'],
['menteur','menteur',8,'bugiardo'],
['radin','radin',8,'tìrchio'],
['égoïste','égoïste',8,'egoista'],
['vulgaire','vulgaire',8,'volgare'],
['susceptible','susceptible',8,'permaloso'],
['vaniteux','vaniteux',8,'vanitoso'],
['dépensier','dépensier',8,'spendaccione'],
['sembler','sembler',8,'sembrare'],
['comporter','se comporter',8,'comportarsi']
]
# 17
liste.each do |m|
  @m = Vocabulaire.create(mot_directeur: m[0], francais: m[1], compteur: m[2], italien: m[3])
  @m.save
end
