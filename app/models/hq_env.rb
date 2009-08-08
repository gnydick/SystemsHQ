class HqEnv < ActiveRecord::Base
  
    @@screen_name = 'Environment'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  def self.excluded_from_reflected
    Array.new
  end
  
end
