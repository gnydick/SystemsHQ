class HqSlicesAddSize < ActiveRecord::Migration
  def self.up
    add_column :hq_slices, :size, :integer
  end

  def self.down
    remove_column :hq_slices, :size
  end
end
