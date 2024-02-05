class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.text :description
      t.json :permissions
      t.bigint :team_id, null: true
      t.timestamps
    end
  end
end
