class HqDiskarray < ActiveRecord::Base
  
  @@screen_name = 'Disk Array'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  def self.excluded_from_reflected
    excludes = Array.new
    excludes << :hq_nics
    return excludes
  end
  
  def self.filters
    filters = Array.new
    filters << :hq_rack
    filters << :hq_san
    return filters
  end
  
   
  named_scope :by_rack, lambda { |rack| {  :conditions => ['hq_rack_id in (?)', rack], :order => 'name ASC'  }}
  named_scope :by_san, lambda { |san| {  :conditions => ['hq_san_id in (?)', san], :order => 'name ASC'  }}
  named_scope :by_site, lambda { |site| {  :conditions => ['hq_site_id=?', site], :order => 'name ASC'  }}
  
  belongs_to :hq_san
  belongs_to :hq_site
  belongs_to :hq_rack
  
  has_many :hq_nics, :as => :hq_nichaving, :dependent => :destroy
  validates_presence_of :name,  :hq_site_id
  
  after_update :save_hq_nics
  
  def label
    hq_site.name+' - '+name
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
