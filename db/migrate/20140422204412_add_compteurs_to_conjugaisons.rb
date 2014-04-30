class AddCompteursToConjugaisons < ActiveRecord::Migration
  def change
    add_column :conjugaisons, :compteurs, :text
  end
end
