module HqRacksHelper
  
  ### diskarrays
  def new_hq_rack_hq_diskarray_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_diskarrays_list, :partial => 'hq_racks/line/hq_diskarray_new', :object => HqApp.new
    end 
  end 
  
  
  def assign_hq_rack_hq_diskarray_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_diskarrays_list, :partial => 'hq_racks/line/hq_diskarray_assign'
    end 
  end 
  
  
  
  
  def assign_hq_rack_hq_diskarray_select(hq_diskarrays)
    options = options_for_select([['Please Choose','']])
    hq_rack_hq_diskarray_select(hq_diskarrays,nil,options)
  end
  
  
  def hq_rack_hq_diskarray_select(hq_diskarrays, selected = {}, options = '')
    diskarrays = options + options_from_collection_for_select(hq_diskarrays, :id, :name, selected)
    select_tag("hq_rack[assigned_hq_diskarray][]", diskarrays) 
  end
    
  ### switches
  def new_hq_rack_hq_switch_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_switches_list, :partial => 'hq_racks/line/hq_switch_new', :object => HqApp.new
    end 
  end 
  
  
  def assign_hq_rack_hq_switch_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_switches_list, :partial => 'hq_racks/line/hq_switch_assign'
    end 
  end 
  
  
  
  
  def assign_hq_rack_hq_switch_select(hq_switches)
    options = options_for_select([['Please Choose','']])
    hq_rack_hq_switch_select(hq_switches,nil,options)
  end
  
  
  def hq_rack_hq_switch_select(hq_switches, selected = {}, options = '')
    switches = options + options_from_collection_for_select(hq_switches, :id, :name, selected)
    select_tag("hq_rack[assigned_hq_switch][]", switches) 
  end
  
  
  ### server
  def new_hq_rack_hq_server_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_servers_list, :partial => 'hq_racks/line/hq_server_new', :object => HqApp.new
    end 
  end 
  
  
  def assign_hq_rack_hq_server_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_servers_list, :partial => 'hq_racks/line/hq_server_assign'
    end 
  end 
  
  
  
  
  def assign_hq_rack_hq_server_select(hq_servers)
    options = options_for_select([['Please Choose','']])
    hq_rack_hq_server_select(hq_servers,nil,options)
  end
  
  
  def hq_rack_hq_server_select(hq_servers, selected = {}, options = '')
    servers = options + options_from_collection_for_select(hq_servers, :id, :name, selected)
    select_tag("hq_rack[assigned_hq_server][]", servers) 
  end
  
  
  
  
  
  
  def hq_rack_hq_cage_select
    collection_select(:hq_rack, :hq_cage_id, @hq_cages , :id, :name, :selected => @hq_rack.new_record? ? 0 : @hq_rack.hq_cage_id) 
  end
  
  
end
