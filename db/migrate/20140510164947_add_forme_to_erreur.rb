class AddFormeToErreur < ActiveRecord::Migration
  def change
    add_column :erreurs, :forme, :string
  end
end
