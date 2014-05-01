# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vocabulaire do
    mot_directeur 'mot'
    francais 'texte français'
    compteur Vocabulaire::Max_essais
    italien 'texte italien'
  end
end
