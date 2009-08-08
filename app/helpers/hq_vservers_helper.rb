module HqVserversHelper
  
  def add_hq_vserver_hq_vnic_link(name) 
    link_to_function name do |page| 
      vnic = HqVnic.new(:hq_vserver_id => @object.id)
      page.insert_html :top, :hq_vnics, :partial => 'hq_vservers/line/hq_vnic', :object => vnic
    end 
  end 
  
  def hq_vserver_hq_server_select(selected='')
    collection_select(:hq_vserver, :hq_server_id, HqServer.by_site(cookies[:hq_site_id]), :id, :name, {:prompt => true, :selected => selected})
  end
  
  
  
  ######### slices
  def assign_hq_vserver_hq_slice_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_slices_list, :partial => 'hq_vservers/line/hq_slice_assign'
    end 
  end 
  
  
  def assign_hq_vserver_hq_slice_select(hq_slices)
    options = options_for_select([['Please Choose','']])
    hq_vserver_hq_slice_select(hq_slices,nil,options)
  end
  
  
  def hq_vserver_hq_slice_select(hq_slices, selected = {}, options = '')
    slices = options + options_from_collection_for_select(hq_slices, :id, :name, selected)
    select_tag("hq_vserver[assigned_hq_slice][]", slices) 
  end
  
  ########### Puppet

    
    def add_hq_vserver_ppt_class_link(name) 
      link_to_function name do |page|
        page.insert_html :top, :ppt_classes, :partial => 'hq_vservers/line/ppt_class', :object => PptClass.new
      end 
    end
    
    def assign_hq_vserver_ppt_class_select(selected)
      options = options_for_select([['Please Choose','']])
      options += options_from_collection_for_select(PptClass.all(:order => 'name ASC'), :id, :name, selected)
      select_tag("hq_vserver[assigned_ppt_class][]", options)
    end
    

  
  
end
