class CreateHqVlanAssignments < ActiveRecord::Migration
  def self.up
    create_table :hq_vlan_assignments do |t|
      t.integer :hq_nic_id
      t.integer :hq_vlan_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_vlan_assignments
  end
end
