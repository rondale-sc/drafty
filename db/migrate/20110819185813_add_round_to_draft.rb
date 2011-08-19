class AddRoundToDraft < ActiveRecord::Migration
  def self.up
    add_column :drafts, :round, :integer
  end

  def self.down
    remove_column :drafts, :round
  end
end
