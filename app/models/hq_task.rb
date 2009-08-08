class HqTask < ActiveRecord::Base
  acts_as_list :scope => :hq_app, :order => "position"
  named_scope :by_application, lambda { |app| {:conditions => ['hq_app_id in (?)', app], :order => 'name ASC' }}
  
  @@screen_name = 'Task'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  def self.excluded_from_reflected
    excludes = Array.new
    excludes << :hq_procs
  end
  
  def self.filters
    filters = Array.new
    filters << :hq_app
  end
  
  
  belongs_to :hq_app
  has_many :hq_procs, :order => :position
  
  
  validates_associated :hq_procs
  validates_presence_of :name
  
  after_update :save_hq_procs
  
  
  def new_hq_proc_attributes=(hq_proc_attributes)
    hq_proc_attributes.each do |attributes|
      hq_procs.build(attributes)
    end
  end
  
  def existing_hq_proc_attributes=(hq_proc_attributes)
    hq_procs.reject(&:new_record?).each do |hq_proc|
      attributes = hq_proc_attributes[hq_proc.id.to_s]
      if attributes
        hq_proc.attributes = attributes
      else
        hq_procs.delete(hq_proc)
      end
    end
  end
  
  def save_hq_procs
    hq_procs.each do |hq_proc|
      hq_proc.save(false)
    end
  end
  
end
