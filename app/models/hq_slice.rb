class HqSlice < ActiveRecord::Base
  
  @@screen_name = 'Slice'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end

  def self.excluded_from_reflected
    Array.new
  end
  
  named_scope :by_site, lambda { |site| {  :joins => :hq_san, :conditions => ['hq_sans.hq_site_id=?', site], :order => 'name ASC'  }}
  
  belongs_to :hq_san
  belongs_to :hq_vserver
  
  validates_presence_of :name,  :size
  

  
end
