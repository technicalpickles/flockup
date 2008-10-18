class AddFlockerStatus < ActiveRecord::Migration
  def self.up
    change_table(:flockers) do |t|
      t.string :status
    end
  end

  def self.down
    change_table(:flockers) do |t|
      t.remove :status
    end
  end
end
