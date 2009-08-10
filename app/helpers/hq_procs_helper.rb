module HqProcsHelper
  
  def add_hq_proc_hq_rsrc_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_procs, :partial => 'hq_procs/line/hq_rsrc', :object => HqRsrc.new 
    end 
  end 
  
  
  def assign_hq_proc_hq_task_select(hq_tasks)
    options = options_for_select([['Please Choose','']])
    hq_proc_hq_task_select(hq_tasks,nil,options)
  end
  
  def hq_proc_hq_task_select(hq_tasks, selected={}, options='')    
    tasks = options + options_from_collection_for_select(hq_tasks, :id, :name, selected)
    select_tag("hq_proc[hq_task_id]", tasks)
  end
  
  
  def assign_hq_proc_hq_rsrc_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_rsrcs, :partial => 'hq_procs/line/hq_rsrc_assign', :object => HqRsrc.new
    end 
  end 
  
  
  
  
  def assign_hq_proc_hq_rsrc_select(selected=[])    
    options = options_from_collection_for_select(HqRsrc.all(:order => 'name ASC'), :id, :name, @object.hq_rsrcs.collect(&:id))
    select_tag("hq_proc[assigned_hq_rsrc][]", options, :multiple => true, :size => 10)
  end
 
  
  
end
