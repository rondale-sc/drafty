class OnlyUseASingleNameInPlayers < ActiveRecord::Migration
  def self.up
    remove_column :players, :first_name
    remove_column :players, :last_name

    add_column    :players, :name, :string
  end

  def self.down
    add_column :players, :first_name, :string
    add_column :players, :last_name, :string
    remove_column :players, :name
  end
end
