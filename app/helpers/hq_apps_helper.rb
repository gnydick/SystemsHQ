module HqAppsHelper
  
  def system_select
    collection_select(:hq_app, :hq_system_id, HqSystem.all(:order => :name), :id, :name)
  end
  
  
  def new_hq_app_hq_task_link(name) 
    link_to_function name do |page|
      page.insert_html :top, :hq_tasks_list, :partial => 'hq_apps/line/hq_task', :object => HqTask.new
    end 
  end  
  
  
end
