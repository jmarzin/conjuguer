class CreateVocabulaires < ActiveRecord::Migration
  def change
    create_table :vocabulaires do |t|
      t.string :francais
      t.string :italien
      t.integer :compteur
      t.index :francais
      t.index :compteur
      t.timestamps
    end
  end
end
