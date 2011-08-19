class ChangePickToDraftIdInPlayers < ActiveRecord::Migration
  def self.up
    rename_column :players, :pick, :draft_id
  end

  def self.down
    rename_column :players, :draft_id, :pick
  end
end
