class RenameTeamToNflTeamOnPlayers < ActiveRecord::Migration
  def self.up
    rename_column :players, :team, :nfl_team
  end

  def self.down
    rename_column :players, :nfl_team, :team
  end
end
