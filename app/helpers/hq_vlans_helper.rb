module HqVlansHelper
  
  def add_hq_vlan_hq_vlan_assignment_link(name) 
    link_to_function name do |page| 
      vlan_assignment = HqVlanAssignment.new(:hq_vlan_id => @item.id)
      page.insert_html :top, :hq_vlan_assignments, :partial => 'hq_vlans/line/hq_vlan_assignment', :object => vlan_assignment
    end 
  end 

  
  
    def assign_hq_vlan_hq_vlan_assignment_select(selected = {}, options = {}, html_options = {})
    group_options = '<optgroup label="PleaseChoose"><option></optgroup>'
    group_options = group_options + option_groups_from_collection_for_select(HqSwitch.by_site(@hq_site), :hq_nics, :name, :id, :name, :selected => selected) 
    return select_tag("hq_vlan[assigned_hq_nic][]", group_options)
  end
  
end
