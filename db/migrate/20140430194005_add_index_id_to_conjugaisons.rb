class AddIndexIdToConjugaisons < ActiveRecord::Migration
  def change
    add_index :conjugaisons, :id
  end
end
