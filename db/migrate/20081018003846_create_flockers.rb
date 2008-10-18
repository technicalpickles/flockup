class CreateFlockers < ActiveRecord::Migration
  def self.up
    create_table :flockers do |t|
      t.string :twitter_username

      t.timestamps
    end
  end

  def self.down
    drop_table :flockers
  end
end
