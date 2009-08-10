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
  
  def assign_ppt_class_ppt_node_hq_server_select(selected=[])
    
    options = options_from_collection_for_select(HqServer.all(:order => 'name ASC'), :id, :name, @object.ppt_nodes.select{ |x| x.puppetized_node_type='HqServer'}.collect(&:puppetized_node_id))
    select_tag("ppt_class[assigned_ppt_node_hq_server][]", options, :multiple => true, :size => 10)
  end
  
  def assign_ppt_class_ppt_node_hq_vserver_select(selected=[])
    
    options = options_from_collection_for_select(HqVserver.all(:order => 'name ASC'), :id, :name, @object.ppt_nodes.select{ |x| x.puppetized_node_type='HqVserver'}.collect(&:puppetized_node_id))
    select_tag("ppt_class[assigned_ppt_node_hq_vserver][]", options, :multiple => true, :size => 10)
  end
  
  ###### Start Drag'n Drop Visuals #######
  
  def assigned_ppt_class_ppt_node_hq_vserver_list
    ids = @object.ppt_nodes.select{ |x| x.puppetized_node_type='HqVserver'}.collect(&:puppetized_node_id).to_a
    list = '<ul id="assigned_hq_vservers" style="overflow:hidden; heigh=75px;">Virtual Servers'
    #    list = ''
    HqVserver.find(ids).each do |item|
      list += "<li class=\"assigned_hq_vserver\" id=\"assigned_hq_vservers_#{item.id}\">#{item.name}</li>"
      list += draggable_element("assigned_hq_vservers_#{item.id}", :revert => true)
      #      list += "<span id=\"assigned_hq_vservers_#{item.id}\">#{item.name}</span><br />"
    end
    list += '</ul>'
    list += drop_receiving_element('assigned_hq_vservers', :accept => 'available_hq_vserver')
    return list
  end
  
  def assigned_ppt_class_ppt_node_hq_server_list
    ids = @object.ppt_nodes.select{ |x| x.puppetized_node_type='HqServer'}.collect(&:puppetized_node_id).to_a
    list = '<ul class=\"assigned_hq_server\"id="assigned_hq_servers" style="overflow:hidden; heigh=75px;">Servers'
    #    list = ''
    HqServer.find(ids).each do |item|
      list += "<li id=\"assigned_hq_servers_#{item.id}\">#{item.name}</li>"
      list += draggable_element("assigned_hq_servers_#{item.id}", :revert => true)
      #      list += "<span id=\"assigned_hq_servers_#{item.id}\">#{item.name}</span><br />"
    end
    list += '</ul>'
    list += drop_receiving_element('assigned_hq_servers', :accept => 'available_hq_server')
    return list
  end
  
  def available_ppt_class_ppt_node_hq_vserver_list
    ids = @object.ppt_nodes.select{ |x| x.puppetized_node_type='HqVserver'}.collect(&:puppetized_node_id).to_a
    condition = "id not in (#{ids})" if ids.size > 0
    condition = "" if ids.size == 0
    list = '<ul id="available_hq_vservers" style="overflow:hidden; heigh=75px;">Virtual Servers'
    #    list = ''
    HqVserver.all(:order => 'name ASC', :conditions => condition).each do |item|
      list += "<li class=\"available_hq_vserver\" id=\"available_hq_vservers_#{item.id}\">#{item.name}</li>"
      list += draggable_element("available_hq_vservers_#{item.id}", :revert => true)
      #      list += "<span id=\"available_hq_vservers_#{item.id}\">#{item.name}</span><br />"
    end
    list += '</ul>'
    list += drop_receiving_element('available_hq_vservers', :accept => 'assigned_hq_vserver')
    return list
  end
  
  def available_ppt_class_ppt_node_hq_server_list
    ids = @object.ppt_nodes.select{ |x| x.puppetized_node_type='HqServer'}.collect(&:puppetized_node_id).to_a
    condition = "id not in (#{ids})" if ids.size > 0
    condition = "" if ids.size == 0
    list = '<ul id="available_hq_servers" style="overflow:hidden; heigh=75px;">Servers'
    #    list = ''
    HqServer.all(:order => 'name ASC', :conditions => condition).each do |item|
      list += "<li class=\"available_hq_server\" id=\"available_hq_servers_#{item.id}\">#{item.name}</li>"
      list += draggable_element("available_hq_servers_#{item.id}", :revert => true) 
      #      list += "<span id=\"available_hq_servers_#{item.id}\">#{item.name}</span><br />"
    end
    list += '</ul>'
    list += drop_receiving_element('available_hq_servers', :accept => 'assigned_hq_server')
    return list
  end
  
  
end
