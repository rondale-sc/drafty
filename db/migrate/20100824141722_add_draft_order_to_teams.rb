class AddDraftOrderToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :draft_order, :integer
  end

  def self.down
    remove_column :teams, :draft_order
  end
end
