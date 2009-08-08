class HqSlicesAddMountpoint < ActiveRecord::Migration
  def self.up
    add_column :hq_slices, :mountpoint, :string
  end

  def self.down
    remove_column :hq_slices, :mountpoint
  end
end
