class HqSan < ActiveRecord::Base
  
  @@screen_name = 'SAN'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end

  def self.excluded_from_reflected
    Array.new
  end
  
  named_scope :by_site, lambda { |site| {  :conditions => ['hq_site_id=?', site], :order => 'name ASC'  }}
  
  has_many :hq_diskarrays
  belongs_to :hq_site
  has_many :hq_diskarrays
  has_many :hq_slices, :dependent => :destroy
  
  
  
  validates_presence_of :name
  validates_associated :hq_slices, :hq_diskarrays
  
  after_update :save_hq_slices, :save_hq_diskarrays
  
  def label
    hq_site.name+' - '+name
  end
  
   ##### slices #### this one works 
  def new_hq_slice_attributes=(hq_slice_attributes)
    hq_slice_attributes.each do |attributes|
      hq_slices.build(attributes)
    end
  end
  
  def existing_hq_slice_attributes=(hq_slice_attributes)
    hq_slices.reject(&:new_record?).each do |hq_slice|
      attributes = hq_slice_attributes[hq_slice.id.to_s]
      if attributes
        hq_slice.attributes = attributes
      else
        hq_slices.delete(hq_slice)
      end
    end
  end
  
  def save_hq_slices
    hq_slices.each do |hq_slice|
      hq_slice.save(false)
    end
  end
  

  def assigned_hq_slice=(assigned_hq_slices)
    hq_slices.each do |hq_slice|
      hq_slices.delete(hq_slice) unless assigned_hq_slices.include?(hq_slice.id)
    end
    assigned_hq_slices.select{|x| x.to_i > 0}.each do |assigned_hq_slice|
      hq_slices << HqRsrc.find(assigned_hq_slice)      
    end
    
  end
  ############
  
  
  
    ##### diskarrays #### this one works 
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
  

  def assigned_hq_diskarray=(assigned_hq_diskarrays)
    hq_diskarrays.each do |hq_diskarray|
      hq_diskarrays.delete(hq_diskarray) unless assigned_hq_diskarrays.include?(hq_diskarray.id)
    end
    assigned_hq_diskarrays.select{|x| x.to_i > 0}.each do |assigned_hq_diskarray|
      hq_diskarrays << HqRsrc.find(assigned_hq_diskarray)      
    end
    
  end
  ############
  
end
