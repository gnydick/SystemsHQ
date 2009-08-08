module PptClassesHelper
  
  def add_ppt_class_ppt_node_hq_server_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :ppt_nodes, :partial => 'ppt_classes/line/ppt_node_hq_server', :object => PptNode.new
    end 
  end
  
  def add_ppt_class_ppt_node_hq_vserver_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :ppt_nodes, :partial => 'ppt_classes/line/ppt_node_hq_vserver', :object => PptNode.new
    end 
  end
  
  def assign_ppt_class_ppt_node_hq_server_select(selected)
    options = options_for_select([['Please Choose','']])
    options += options_from_collection_for_select(HqServer.all(:order => 'name ASC'), :id, :name, selected)
    select_tag("ppt_class[assigned_ppt_node_hq_server][]", options)
  end
  
  def assign_ppt_class_ppt_node_hq_vserver_select(selected)
    options = options_for_select([['Please Choose','']])
    options += options_from_collection_for_select(HqVserver.all(:order => 'name ASC'), :id, :name, selected)
    select_tag("ppt_class[assigned_ppt_node_hq_vserver][]", options)
  end
  
  
end
