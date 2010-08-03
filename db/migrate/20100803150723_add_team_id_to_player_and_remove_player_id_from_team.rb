class AddTeamIdToPlayerAndRemovePlayerIdFromTeam < ActiveRecord::Migration
  def self.up
    add_column :players, :team_id, :integer
    remove_column :teams, :player_id
  end

  def self.down
     add_column :teams, :player_id, :integer
    remove_column :players, :team_id

  end
end
