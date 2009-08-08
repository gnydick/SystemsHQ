class CreateHqVnics < ActiveRecord::Migration
  def self.up
    create_table :hq_vnics do |t|
      t.integer :hq_vserver_id
      t.integer :hq_bridge_id
      t.string :name
      t.string :ipaddr

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_vnics
  end
end
