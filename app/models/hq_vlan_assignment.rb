class HqVlanAssignment < ActiveRecord::Base
  
  belongs_to :hq_vlan
  belongs_to :hq_nic
  

  
  
  @@screen_name = 'VLAN Assignment'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
 
  
  
  def self.excluded_from_reflected
    Array.new
  end
  
  
  
  
end
