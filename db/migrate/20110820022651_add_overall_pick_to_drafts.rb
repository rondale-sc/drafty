class AddOverallPickToDrafts < ActiveRecord::Migration
  def self.up
    add_column :drafts, :overall_pick, :integer
  end

  def self.down
    remove_column :drafts, :overall_pick
  end
end
