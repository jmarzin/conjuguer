class AddVerbeToConjugaison < ActiveRecord::Migration
  def change
    add_column :conjugaisons, :verbe, :text
  end
end
