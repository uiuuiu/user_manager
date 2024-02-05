class CreateTeamRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :team_roles do |t|
      t.references :team, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.timestamps
    end
  end
end
