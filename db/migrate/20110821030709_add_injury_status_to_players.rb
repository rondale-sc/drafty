class AddInjuryStatusToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :injury_status, :string
    add_column :players, :injury_details, :string
  end

  def self.down
    remove_column :players, :injury_details
    remove_column :players, :injury_status
  end
end
