class CreateFlocks < ActiveRecord::Migration
  def self.up
    create_table :flocks do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :flocks
  end
end
