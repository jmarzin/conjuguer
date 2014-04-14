class CreateConjugaisons < ActiveRecord::Migration
  def change
    create_table :conjugaisons do |t|
      t.string :infinitif
      t.integer :essais
      t.binary :detail

      t.timestamps
    end
  end
end
