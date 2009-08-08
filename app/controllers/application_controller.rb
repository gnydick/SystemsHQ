# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  
  
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  
  before_filter :select_site
  

  def select_site 
   
    if cookies[:hq_site_id]
      @hq_site = HqSite.find(cookies[:hq_site_id])
    else 
      flash[:notice] = "Please select a Site" 
      redirect_to :controller => :hq_sites, :action => :select, :referrer_controller => request.path_parameters[:controller],
      :referrer_action => request.path_parameters[:action]
    end 
  end 
  
  
  
  
end
