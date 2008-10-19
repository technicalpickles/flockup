class AddHasManyIndexes < ActiveRecord::Migration
  def self.up
    add_index 'flockers_flocks', 'flock_id'
    add_index 'flockers_flocks', 'flocker_id'
  end

  def self.down
    remove_index 'flockers_flocks', 'flock_id'
    remove_index 'flockers_flocks', 'flocker_id'
  end
end
