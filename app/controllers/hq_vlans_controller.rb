class HqVlansController < ApplicationController
  
  before_filter :set_globals
  # GET /hq_vlans
  # GET /hq_vlans.xml
  def index     
    hq_vlans = HqVlan.all(:order => :name)
    @objects = hq_vlans.paginate :page => params[:page], :per_page => 20
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_vlans/1
  # GET /hq_vlans/1.xml
  def show
    @object = @hq_vlan = HqVlan.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_vlan }
    end
  end
  
  # GET /hq_vlans/new
  # GET /hq_vlans/new.xml
  def new
    @object = @hq_vlan = HqVlan.new
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_vlan }
    end
  end
  
  # GET /hq_vlans/1/edit
  def edit
    
    @object = @hq_vlan = HqVlan.find(params[:id])
    
    
    @hq_slices = HqSlice.by_site(cookies[:hq_site_id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_vlans
  # POST /hq_vlans.xml
  def create
    @hq_vlan = HqVlan.new(params[:hq_vlan])
    params[:hq_vlan][:assigned_hq_nic] ||= {}
    
    respond_to do |format|
      if @hq_vlan.save
        flash[:notice] = 'Virtual Server was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_vlan, :status => :created, :location => @hq_vlan }
      else
        messages = '<ul>Error:'
        @hq_vlan.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_vlan.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_vlans/1
  # PUT /hq_vlans/1.xml
  def update
    @list = HqVlan.all(:order => :name)
    @object = HqVlan.find(params[:id])
    
    params[:hq_vlan][:assigned_hq_nic] ||= {}
    
    @hq_vlan = HqVlan.find(params[:id])
    respond_to do |format|
      if @hq_vlan.update_attributes(params[:hq_vlan])
        @objects = HqVlan.all(:order => 'name ASC')
        flash[:notice] = 'Virtual Server was successfully updated.'
        format.js {redirect_to :action => 'edit', :template => 'reflected/edit' } if request.xhr?
        format.html { redirect_to :action => 'edit', :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_vlan.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_vlan.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_vlans/1
  # DELETE /hq_vlans/1.xml
  def destroy
    @hq_vlan = HqVlan.find(params[:id])
    @hq_vlan.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_vlans_url) }
      format.xml  { head :ok }
    end
  end
  private
  def set_globals
    @CcObjectClass = HqVlan
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'VLAN'
    @symbol_name = 'hq_vlan'
    @symbols_name = 'hq_vlans'
  end
end
