class CreateTeamUserRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :team_user_roles do |t|
      t.references :team_user, null: false, foreign_key: true
      t.references :team_role, null: false, foreign_key: true
      t.timestamps
    end
  end
end
