class AddMflPlayerIdToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :mfl_player_id, :integer
  end

  def self.down
    remove_column :players, :mfl_player_id
  end
end
