class HqRsrc < ActiveRecord::Base
  
  @@screen_name = 'Resource'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end

  def self.excluded_from_reflected
    Array.new
  end
  
  def self.filters
    filters = Array.new
    filters << :hq_proc
  end
  
  
  validates_associated :hq_rsrc_usages
  validates_presence_of :name
  
  has_many :hq_rsrc_usages
  has_many :hq_procs, :through => :hq_rsrc_usages
  
  
  
   def new_hq_rsrc_usage_attributes=(hq_rsrc_usage_attributes)
    hq_rsrc_usage_attributes.each do |attributes|
      hq_rsrc_usages.build(attributes)
    end
  end
  
  def existing_hq_rsrc_usage_attributes=(hq_rsrc_usage_attributes)
    hq_rsrc_usages.reject(&:new_record?).each do |hq_rsrc_usage|
      attributes = hq_rsrc_usage_attributes[hq_rsrc_usage.id.to_s]
      if attributes
        hq_rsrc_usage.attributes = attributes
      else
        hq_rsrc_usages.delete(hq_rsrc_usage)
      end
    end
  end
  
  def save_hq_rsrc_usages
    hq_rsrc_usages.each do |hq_rsrc_usage|
      hq_rsrc_usage.save(false)
    end
  end
  
  
end
