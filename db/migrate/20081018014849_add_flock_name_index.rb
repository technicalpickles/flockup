class AddFlockNameIndex < ActiveRecord::Migration
  def self.up
    add_index :flocks, :name
  end

  def self.down
    remove_index :flocks, :name
  end
end
