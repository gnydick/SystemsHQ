class HqAppsController < ApplicationController
  
  
  before_filter :set_globals
  # GET /hq_apps
  # GET /hq_apps.xml
  @page = ''
  def index
    @objects = HqApp.all(:order => 'name ASC').paginate :page => params[:page], :per_page => 10
    
    
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_apps/1
  # GET /hq_apps/1.xml
  def show
    @item = @object = HqApp.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' } if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_app }
    end
  end
  
  # GET /hq_apps/new
  # GET /hq_apps/new.xml
  def new
    @item = @object = @hq_app = HqApp.new
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_app }
    end
  end
  
  # GET /hq_apps/1/edit
  def edit
   @item = @object = @hq_app = HqApp.find(params[:id])
    
    
    
    @hq_slices = HqSlice.by_site(cookies[:hq_site_id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_apps
  # POST /hq_apps.xml
  def create
    @hq_app = HqApp.new(params[:hq_app])
    params[:hq_app][:new_hq_task_attributes] ||= {}
    params[:hq_app][:existing_hq_task_attributes] ||= {}
    
    respond_to do |format|
      if @hq_app.save
        flash[:notice] = 'Application was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_app, :status => :created, :location => @hq_app }
      else
        messages = '<ul>Error:'
        @hq_app.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_app.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_apps/1
  # PUT /hq_apps/1.xml
  def update
    @list = HqApp.all(:order => :name)
    @item = HqApp.find(params[:id])
    
   params[:hq_app][:new_hq_task_attributes] ||= {}
    params[:hq_app][:existing_hq_task_attributes] ||= {}
    
    
    @hq_app = HqApp.find(params[:id])
    respond_to do |format|
      if @hq_app.update_attributes(params[:hq_app])
     
        flash[:notice] = 'Application was successfully updated.'
        format.js if request.xhr?
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_app.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_app.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_apps/1
  # DELETE /hq_apps/1.xml
  def destroy
    @hq_app = HqApp.find(params[:id])
    @hq_app.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_apps_url) }
      format.xml  { head :ok }
    end
  end
  private
  def set_globals
    @CcObjectClass = HqApp
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Application'
    @symbol_name = 'hq_app'
    @symbols_name = 'hq_apps'
  end
end
