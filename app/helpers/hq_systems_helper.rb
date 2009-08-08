module HqSystemsHelper
  

  def new_hq_app_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_apps, :partial => 'hq_systems/line/hq_app_new', :object => HqApp.new
    end 
  end 
 
  
  def assign_hq_app_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_apps_list, :partial => 'hq_systems/line/hq_app_assign'
    end 
  end 
  
  
  
  
  def assign_hq_system_hq_app_select(hq_apps)
    options = options_for_select([['Please Choose','']])
    hq_system_hq_app_select(hq_apps,nil,options)
  end
  
  
  def hq_system_hq_app_select(hq_apps, selected = {}, options = '')
    apps = options + options_from_collection_for_select(hq_apps, :id, :name, selected)
    select_tag("hq_system[assigned_hq_app][]", apps) 
  end
  
  
  
end
