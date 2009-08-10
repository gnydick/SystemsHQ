class HqSitesController < ApplicationController
  protect_from_forgery :only => [:update, :destroy, :create]
  
  
  skip_before_filter :select_site
  before_filter :set_globals
  
  def select
    @hq_sites = HqSite.all(:order => :name)
    respond_to do |format|     
      format.html 
    end
  end
  
  def set    
    @hq_site = HqSite.find(params[:hq_site][:id])
    cookies[:hq_site_id] = {
          :expire => 1.year.from_now,
   :value => @hq_site.id.to_s
    }
    respond_to do |format|
      format.js { }if request.xhr?
      format.html { redirect_to  :controller => params[:hq_site][:referrer_controller], :action => params[:hq_site][:referrer_action] }
      
    end
  end
  
  
  
  # GET /hq_sites
  # GET /hq_sites.xml
  def index
    @objects = HqSite.all(:order => 'name ASC').paginate :page => params[:page], :per_page => 20
    
    
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_sites/1
  # GET /hq_sites/1.xml
  def show
    @object = @hq_site = HqSite.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_site }
    end
  end
  
  # GET /hq_sites/new
  # GET /hq_sites/new.xml
  def new
    @object = @hq_site = HqSite.new
    
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_site }
    end
  end
  
  # GET /hq_sites/1/edit
  def edit
    @object = @hq_site = HqSite.find(params[:id])
    
    
    
    @hq_slices = HqSlice.by_site(cookies[:hq_site_id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_sites
  # POST /hq_sites.xml
  def create
    @hq_site = HqSite.new(params[:hq_site])
    
    params[:hq_site][:new_hq_switch_attributes] ||= {}
    
    params[:hq_site][:new_hq_server_attributes] ||= {}
    
    params[:hq_site][:new_hq_diskarray_attributes] ||= {}
    
    
    
    params[:hq_site][:new_hq_cage_attributes] ||= {}
    
    
    params[:hq_site][:new_hq_rack_attributes] ||= {}
    
    
    respond_to do |format|
      if @hq_site.save
        flash[:notice] = 'Site was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_site, :status => :created, :location => @hq_site }
      else
        messages = '<ul>Error:'
        @hq_site.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_site.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_sites/1
  # PUT /hq_sites/1.xml
  def update
    @list = HqSite.all(:order => :name)
    @object = HqSite.find(params[:id])
    
    
    params[:hq_site][:new_hq_switch_attributes] ||= {}
    
    
    params[:hq_site][:new_hq_server_attributes] ||= {}
    
    params[:hq_site][:new_hq_diskarray_attributes] ||= {}
    params[:hq_site][:new_hq_cage_attributes] ||= {}
    
    params[:hq_site][:new_hq_rack_attributes] ||= {}
    
    params[:hq_site][:existing_hq_switch_attributes] ||= {}
    
    
    params[:hq_site][:existing_hq_server_attributes] ||= {}
    
    
    params[:hq_site][:existing_hq_diskarray_attributes] ||= {}
    
    params[:hq_site][:existing_hq_cage_attributes] ||= {}
    
    params[:hq_site][:existing_hq_rack_attributes] ||= {}
    
    
    
    @hq_site = HqSite.find(params[:id])
    respond_to do |format|
      if @hq_site.update_attributes(params[:hq_site])
        @objects = HqSite.all
        flash[:notice] = 'Site was successfully updated.'
        format.js if request.xhr?
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_site.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_site.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_sites/1
  # DELETE /hq_sites/1.xml
  def destroy
    @hq_site = HqSite.find(params[:id])
    @hq_site.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_sites_url) }
      format.xml  { head :ok }
    end
  end
  private
  def set_globals
    @CcObjectClass = HqSite
    #    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Site'
    @symbol_name = 'hq_site'
    @symbols_name = 'hq_sites'
  end
end
