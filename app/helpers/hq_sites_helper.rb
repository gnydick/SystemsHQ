module HqSitesHelper
  
  def rack_selector(site, selected = {}, options = {}, html_options = {})
    group_options = option_groups_from_collection_for_select(site.hq_cages, :hq_racks, :name, :id, :name, selected) 
    return select_tag("hq_server[hq_rack_id]", group_options)
  end
  
  
  def add_hq_cage_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_cages, :partial => 'hq_sites/line/hq_cage', :object => HqCage.new
    end 
  end 
  
  
  
  
  def assign_hq_cage_select(hq_cages)
    options = options_for_select([['Please Choose','']])
    hq_cage_select(hq_cages,nil,options)
  end
  
  
  def hq_cage_select(hq_cages, selected = {}, options = '')
    cages = options + options_from_collection_for_select(hq_cages, :id, :name, selected)
    select_tag("hq_site[assigned_hq_cage][]", cages) 
  end
  
  
end
