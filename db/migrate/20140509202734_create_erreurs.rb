class CreateErreurs < ActiveRecord::Migration
  def change
    create_table :erreurs do |t|
      t.string :code
      t.integer :ref

      t.timestamps
    end
  end
end
