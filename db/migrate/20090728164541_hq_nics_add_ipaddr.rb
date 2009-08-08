class HqNicsAddIpaddr < ActiveRecord::Migration
  def self.up
    add_column(:hq_nics, :ipaddr, :string)
  end

  def self.down
    remove_column(:hq_nics, :ipaddr)
  end
end
