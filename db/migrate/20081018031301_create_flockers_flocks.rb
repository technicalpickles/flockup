class CreateFlockersFlocks < ActiveRecord::Migration
  def self.up
    create_table(:flockers_flocks, :id => false) do |t|
      t.references :flock
      t.references :flocker
    end
  end

  def self.down
    drop_table(:flockers_flocks)
  end
end
