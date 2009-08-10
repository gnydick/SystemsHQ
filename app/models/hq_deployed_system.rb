class HqDeployedSystemName
  attr_accessor :full_name
  
  def initialize(hq_site_id, hq_env_id, hq_system_id)    
    @full_name = [HqSite.find(hq_site_id).name,HqEnv.find(hq_env_id).name,HqSystem.find(hq_system_id).name].join(' - ')
  end
end

class HqDeployedSystem < ActiveRecord::Base
  named_scope :by_site, lambda { |site| { :conditions => ['hq_site_id=?', site] }}
  
  @@screen_name = 'Deployed System'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
 
  
  belongs_to :hq_env  
  belongs_to :hq_system
  belongs_to :hq_site
  
  validates_associated :hq_system
  
  def self.deploy(hq_env, hq_site, hq_system)
    
    
    hq_deployed_system = HqDeployedSystem.new
    hq_deployed_system.hq_env_id = hq_env.id
    hq_deployed_system.hq_site_id = hq_site.id
    hq_deployed_system.hq_system_id = hq_system.id
    
    
    
    
    return hq_deployed_system
  end
  
  def self.excluded_from_reflected
    excluded = Array.new
    return excluded
  end
  
  composed_of :full_name,
    :class_name => 'HqDeployedSystemName',
    :mapping => [ %w(hq_site_id hq_site_id),
    %w(hq_env_id hq_env_id),
    %w(hq_system_id hq_system_id)]
  
      def name
        [hq_site.name,hq_env.name,hq_system.name].join(' - ')
      end
      
      def name=(name)
        split = name.split(' - ',3)
        self.hq_site_id = HqSite.find_by_name(split[0]).id
        self.hq_env_id = HqEnv.find_by_name(split[1]).id
        self.hq_system_id = HqSystem.find_by_name(split[2]).id
      end
      
end
