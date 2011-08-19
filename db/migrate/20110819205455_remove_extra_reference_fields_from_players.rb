class RemoveExtraReferenceFieldsFromPlayers < ActiveRecord::Migration
  def self.up
    remove_column :players, :draft_id
    remove_column :players, :team_id
  end

  def self.down
    add_column :players, :draft_id, :integer
    add_column :players, :team_id, :integer
  end
end
