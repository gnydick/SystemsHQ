class HqProc < ActiveRecord::Base
  acts_as_list :scope => :hq_task, :order => "position"
  
  
  
  @@screen_name = 'Process'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  belongs_to :hq_task
  has_many :hq_rsrc_usages
  has_many :hq_rsrcs, :through => :hq_rsrc_usages
  
  validates_associated :hq_rsrc_usages
  validates_presence_of :name
  
  after_update :save_hq_rsrc_usages
  
  def self.excluded_from_reflected
    excludes = Array.new
    excludes << :hq_rsrcs
    excludes << :hq_rsrc_usages
    return excludes
  end
  
  def assigned_hq_rsrc=(assigned_hq_rsrcs)
    hq_rsrcs.each do |hq_rsrc|
      hq_rsrcs.delete(hq_rsrc) unless assigned_hq_rsrcs.include?(hq_rsrc.id)
    end
    assigned_hq_rsrcs.each do |assigned_hq_rsrc|
      hq_rsrcs << HqRsrc.find(assigned_hq_rsrc)  unless hq_rsrcs.collect(&:id).include?(assigned_hq_rsrc)
    end
  end    
  
  
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
 
  def rsrcs
    hq_rsrcs.sort {|x,y| x.name <=> y.name }
  end
  
  private
  def save_hq_rsrc_usages
    hq_rsrc_usages.each do |hq_rsrc_usage|
      hq_rsrc_usage.save(false)
    end
  end
  

  
end
