class HqSystemsController < ApplicationController
  
  
  before_filter :set_globals
  # GET /hq_systems
  # GET /hq_systems.xml
  @page = ''
  def index
    @objects = HqSystem.all(:order => 'name ASC').paginate :page => params[:page], :per_page => 10
    
    
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_systems/1
  # GET /hq_systems/1.xml
  def show
    @item = @object = HqSystem.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_system }
    end
  end
  
  # GET /hq_systems/new
  # GET /hq_systems/new.xml
  def new
    @item = @object = @hq_system = HqSystem.new
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_system }
    end
  end
  
  # GET /hq_systems/1/edit
  def edit
    @item = @object = @hq_system = HqSystem.find(params[:id])
    
    
    
    @hq_slices = HqSlice.by_site(cookies[:hq_site_id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_systems
  # POST /hq_systems.xml
  def create
    @hq_system = HqSystem.new(params[:hq_system])
    params[:hq_system][:new_hq_app_attributes] ||= {}
    params[:hq_system][:existing_hq_app_attributes] ||= {}
    
    respond_to do |format|
      if @hq_system.save
        flash[:notice] = 'System was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_system, :status => :created, :location => @hq_system }
      else
        messages = '<ul>Error:'
        @hq_system.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_system.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_systems/1
  # PUT /hq_systems/1.xml
  def update
    @list = HqSystem.all(:order => :name)
    @item = HqSystem.find(params[:id])
    
    params[:hq_system][:new_hq_app_attributes] ||= {}
    params[:hq_system][:existing_hq_app_attributes] ||= {}
    
    
    @hq_system = HqSystem.find(params[:id])
    respond_to do |format|
      if @hq_system.update_attributes(params[:hq_system])
        @objects = HqSystem.all
        flash[:notice] = 'System was successfully updated.'
        format.js if request.xhr?
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_system.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_system.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_systems/1
  # DELETE /hq_systems/1.xml
  def destroy
    @hq_system = HqSystem.find(params[:id])
    @hq_system.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_systems_url) }
      format.xml  { head :ok }
    end
  end
  private
  def set_globals
    @CcObjectClass = HqSystem
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'System'
    @symbol_name = 'hq_system'
    @symbols_name = 'hq_systems'
  end
end
