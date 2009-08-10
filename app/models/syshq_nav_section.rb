class SyshqNavSection < ActiveRecord::Base
  acts_as_list :order => :position
  
  has_many :syshq_nav_section_items
  named_scope :displayed_sections, :conditions => '`view`=1', :order => :position
  
  def displayed_items
    syshq_nav_section_items.display_by_section(id)
  end
  
end
