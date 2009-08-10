class HqSystem < ActiveRecord::Base

  def self.excluded_from_reflected
    Array.new
  end

  
  @@screen_name = 'System'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  has_many :hq_apps
  has_many :hq_tasks, :through => :hq_apps
  
  validates_associated :hq_apps
  validates_presence_of :name
  
  after_update :save_hq_apps
  
  
    
  ##### apps #### this one works
  def assigned_hq_app=(assigned_hq_apps)
    hq_apps.each do |hq_app|
      hq_apps.delete(hq_app) unless assigned_hq_apps.include?(hq_app.id)
    end
    assigned_hq_apps.select{|x| x.to_i > 0}.each do |assigned_hq_app|
      hq_apps << HqApp.find(assigned_hq_app)      
    end
    
  end
  ############

  
  def new_hq_app_attributes=(hq_app_attributes)
    hq_app_attributes.each do |attributes|
      hq_apps.build(attributes)
    end
  end
  
  def existing_hq_app_attributes=(hq_app_attributes)
    hq_apps.reject(&:new_record?).each do |hq_app|
      attributes = hq_app_attributes[hq_app.id.to_s]
      if attributes
        hq_app.attributes = attributes
      else
        hq_apps.delete(hq_app)
      end
    end
  end
  
  def save_hq_apps
    hq_apps.each do |hq_app|
      hq_app.save(false)
    end
  end
  
  
end
