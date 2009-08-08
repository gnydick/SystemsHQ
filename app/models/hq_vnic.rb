class HqVnic < ActiveRecord::Base
  
  
  @@screen_name = 'Virtual Network Interface'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  
  def hq_available_nics
    hq_vserver. hq_server.hq_nics
  end
  
  def hq_bridge
    hq_nic
  end
  
  def self.excluded_from_reflected
    Array.new
  end
  
  belongs_to :hq_vserver
  
  belongs_to :hq_nic, :foreign_key => :hq_bridge_id
  
  validates_presence_of :name
  
  
  
  def self.excluded_from_reflected
    Array.new
  end
  
  
  
  
end
