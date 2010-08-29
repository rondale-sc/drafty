class AddExtraAdpFieldsToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :nfl_team, :string
    add_column :players, :average_pick, :float
    add_column :players, :minimum_pick, :integer
    add_column :players, :maximum_pick, :integer
    add_column :players, :url, :string
    add_column :players, :bye_week, :integer
  end

  def self.down
    remove_column :players, :bye_week
    remove_column :players, :url
    remove_column :players, :maximum_pick
    remove_column :players, :minimum_pick
    remove_column :players, :average_pick
    remove_column :players, :nfl_team
  end
end
