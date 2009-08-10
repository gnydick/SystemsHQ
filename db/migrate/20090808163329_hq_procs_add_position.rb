class HqProcsAddPosition < ActiveRecord::Migration
  def self.up
    add_column :hq_procs, :position, :integer
  end

  def self.down
  end
end
