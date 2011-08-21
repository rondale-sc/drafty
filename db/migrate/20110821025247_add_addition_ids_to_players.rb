class AddAdditionIdsToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :fleaflicker_id, :integer
    add_column :players, :stats_id, :integer
    add_column :players, :fanball_id, :integer
    add_column :players, :cbs_id, :integer
  end

  def self.down
    remove_column :players, :cbs_id
    remove_column :players, :fanball_id
    remove_column :players, :stats_id
    remove_column :players, :fleaflicker_id
  end
end
