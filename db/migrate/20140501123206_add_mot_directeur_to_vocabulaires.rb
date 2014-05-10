class AddMotDirecteurToVocabulaires < ActiveRecord::Migration
  def change
    add_column :vocabulaires, :mot_directeur, :string
    add_index :vocabulaires, :mot_directeur
  end
end
