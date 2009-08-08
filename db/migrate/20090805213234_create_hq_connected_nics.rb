class CreateHqConnectedNics < ActiveRecord::Migration
  def self.up
    create_table :hq_connected_nics do |t|
      t.integer :hq_netconnection_id
      t.integer :hq_nic_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_connected_nics
  end
end
