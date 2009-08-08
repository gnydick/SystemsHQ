class HqRack < ActiveRecord::Base
  @@screen_name = 'Rack'
  
  named_scope :by_site, lambda { |site| {  :joins => :hq_cage,
  :conditions => ['hq_cages.hq_site_id=?', site],
  :order => 'hq_cages.name, hq_racks.name ASC'  }}
  
   named_scope :by_cage, lambda { |cage| {:conditions => ['hq_cage_id in (?)', cage], :order => 'name ASC' }}  
  belongs_to :hq_cage 
  belongs_to :hq_site
  
  has_many :hq_switches
  has_many :hq_servers
  has_many :hq_diskarrays
  
  
  validates_associated :hq_switches
  validates_associated :hq_servers
  validates_associated :hq_diskarrays
  
  
  validates_presence_of :name
  validates_presence_of :hq_cage_id
  
  after_update :save_hq_switches
  after_update :save_hq_servers
  after_update :save_hq_diskarrays
  

  def self.excluded_from_reflected
    excludes = Array.new
  end
  
  def self.filters
    filters = Array.new
    filters << :hq_cage
    
  end
  
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  
  
  def label
    hq_cage.name+' - '+name
  end
  
  
  
    ##### switches #### this one works
    
    
    def assigned_hq_switch=(assigned_hq_switches)
      hq_switches.each do |hq_switch|
        hq_switches.delete(hq_switch) unless assigned_hq_switches.include?(hq_switch.id)
      end
      assigned_hq_switches.select{|x| x.to_i > 0}.each do |assigned_hq_switch|
        hq_switches << HqSwitch.find(assigned_hq_switch)      
      end
      
    end
    ############
    
    ##### diskarrays #### this one works
    
    
    def assigned_hq_diskarray=(assigned_hq_diskarrays)
      hq_diskarrays.each do |hq_diskarray|
        hq_diskarrays.delete(hq_diskarray) unless assigned_hq_diskarrays.include?(hq_diskarray.id)
      end
      assigned_hq_diskarrays.select{|x| x.to_i > 0}.each do |assigned_hq_diskarray|
        hq_diskarrays << HqDiskarray.find(assigned_hq_diskarray)      
      end
      
    end
    ############
    
    
    ##### servers #### this one works
    
    
    def assigned_hq_server=(assigned_hq_servers)
      hq_servers.each do |hq_server|
        hq_servers.delete(hq_server) unless assigned_hq_servers.include?(hq_server.id)
      end
      assigned_hq_servers.select{|x| x.to_i > 0}.each do |assigned_hq_server|
        hq_servers << HqServer.find(assigned_hq_server)      
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
