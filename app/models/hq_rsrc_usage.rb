class HqRsrcUsage < ActiveRecord::Base
  
  def self.screen_name
    return 'Resource Usage'
  end

  def self.excluded_from_reflected
    Array.new
  end
  
  belongs_to :hq_rsrc
  belongs_to :hq_proc
  
end
