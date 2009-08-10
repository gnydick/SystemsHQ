# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  ##### start links ##### 
  def toggle_blind_link(name, id)
    link_to_function name, visual_effect(:toggle_blind, id)
  end
  
  
  
  def progress_link(name, url)
    link_to_remote(name, :url => url, :method => :get, 
    :loading => visual_effect(:appear,'spinner'),
    :complete => visual_effect(:fade, 'spinner', :duration => 0.5),
    :success => visual_effect(:appear, :preview_detail))
  end
  
  def progress_edit_link(name, url)
    link_to_remote(name, :url => url, :method => :get, 
    :loading => visual_effect(:appear,'spinner'),
    :complete => visual_effect(:fade, 'spinner', :duration => 0.5))
  end
  def new_link(view) 
    return "new_"+view.controller.controller_name.singularize+"_path"
  end
  
  def index_link(resource)
    self.send(resource.controller_name+"_path")
  end
  
  def add_has_many_link(owns)
    link_to_function "New #{eval(owns.name.to_s.singularize.camelize).screen_name}" do |page| 
      page.insert_html :top, owns.name.to_s+'_list', :partial => 'reflected/has_many_line',
      :locals => { :x => @object.send(owns.name).new }  
    end 
  end 
  
  def add_poly_has_many_link(owns)
    link_to_function "New #{eval(owns.name.to_s.singularize.camelize).screen_name}" do |page| 
      page.insert_html :top, owns.name.to_s+'_list', :partial => 'reflected/poly_has_many_line',
      :locals => { :x => @object.send(owns.name).new }      
    end 
  end 
  
  def edit_link(resource)
    eval("edit_#{resource.class.name.underscore}_path(resource)")
  end
  
  def show_link(resource)
    eval("show_#{resource.class.name.underscore}_path(resource)")
  end
  
  def remote_edit_link(item)
    link_to_remote 'Edit', {:url => {:controller => @CcObjectClass.to_s.pluralize.underscore.to_sym,
    :action => :edit, :id => item, :page => params[:page] }, :method => :get,
                  :complete => visual_effect(:blind_down, 'activity', :duration => 0.5 ),
      
    },{:href => url_for(:action => "edit", :id => item.id)}
  end
  
  def remote_show_link(item)
    link_to_remote 'Show', {:url => { :controller => @CcObjectClass.to_s.pluralize.underscore.to_sym, :action => :show, :id => item }, :method => :get,
            :complete => visual_effect(:blind_down, 'activity', :duration => 0.5 ),
    },{:href => url_for(:action => "show", :id => item.id) }
  end
  
  def remote_edit_name_link(item)
    link_to_remote item.name,
    {:url => { :controller => @CcObjectClass.to_s.pluralize.underscore.to_sym,
    :action => :edit_name, :id => item }, :method => :get,
            :complete => visual_effect(:blind_down, 'activity', :duration => 0.5 ),
    },{:href => url_for(:controller => item.class.to_s.pluralize.underscore, :action => "edit_name", :id => item.id) }
  end
  
  
  
  
  def remote_edit_field_link(item,field)
    link_to_remote item.send(field) ,
    {:url => { :controller => item.class.to_s.pluralize.underscore,
    :action => :edit_field, :id => item, :field => field },
    :method => :get},{:href => url_for(:controller => item.class.to_s.pluralize.underscore,
    :action => "edit_field", :id => item.id, :field => field) }
  end
  
  
  ##### end links #####
  
  
  ##### start dropdowns #####
  
  
  
  def filter_select(prefix, collection, selected = {})
    options = options_for_select([["No Filter", ""]])
    options += options_from_collection_for_select(collection, :id, :name, selected.to_i)
    return select_tag(prefix, options, {:onchange => "this.form.submit()"})
  end
  
  def remotenic_selector(prefix,selected = {}, options = {}, html_options = {})
    group_options = '<optgroup label="PleaseChoose"><option></optgroup>'
    group_options = group_options + option_groups_from_collection_for_select(HqSwitch.by_site(@hq_site), :hq_nics, :name, :id, :name, :selected => selected) 
    group_options = group_options + option_groups_from_collection_for_select(HqFirewall.by_site(@hq_site), :hq_nics, :name, :id, :name, :selected => selected)
    group_options = group_options + option_groups_from_collection_for_select(HqServer.by_site(@hq_site), :hq_nics, :name, :id, :name, :selected => selected)
    return select_tag(prefix+"[hq_remote_nic_id]", group_options)
  end
  
  def bridge_selector(prefix,selected = {}, options = {}, html_options = {})
    group_options = '<optgroup label="PleaseChoose"><option>From Physical Server</optgroup>'
    group_options = group_options + option_groups_from_collection_for_select([@object.hq_server], :hq_nics, :name, :id, :name, :selected => selected)
    return select_tag(prefix+"[hq_bridge_id]", group_options)
  end
  
  
  def site_select
    select("hq_site", "id", HqSite.all.collect {|p| [ p.name, p.id ] }, { :prompt => true},
    {:onchange => "this.form.submit()"})      
  end
  
  def polymorphic_belongs_to_selects(form)
    selects   = Array.new()
    polymorphic_belongs_to_associations(@CcObjectClass).collect {|y| y.name.to_s.camelize}.each do |owner|
      selects << belongs_to_select(form,owner)
    end
    
    return selects
  end
  
  
  
  def has_many_selects(form)
    selects   = Array.new()
    through_associations(@CcObjectClass).collect {|y| y.name.to_s.singularize.camelize}.each do |owner|
      selects << has_many_select(form,owner)
    end
    has_many_associations(@CcObjectClass).collect {|y| y.name.to_s.singularize.camelize}.each do |owner|
      selects << has_many_select(form,owner)
    end
    
    return selects
    
  end
  
  
  def inline_collection_select(prefix,key,collection_class, selected = {}, options = {}, html_options = {})
    finder =  eval(collection_class).columns.include?('template') ? 'template' : 'all'
    options = '<optgroup label="PleaseChoose"><option></optgroup>'    
    options = options + options_from_collection_for_select(eval(collection_class).send(finder+"(:order => 'name ASC')"), :id, :name, selected) if eval(collection_class).columns.include?('name')
    options = options + options_from_collection_for_select(eval(collection_class).send(finder), :id, :name, selected) unless eval(collection_class).columns.include?('name')
    return select_tag(prefix+"[#{key}]", options)
  end  
  
  def inline_grouped_collection_select(prefix,key,collection_classes, listitem, selected = {}, options = {}, html_options = {})
    finder =  eval(col_class).columns.include?('template') ? 'template' : 'all'
    group_options = '<optgroup label="PleaseChoose"><option>Please Choose</option></optgroup>'
    collection_classes.each do |col_class|
      group_options = group_options + option_groups_from_collection_for_select(col_class.send('finder'), listitems, :name, :id, :name, :selected => selected) 
    end
    return select_tag(prefix+"[#{key}]", group_options)
  end
  
  
  
  
  def belongs_to_select(form,owner)
    
    select = form.collection_select(owner.name.to_s.underscore+'_id',
    owner.all(:order => :name), :id, :name, {:prompt => true})
    return select
  end
  
  def polymorphic_belongs_to_select(form,owner)
    finder = eval(owner).columns.include?('template') ? 'template' : 'all'
    select = form.label(@object.send(owner.to_sym).screen_name)+'<br />'
    select = select + form.collection_select(owner.underscore+'_id', 
    owner.send(finder+'(:order => :name)'), :id, :name, {:prompt => true})+'<br />'
    return select
  end
  
  
  def has_many_select(form, owned)
    finder = eval(owned).columns.include?('template') ? 'template' : 'all'
    select = form.label(owned.screen_name)+'<br />'
    select = select + form.collection_select(owned.to_s.pluralize.underscore.to_sym,
                                             owned.send(finder+'(:order => :name)'), :id, :name,
    {:selected => @object.send(owned.to_s.underscore.pluralize.to_sym).collect {|x| x.id }},
    {:size => 10, :multiple => :true  })+'<br />'
    return select
  end
  
  def has_many_exclusive_select(form, owned)
    finder = eval(owned).columns.include?('template') ? 'template' : 'all'
    select = form.label(owned.screen_name)+'<br />'
    select = select + form.collection_select(owned.to_s.pluralize.underscore.to_sym,
                                             owned.send(finder+'(:conditions => "#{@CcObjectClass.to_s.underscore}_id is null", :order => :name)'), :id, :name,
    {:selected => @object.send(owned.to_s.underscore.pluralize.to_sym).collect {|x| x.id }},
    {:size => 10, :multiple => :true})+'<br />'
    return select
  end
  
  
  def belongs_to_selects(form)
    selects   = Array.new()
    belongs_to_associations(@CcObjectClass).collect {|y| eval(y.name.to_s.camelize)}.each do |owner|
      selects << belongs_to_select(form,owner)
    end
    
    return selects
  end
  
  
  
  ##### end dropdowns #####  
  
  ##### start hiddens #####
  def site_referrer_hiddens
    hiddens = hidden_field(:hq_site, :referrer_controller, :value => params[:referrer_controller]) if params[:referrer_controller]
    hiddens = hidden_field(:hq_site, :referrer_controller, :value => params[:controller]) unless params[:referrer_controller]
    
    hiddens += '<br />'
    
    hiddens += hidden_field(:hq_site, :referrer_action, :value => params[:referrer_action]) if params[:referrer_action]
    hiddens += hidden_field(:hq_site, :referrer_action, :value => params[:action]) unless params[:referrer_action]
    return hiddens
  end
  
  ##### end hiddens #####
  
  ##### start reflections #####
  def belongs_to_associations
    mymodel(self).reflect_on_all_associations(:belongs_to).reject {|x| x.options.include? :polymorphic}.reject{ |y| cls.excluded_from_reflected.include?(y.name)}
  end
  
  def belongs_to_associations(cls)
    cls.reflect_on_all_associations(:belongs_to).reject {|x| x.options.include? :polymorphic}.reject{ |y| cls.excluded_from_reflected.include?(y.name)}
  end
  
  
  def belongs_to_self(myitem)
    myselves = Array.new
    myselves = myitem.class.reflect_on_all_associations.select {|z| z.options.include? :foreign_key and z.name ==  myitem.class.to_s.underscore.to_sym }.collect {|y| y.name}.reject{ |y| cls.excluded_from_reflected.include?(y.name)}
    return myselves
  end
  
  
  
  
  
  
  def polymorphic_belongs_to_associations(cls)
    cls.reflect_on_all_associations(:belongs_to).select {|x| x.options.include? :polymorphic}.reject{ |y| cls.excluded_from_reflected.include?(y.name)}
  end
  
  
  
  
  def through_associations
    mymodel(self).reflect_on_all_associations(:has_many).select {|x| x.options.include? :through}.reject{ |y| cls.excluded_from_reflected.include?(y.name)}
  end
  
  def through_associations(cls)
    cls.reflect_on_all_associations(:has_many).select {|x| x.options.include? :through}.reject{ |y| cls.excluded_from_reflected.include?(y.name)}
  end
  
  
  
  def has_many_associations
    mymodel(self).reflect_on_all_associations(:has_many).reject {|x| x.options.include? :through or x.options.include? :as}.reject{ |y| cls.excluded_from_reflected.include?(y.name)}
  end
  
  def has_many_associations(cls)
    cls.reflect_on_all_associations(:has_many).reject {|x| x.options.include? :through or x.options.include? :as}.reject{ |y| cls.excluded_from_reflected.include?(y.name)}
  end
  
  
  
  
  def polymorphic_has_many_associations
    mymodel(self).reflect_on_all_associations(:has_many).select {|x| x.options.include? :as}.reject{ |y| cls.excluded_from_reflected.include?(y.name)}
  end
  
  def polymorphic_has_many_associations(cls)
    cls.reflect_on_all_associations(:has_many).select {|x| x.options.include? :as}.reject{ |y| cls.excluded_from_reflected.include?(y.name)}
  end
  
  ##### end reflections #####  
  
  
  
  
  
  
  
  
  
  def model_screen_name(controller)
    eval(controller.controller_name.singularize.camelize).screen_name
  end
  
  def mymodel(controller)
    eval(controller.controller_name.singularize.camelize)
  end
  
  
  
  
  
  
  
end
