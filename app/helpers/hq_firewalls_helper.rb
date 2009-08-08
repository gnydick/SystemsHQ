module HqFirewallsHelper
  
  def assign_hq_rack_for_hq_firewall_select(hq_firewalls)
    options = options_for_select([['Please Choose','']])
    hq_firewall_for_hq_rack_select(hq_racks,nil,options)
  end
  
  def hq_rack_for_hq_firewall_select(hq_racks, selected={}, options='')    
    racks = options + options_from_collection_for_select(hq_racks, :id, :label, selected)
    select_tag("hq_firewall[hq_rack_id]", racks)
  end
  
  def add_hq_firewall_hq_nic_link(name)
    link_to_function name do |page| 
      page.insert_html :top, :hq_nics, :partial => 'hq_firewalls/line/hq_nic', :object => HqNic.new
    end
  end
  
  
  
end
