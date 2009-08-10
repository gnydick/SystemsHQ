class HqDeployedSystemsController < ApplicationController
  before_filter :set_globals
  
  
  
  # GET /hq_deployed_systems
  # GET /hq_deployed_systems.xml
  def index
    hq_deployed_systems = HqDeployedSystem.by_site(@hq_site.id)
    
    @objects = hq_deployed_systems.paginate :page => params[:page], :per_page => 20
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_deployed_systems/1
  # GET /hq_deployed_systems/1.xml
  def show
    @object = @hq_deployed_system = HqDeployedSystem.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_deployed_system }
    end
  end
  
  # GET /hq_deployed_systems/new
  # GET /hq_deployed_systems/new.xml
  def new
    @object = @hq_deployed_system = HqDeployedSystem.new
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_deployed_system }
    end
  end
  
  # GET /hq_deployed_systems/1/edit
  def edit
    @object = @hq_deployed_system = HqDeployedSystem.find(params[:id])
    
    
    
    @hq_slices = HqSlice.by_site(cookies[:hq_site_id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_deployed_systems
  # POST /hq_deployed_systems.xml
  def create
    @hq_deployed_system = HqDeployedSystem.new(params[:hq_deployed_system])
   
    
    respond_to do |format|
      if @hq_deployed_system.save
        flash[:notice] = 'Deployed System was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_deployed_system, :status => :created, :location => @hq_deployed_system }
      else
        messages = '<ul>Error:'
        @hq_deployed_system.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_deployed_system.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_deployed_systems/1
  # PUT /hq_deployed_systems/1.xml
  def update
    
    @object = HqDeployedSystem.find(params[:id])
    

    
    
    @hq_deployed_system = HqDeployedSystem.find(params[:id])
    respond_to do |format|
      if @hq_deployed_system.update_attributes(params[:hq_deployed_system])
        flash[:notice] = 'Deployed System was successfully updated.'
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_deployed_system.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_deployed_system.errors, :status => :unprocessable_entity }
      end
      
      
    end
  end
  
  # DELETE /hq_deployed_systems/1
  # DELETE /hq_deployed_systems/1.xml
  def destroy
    @hq_deployed_system = HqDeployedSystem.find(params[:id])
    @hq_deployed_system.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_deployed_systems_url) }
      format.xml  { head :ok }
    end
  end
  private
  def set_globals
    @CcObjectClass = HqDeployedSystem
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Deployed System'
    @symbol_name = 'hq_deployed_system'
    @symbols_name = 'hq_deployed_systems'
  end
end
