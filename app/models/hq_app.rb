class HqApp < ActiveRecord::Base
  
  
  @@screen_name = 'Application'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end

  def self.excluded_from_reflected
    Array.new
  end
  
  
  belongs_to :hq_system
  has_many :hq_tasks
  
  
  validates_associated :hq_tasks
  validates_presence_of :name, :hq_system_id
  
  after_update :save_hq_tasks
  
  
  def new_hq_task_attributes=(hq_task_attributes)
    hq_task_attributes.each do |attributes|
      hq_tasks.build(attributes)
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
