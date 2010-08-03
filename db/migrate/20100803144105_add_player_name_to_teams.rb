class AddPlayerNameToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :player_name, :string
  end

  def self.down
    remove_column :teams, :player_name, :string
  end
end
