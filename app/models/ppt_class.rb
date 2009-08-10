class PptClass < ActiveRecord::Base
  
  has_many :ppt_nodes
  
  
  
  @@screen_name = 'Server Role'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  def self.excluded_from_reflected
    return [:ppt_nodes]
  end
  
  
  
  
  
  has_many :ppt_nodes, :dependent => :destroy
  
  belongs_to :hq_env
  belongs_to :hq_app
  
  validates_associated  :ppt_nodes
  validates_presence_of :name
  
  after_update :save_ppt_nodes
  
  
  def assigned_ppt_node_hq_server=(assigned_ppt_node_hq_servers)
    ppt_nodes.clear
    ppt_nodes.each do |ppt_node|
      ppt_nodes.delete(ppt_node) unless assigned_ppt_node_hq_servers.include?(ppt_node.id)
    end
    assigned_ppt_node_hq_servers.each do |assigned_ppt_node_hq_server|
      hq_server = HqServer.find(assigned_ppt_node_hq_server)
      hq_server.ppt_nodes << PptNode.new(:ppt_class_id => id) unless hq_server.ppt_nodes.find_by_ppt_class_id(id)
    end
  end    
  
  def assigned_ppt_node_hq_vserver=(assigned_ppt_node_hq_vservers)
    ppt_nodes.clear
    ppt_nodes.each do |ppt_node|
      ppt_nodes.delete(ppt_node) unless assigned_ppt_node_hq_vservers.include?(ppt_node.id)
    end
    assigned_ppt_node_hq_vservers.each do |assigned_ppt_node_hq_vserver|
      hq_vserver = HqVserver.find(assigned_ppt_node_hq_vserver)
      hq_vserver.ppt_nodes << PptNode.new(:ppt_class_id => id) unless hq_vserver.ppt_nodes.find_by_ppt_class_id(id)
    end
  end    
  
  private
  def save_ppt_nodes
    ppt_nodes.each do |ppt_node|
      ppt_node.save(false)
    end
  end
  
  
  
end
