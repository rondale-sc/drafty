class RemoveRankFromPlayers < ActiveRecord::Migration
  def self.up
    remove_column :players, :rank
  end

  def self.down
    add_column :players, :rank, :integer
  end
end
