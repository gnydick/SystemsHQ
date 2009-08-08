class CreateHqVlans < ActiveRecord::Migration
  def self.up
    create_table :hq_vlans do |t|
      t.string :tag
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_vlans
  end
end
