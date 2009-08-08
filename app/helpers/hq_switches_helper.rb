module HqSwitchesHelper
  
  def assign_hq_rack_for_hq_switch_select(hq_switches)
    options = options_for_select([['Please Choose','']])
    hq_switch_for_hq_rack_select(hq_racks,nil,options)
  end
  
  def hq_rack_for_hq_switch_select(hq_racks, selected={}, options='')    
    racks = options + options_from_collection_for_select(hq_racks, :id, :label, selected)
    select_tag("hq_switch[hq_rack_id]", racks)
  end
  
  def add_hq_switch_hq_nic_link(name)
    link_to_function name do |page| 
      page.insert_html :top, :hq_nics, :partial => 'hq_switches/line/hq_nic', :object => HqNic.new
    end
  end
  
  
end
