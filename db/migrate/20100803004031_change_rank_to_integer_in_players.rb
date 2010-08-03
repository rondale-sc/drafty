class ChangeRankToIntegerInPlayers < ActiveRecord::Migration
  def self.up
    change_column :players, :rank, :integer
  end

  def self.down
    change_column :players, :rank, :string
  end
end
