class HqNetconnection < ActiveRecord::Base
  has_many :hq_connected_nics, :dependent => :destroy
  has_many :hq_nics, :through => :hq_connected_nics
  
  after_save :save_hq_connected_nics
  validates_associated :hq_connected_nics
  
  
  def self.new_connection(nic_one, nic_two)
    newcon = HqNetconnection.new
    newcon.hq_connected_nics.build
    
    unless connic_one = HqConnectedNic.find_by_hq_nic_id(nic_one.id)
      connic_one = HqConnectedNic.create(:hq_nic_id => nic_one.id)
    end
    
    unless connic_two = HqConnectedNic.find_by_hq_nic_id(nic_two.id)
      connic_two = HqConnectedNic.create(:hq_nic_id => nic_two.id)
    end
    
    newcon.hq_connected_nics = [connic_one, connic_two]
    
    
    return newcon
  end
  
  
  private 
  
  def save_hq_connected_nics
    hq_connected_nics.each do |hq_connected_nic|
      hq_connected_nic.save(false)
    end
  end
  
end
