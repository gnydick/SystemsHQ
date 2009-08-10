class HqApp < ActiveRecord::Base
  
  
  named_scope :by_system, lambda { |system| {:conditions => ['hq_system_id in (?)', system], :order => 'name ASC' }}

  
  #  def self.find(*args)
  #    with_scope(:find=>{ :conditions=>'template=1' }) do
  #      super(*args)
  #    end
  #  end
  
  
 
  
  
  @@screen_name = 'Application'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  def self.excluded_from_reflected
    excludes = Array.new
    excludes << :hq_tasks
    excludes << :hq_apps
    excludes << :hq_deployed_apps
  end
  
  def self.filters
    filters = Array.new
    filters << :hq_system
  end
  
  belongs_to :hq_system
  has_many :hq_tasks, :order => :position
  
  has_many :ppt_classes
  
  validates_associated :hq_tasks
  validates_presence_of :name
  
  after_update :save_hq_tasks
  
  
  def new_hq_task_attributes=(hq_task_attributes)
    hq_task_attributes.each do |attributes|      
      hq_tasks.build(attributes)
      hq_tasks.each {|x| x.hq_app_id = id}
      
    end
  end
  
  def existing_hq_task_attributes=(hq_task_attributes)
    hq_tasks.reject(&:new_record?).each do |hq_task|
      attributes = hq_task_attributes[hq_task.id.to_s]
      if attributes
        hq_task.attributes = attributes
        hq_task.destroy if hq_task.invalid?
      else
        hq_tasks.delete(hq_task)
      end
    end
  end
  
  def save_hq_tasks
    hq_tasks.each do |hq_task|      
      hq_task.save(false)
    end
  end
  
  
  
  def new_ppt_class_attributes=(ppt_class_attributes)
    ppt_class_attributes.each do |attributes|      
      ppt_classes.build(attributes)
      ppt_classes.each {|x| x.hq_app_id = id}
      
    end
  end
  
  def existing_ppt_class_attributes=(ppt_class_attributes)
    ppt_classes.reject(&:new_record?).each do |ppt_class|
      attributes = ppt_class_attributes[ppt_class.id.to_s]
      if attributes
        ppt_class.attributes = attributes
        ppt_class.destroy if ppt_class.invalid?
      else
        ppt_classes.delete(ppt_class)
      end
    end
  end
  
  def save_ppt_classs
    ppt_classs.each do |ppt_class|      
      ppt_class.save(false)
    end
  end
  
end
