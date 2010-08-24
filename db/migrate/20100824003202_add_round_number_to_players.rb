class AddRoundNumberToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :pick, :integer
  end

  def self.down
    remove_column :players, :pick
  end
end
