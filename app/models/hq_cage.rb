class HqCage < ActiveRecord::Base
  
   @@screen_name = 'Cage'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end

  
  def self.excluded_from_reflected
    Array.new
  end
  
  named_scope :by_site, lambda { |site| {  :conditions => ['hq_site_id=?', site], :order => 'name ASC'  }}

  
  belongs_to :hq_site
  has_many :hq_racks
  has_many :hq_servers
  has_many :hq_switches
  has_many :hq_diskarrays
end
