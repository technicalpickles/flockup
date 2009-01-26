class RemoveNotification < ActiveRecord::Migration
  def self.up
    drop_table :notifications
  end

  def self.down
    create_table "notifications", :force => true do |t|
      t.integer  "flocker_id"
      t.text     "text"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
