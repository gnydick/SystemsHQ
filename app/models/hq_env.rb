class HqEnv < ActiveRecord::Base
  
  has_many :hq_deployed_systems
  has_many :hq_deployed_apps, :through => :hq_deployed_systems
  
  @@screen_name = 'Environment'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  def self.excluded_from_reflected
    excludes = Array.new
    excludes << :hq_tasks
  end
  
  def self.filters
    filters = Array.new
   
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
      hq_tasks.each {|x| x.hq_env_id = id}
      
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
  
  
  
  
end
