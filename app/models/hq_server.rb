class HqServer < ActiveRecord::Base
  
  
  named_scope :by_site, lambda { |site| {  :conditions => ['hq_site_id=?', site], :order => 'name ASC'  }}
  named_scope :by_rack, lambda { |rack| {  :conditions => ['hq_rack_id in (?)', rack], :order => 'name ASC'  }}
  
  belongs_to :hq_rack
  belongs_to :hq_site
  has_one :hq_cage, :through => :hq_rack
  
  has_many :hq_nics, :as => :hq_nichaving, :dependent => :destroy
  
  has_many :ppt_nodes, :as => :puppetized_node  
  has_many :hq_vservers
  validates_associated :hq_vservers, :hq_nics
  validates_presence_of :name
  
  after_update :save_hq_vservers, :save_hq_nics
  
  
  
  @@screen_name = 'Server'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  def self.excluded_from_reflected
    excludes = Array.new
    excludes << :hq_nics
    excludes << :ppt_nodes
    return excludes
  end
  
  def self.filters
    filters = Array.new
    filters << :hq_rack
  end
  
  
  def label
    self.hq_rack.name+' - '+name
  end
  
  def id_rack_id
    id.to_s+':'+hq_rack.id.to_s
  end
  
  def in_my_rack
    HqServer.find_by_hq_rack_id(hq_rack_id)
  end
  
  
  def in_my_cage
    hq_cage.hq_servers
  end
  
  def new_hq_vserver_attributes=(hq_vserver_attributes)
    hq_vserver_attributes.each do |attributes|
      hq_vservers.build(attributes)
    end
  end
  
  def existing_hq_vserver_attributes=(hq_vserver_attributes)
    hq_vservers.reject(&:new_record?).each do |hq_vserver|
      attributes = hq_vserver_attributes[hq_vserver.id.to_s]
      if attributes
        hq_vserver.attributes = attributes
      else
        hq_vservers.delete(hq_vserver)
      end
    end
  end
  
  def save_hq_vservers
    hq_vservers.each do |hq_vserver|
      hq_vserver.save(false)
    end
  end
  
  
  def new_hq_nic_attributes=(hq_nic_attributes)
    hq_nic_attributes.each do |attributes|
      hq_nics.build(attributes)
    end
  end
  
  def existing_hq_nic_attributes=(hq_nic_attributes)
    hq_nics.reject(&:new_record?).each do |hq_nic|
      attributes = hq_nic_attributes[hq_nic.id.to_s]
      if attributes
        hq_nic.attributes = attributes
      else
        hq_nics.delete(hq_nic)
      end
    end
  end
  
  def save_hq_nics
    hq_nics.each do |hq_nic|
      hq_nic.save(false)
    end
  end
  
  
  
  
end
