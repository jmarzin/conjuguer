# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vocabulaire do
    mot_directeur 'mot'
    francais 'texte français'
    compteur Vocabulaire::MAX_ESSAIS
    italien 'texte italien'
  end
end
