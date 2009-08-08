class CreateHqRacks < ActiveRecord::Migration
  def self.up
    create_table :hq_racks do |t|
      t.integer :hq_site_id      
      t.integer :hq_cage_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_racks
  end
end
