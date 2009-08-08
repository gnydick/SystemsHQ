class HqNic < ActiveRecord::Base
  has_one :hq_connected_nic
  has_one :hq_netconnection, :through => :hq_connected_nic
  
  belongs_to :hq_nichaving, :polymorphic => true
  
  has_many :hq_vlan_assignments
  has_many :hq_vlans, :through => :hq_vlan_assignments
  
  validates_presence_of :name
  validates_associated :hq_netconnection
  
  
  @@screen_name = 'Network Interface'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  
  def hq_remote_nic_id=(hq_nic_id)
    if hq_netconnection
      HqNetconnection.find(hq_netconnection.id).destroy
    end
    hq_netconnection = HqNetconnection.new
    if HqNic.all.collect(&:id).include?(hq_nic_id.to_i)
      hq_netconnection = HqNetconnection.new_connection(self, HqNic.find(hq_nic_id))
    end
    hq_netconnection.save
    
    
  end
  
  
  
  def hq_remote_nic
    if hq_netconnection
      if nic = hq_netconnection.hq_connected_nics.find(:first, :conditions => "id <> #{hq_connected_nic.id}").hq_nic
        return nic
      else
        return nil
      end
    else
      return nil
    end
  end
  
  
  def hq_remote_nic_id
    if hq_netconnection
      if nic = hq_netconnection.hq_connected_nics.find(:first, :conditions => "id <> #{hq_connected_nic.id}").hq_nic
        return nic.id
      else
        return nil
      end
    else
      return nil
    end
  end
  
  
  
  
  
  def create_hq_netconnection=(hq_nic_id)
    
    hq_netconnection = HqNetconnection.new_connection(self, HqNic.find(hq_nic_id))
    hq_netconnection.save
  end
  
  
  
  def self.excluded_from_reflected
    Array.new
  end
  
  
  
  def hq_nichaving_label
    hq_nichaving.name+' - '+self.name
  end
  
  
  
  private
  def save_hq_netconnection
    hq_netconnection.save(false)
  end
  
end
