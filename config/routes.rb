ActionController::Routing::Routes.draw do |map|
  map.resources :hq_deployed_systems
  map.resources :syshq_nav_section_items
  
  map.resources :syshq_nav_sections
  
  
  map.resources :ppt_classes
  
  map.resources :ppt_nodes
  
  
  
  map.resources :hq_vlans
  map.resources :hq_sans
  
  map.resources :hq_slices
  
  map.resources :hq_diskarrays
  
  map.site "/hq_sites/select", :controller => 'hq_sites', :action => 'select', :method => :get
  
  map.resources :hq_procs
  
  map.resources :hq_tasks
  
  map.resources :hq_rsrcs
  
  map.resources :hq_rsrc_usages 
  
  map.resources :hq_apps, :has_many => :hq_tasks
  
  map.resources :hq_systems, :member => { :report => :get }
  
  map.resources :hq_vservers
  
  map.resources :hq_sites, :member => { :set_site_scope => :post }
  
  map.resources :hq_envs
  
  map.resources :hq_servers,  :member => {:get_site_inventory => :post }
  
  map.resources :hq_switches, :member => {:get_site_inventory => :post}
  
  map.resources :hq_cages
  
  map.resources :hq_racks,  :member => { :get_cage_inventory => :post }
  
  map.resources :hq_firewalls
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action
  
  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)
  
  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products
  
  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }
  
  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end
  
  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
  
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  
  # See how all your routes lay out with "rake routes"
  
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.root :controller => "hq_systems"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
