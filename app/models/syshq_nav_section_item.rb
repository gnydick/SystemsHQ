class SyshqNavSectionItem < ActiveRecord::Base
  acts_as_list :scope => :syshq_nav_section, :order => :position
  
  belongs_to :syshq_nav_section
  named_scope :display_by_section, lambda { |section_id| { :conditions => ['`view`=1 and syshq_nav_section_id=?', section_id], :order => :position }}
  named_scope :by_site, lambda { |site| {  :conditions => ['hq_site_id=?', site], :order => 'name ASC'  }}
  
end
