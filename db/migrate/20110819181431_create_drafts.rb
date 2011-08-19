class CreateDrafts < ActiveRecord::Migration
  def self.up
    create_table :drafts do |t|
      t.integer :team_id
      t.integer :player_id
      t.datetime :draft_time

      t.timestamps
    end
  end

  def self.down
    drop_table :drafts
  end
end
