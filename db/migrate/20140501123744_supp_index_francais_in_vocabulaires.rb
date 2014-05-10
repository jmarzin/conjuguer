class SuppIndexFrancaisInVocabulaires < ActiveRecord::Migration
  def change
    remove_index :vocabulaires, :francais
  end
end
