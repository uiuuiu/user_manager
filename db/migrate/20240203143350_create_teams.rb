class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.text :description
      t.references :owner, null: false, foreign_key: {to_table: :users}
      t.timestamps
    end

    add_index :teams, :name, unique: true
  end
end
