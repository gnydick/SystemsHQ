class HqNicsAddName < ActiveRecord::Migration
  def self.up
    add_column(:hq_nics, :name, :string)
  end

  def self.down
    remove_column(:hq_nics, :name)
  end
end
