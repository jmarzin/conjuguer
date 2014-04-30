class SupprimeDetailEtCompteursDeConjugaisons < ActiveRecord::Migration
  change_table :conjugaisons do |t|
    t.remove :detail, :compteurs
  end
end
