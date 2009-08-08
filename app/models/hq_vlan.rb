class HqVlan < ActiveRecord::Base
  
  @@screen_name = 'VLAN'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  def self.excluded_from_reflected
    return [:hq_vlan_assignments]
  end
  
  
  
  
  
  has_many :hq_vlan_assignments, :dependent => :destroy
  has_many :hq_nics,  :through => :hq_vlan_assignments
  
  
  validates_associated  :hq_vlan_assignments
  
  after_update :save_hq_vlan_assignments
  
  
 def assigned_hq_nic=(assigned_hq_nics)
   hq_nics.clear
    hq_nics.each do |hq_nic|
      hq_nics.delete(hq_nic) unless assigned_hq_nics.include?(hq_nic.id)
    end
    assigned_hq_nics.each do |assigned_hq_nic|
      hq_nics << HqNic.find(assigned_hq_nic) unless hq_nics.collect(&:id).include?(assigned_hq_nic)
    end
  end    
  
  private
  def save_hq_vlan_assignments
    hq_vlan_assignments.each do |hq_vlan_assignment|
      hq_vlan_assignment.save(false)
    end
  end
  
  
  
end
