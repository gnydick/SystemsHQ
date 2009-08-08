class HqSite < ActiveRecord::Base
  
  
  @@screen_name = 'Site'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end

  def self.excluded_from_reflected
    Array.new
  end
  
  has_many :hq_cages, :dependent => :destroy
  has_many :hq_racks
  has_many :hq_servers
  has_many :hq_switches
  has_many :hq_diskarrays
  
  validates_associated :hq_cages
  validates_presence_of :name
  
  after_update :save_hq_cages
  after_update :save_hq_switches
  after_update :save_hq_servers
  after_update :save_hq_diskarrays
  
  
  
 ######## Racks 
  def new_hq_rack_attributes=(hq_rack_attributes)
    hq_rack_attributes.each do |attributes|
      hq_racks.build(attributes)
    end
  end
  
  def existing_hq_rack_attributes=(hq_rack_attributes)
    hq_racks.reject(&:new_record?).each do |hq_rack|
      attributes = hq_rack_attributes[hq_rack.id.to_s]
      if attributes
        hq_rack.attributes = attributes
      else
        hq_racks.delete(hq_rack)
      end
    end
  end
  
  def save_hq_racks
    hq_racks.each do |hq_rack|
      hq_rack.save(false)
    end
  end
  ############    
 ######## Cages 
  def new_hq_cage_attributes=(hq_cage_attributes)
    hq_cage_attributes.each do |attributes|
      hq_cages.build(attributes)
    end
  end
  
  def existing_hq_cage_attributes=(hq_cage_attributes)
    hq_cages.reject(&:new_record?).each do |hq_cage|
      attributes = hq_cage_attributes[hq_cage.id.to_s]
      if attributes
        hq_cage.attributes = attributes
      else
        hq_cages.delete(hq_cage)
      end
    end
  end
  
  def save_hq_cages
    hq_cages.each do |hq_cage|
      hq_cage.save(false)
    end
  end
  ############   
  
    ######## Switches
  
  def new_hq_switch_attributes=(hq_switch_attributes)
    hq_switch_attributes.each do |attributes|
      hq_switches.build(attributes)
    end
  end
  
  def existing_hq_switch_attributes=(hq_switch_attributes)
    hq_switches.reject(&:new_record?).each do |hq_switch|
      attributes = hq_switch_attributes[hq_switch.id.to_s]
      if attributes
        hq_switch.attributes = attributes
      else
        hq_switches.delete(hq_switch)
      end
    end
  end
  
  def save_hq_switches
    hq_switches.each do |hq_switch|
      hq_switch.save(false)
    end
  end
  ############ 
  
  
    ######## Servers
  
  def new_hq_server_attributes=(hq_server_attributes)
    hq_server_attributes.each do |attributes|
      hq_servers.build(attributes)
    end
  end
  
  def existing_hq_server_attributes=(hq_server_attributes)
    hq_servers.reject(&:new_record?).each do |hq_server|
      attributes = hq_server_attributes[hq_server.id.to_s]
      if attributes
        hq_server.attributes = attributes
      else
        hq_servers.delete(hq_server)
      end
    end
  end
  
  def save_hq_servers
    hq_servers.each do |hq_server|
      hq_server.save(false)
    end
  end
  ############ 
  
  
  
  
  ######## Diskarrays
  def new_hq_diskarray_attributes=(hq_diskarray_attributes)
    hq_diskarray_attributes.each do |attributes|
      hq_diskarrays.build(attributes)
    end
  end
  
  def existing_hq_diskarray_attributes=(hq_diskarray_attributes)
    hq_diskarrays.reject(&:new_record?).each do |hq_diskarray|
      attributes = hq_diskarray_attributes[hq_diskarray.id.to_s]
      if attributes
        hq_diskarray.attributes = attributes
      else
        hq_diskarrays.delete(hq_diskarray)
      end
    end
  end
  
  def save_hq_diskarrays
    hq_diskarrays.each do |hq_diskarray|
      hq_diskarray.save(false)
    end
  end
  ############ 
  
  
end
