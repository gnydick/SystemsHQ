class CreateHqDiskarrays < ActiveRecord::Migration
  def self.up
    create_table :hq_diskarrays do |t|
      t.integer :hq_site_id
      t.integer :hq_san_id
      t.integer :hq_rack_id
      t.string :name
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :hq_diskarrays
  end
end
