module HqTasksHelper
  
  def add_hq_proc_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_procs, :partial => 'hq_proc', :object => HqProc.new 
    end 
  end 
  
  
  def assign_hq_task_hq_app_select(hq_taskes)
    options = options_for_select([['Please Choose','']])
    hq_task_for_hq_app_select(hq_apps,nil,options)
  end
  
  def hq_task_hq_app_select(hq_apps, selected={}, options='')    
    racks = options + options_from_collection_for_select(hq_apps, :id, :name, selected)
    select_tag("hq_task[hq_app_id]", racks)
  end
  
  
  def add_hq_task_hq_proc_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_procs, :partial => 'hq_tasks/line/hq_proc.html', :object => HqProc.new
    end 
  end 
  
  
end
