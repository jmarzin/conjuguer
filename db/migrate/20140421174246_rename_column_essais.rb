class RenameColumnEssais < ActiveRecord::Migration
  def change
    rename_column :conjugaisons, :essais, :essais_verbe
  end
end
