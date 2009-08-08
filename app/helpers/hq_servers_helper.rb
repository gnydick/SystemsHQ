module HqServersHelper
  
  def close_link
    link_to_function 'Close', visual_effect(:fade, 'hq_vserver_details', :duration => 0.5 )
  end
  
  
  def hq_server_hq_vserver_detail_link(label, vserver)
    link_to_remote(label, :url => vserver, :method => :get, :loaded => visual_effect(:appear, "hq_vserver_details", :to => 0.95, :duration => 0.5 ))
  end
  
  def add_hq_server_hq_vserver_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_vservers, :partial => 'hq_servers/line/hq_vserver', :object => HqVserver.new 
    end 
  end 
  
  def add_hq_server_hq_nic_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_nics, :partial => 'hq_servers/line/hq_nic', :object => HqNic.new
    end 
  end 
  
  def assign_hq_rack_for_hq_server_select(hq_servers)
    options = options_for_select([['Please Choose','']])
    hq_server_for_hq_rack_select(hq_servers,nil,options)
  end
  
  def hq_rack_for_hq_server_select(hq_racks, selected={}, options='')    
    racks = options + options_from_collection_for_select(hq_racks, :id, :label, selected)
    select_tag("hq_server[hq_rack_id]", racks)
  end
  
  
  
end
