class HqVserver < ActiveRecord::Base
  default_scope :order => 'name ASC'
  named_scope :by_site, lambda { |site| {:joins => :hq_server,  :conditions => ['hq_servers.hq_site_id=?', site], :order => 'name ASC' }}
  named_scope :by_server, lambda { |server| {:conditions => ['hq_server_id in (?)', server], :order => 'name ASC' }}
  
  has_many :ppt_nodes, :as => :puppetized_node
  
  
  belongs_to :hq_server
  has_one :hq_rack, :through => :hq_server
  
  has_many :hq_vnics,  :dependent => :destroy
  has_many :hq_slices
  
  validates_associated  :hq_vnics, :hq_slices, :ppt_nodes
  validates_presence_of :name
  
  after_update :save_hq_vnics, :save_hq_slices, :save_ppt_nodes
  
  
  def ppt_classes
    ppt_classes = Array.new
    ppt_nodes.each {|x| ppt_classes << x.ppt_class}
    return ppt_classes
  end
  
  @@screen_name = 'Virtual Server'
  
 
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  def self.excluded_from_reflected
    excludes = Array.new
    excludes << :hq_vnics
    excludes << :ppt_nodes
    return excludes
    
  end
  
 
  def self.filters
    filters = Array.new
    filters << :hq_server
  end
  
  
  def assigned_hq_slice=(assigned_hq_slices)
    hq_slices.reject(&:new_record?).each do |hq_slice|
      unless assigned_hq_slices.include?(hq_slice)
        hq_slices.delete(hq_slice) 
      end
      hq_slices << HqSlice.find(assigned_hq_slices)
    end
  end
  
  ###### HqNic #######  
  
  def new_hq_vnic_attributes=(hq_vnic_attributes)
    hq_vnic_attributes.each do |attributes|
      hq_vnics.build(attributes)
    end
  end
  
  def existing_hq_vnic_attributes=(hq_vnic_attributes)
    hq_vnics.reject(&:new_record?).each do |hq_vnic|
      attributes = hq_vnic_attributes[hq_vnic.id.to_s]
      if attributes
        hq_vnic.attributes = attributes
      else
        hq_vnics.delete(hq_vnic)
      end
    end
  end
  
  def save_hq_vnics
    hq_vnics.each do |hq_vnic|
      hq_vnic.save(false)
    end
  end
  
  ################### 
  
  ###### HqSlice #######  
  
  def new_hq_slice_attributes=(hq_slice_attributes)
    hq_slice_attributes.each do |attributes|
      hq_slices.build(attributes)
    end
  end
  
  def existing_hq_slice_attributes=(hq_slice_attributes)
    hq_slices.reject(&:new_record?).each do |hq_slice|
      attributes = hq_slice_attributes[hq_slice.id.to_s]
      if attributes
        hq_slice.attributes = attributes
      else
        hq_slices.delete(hq_slice)
      end
    end
  end
  
  def save_hq_slices
    hq_slices.each do |hq_slice|
      hq_slice.save(false)
    end
  end
  
  ################### 
  
  ##### Puppet ######
  def assigned_ppt_class=(assigned_ppt_classes)
    ppt_nodes.clear
    assigned_ppt_classes.each do |assigned_ppt_class|
      ppt_nodes << PptNode.new(:ppt_class_id => PptClass.find(assigned_ppt_class).id) unless ppt_nodes.find_by_ppt_class_id(assigned_ppt_class)
    end
  end  
  
  def save_ppt_nodes
     ppt_nodes.each do |ppt_node|
      ppt_node.save(false)
    end
  end
  ################### 
  
end
