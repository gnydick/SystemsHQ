class HqVserversController < ApplicationController
  
  
  before_filter :set_globals
  # GET /hq_vservers
  # GET /hq_vservers.xml
  def index   
    server_id = params[:hq_server_id].to_i > 0 ? params[:hq_server_id].to_i : HqServer.by_site(@hq_site).collect(&:id)
    hq_vservers = HqVserver.by_server(server_id)
    @objects = hq_vservers.paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_vservers/1
  # GET /hq_vservers/1.xml
  def show
    @object = @hq_vserver = HqVserver.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_vserver }
    end
  end
  
  # GET /hq_vservers/new
  # GET /hq_vservers/new.xml
  def new
    @object = @hq_vserver = HqVserver.new
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_vserver }
    end
  end
  
  # GET /hq_vservers/1/edit
  def edit
    
    @object = @hq_vserver = HqVserver.find(params[:id])
    
    
    
    @hq_slices = HqSlice.by_site(cookies[:hq_site_id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_vservers
  # POST /hq_vservers.xml
  def create
    @hq_vserver = HqVserver.new(params[:hq_vserver])
    params[:hq_vserver][:new_hq_vnic_attributes] ||= {}
    params[:hq_vserver][:new_hq_slice_attributes] ||= {}
    
    respond_to do |format|
      if @hq_vserver.save
        flash[:notice] = 'Virtual Server was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_vserver, :status => :created, :location => @hq_vserver }
      else
        messages = '<ul>Error:'
        @hq_vserver.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_vserver.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_vservers/1
  # PUT /hq_vservers/1.xml
  def update
    @list = HqVserver.all(:order => :name)
    @object = HqVserver.find(params[:id])
    
    params[:hq_vserver][:existing_hq_vnic_attributes] ||= {}
    params[:hq_vserver][:existing_hq_slice_attributes] ||= {}
    params[:hq_vserver][:new_hq_vnic_attributes] ||= {}
    params[:hq_vserver][:new_hq_slice_attributes] ||= {}
    
    
    @hq_vserver = HqVserver.find(params[:id])
    respond_to do |format|
      if @hq_vserver.update_attributes(params[:hq_vserver])
        @objects = HqVserver.by_site(cookies[:hq_site_id])
        flash[:notice] = 'Virtual Server was successfully updated.'
        format.js {redirect_to :action => 'edit', :template => 'reflected/edit' } if request.xhr?
        format.html { redirect_to :action => 'edit', :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_vserver.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_vserver.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_vservers/1
  # DELETE /hq_vservers/1.xml
  def destroy
    @hq_vserver = HqVserver.find(params[:id])
    @hq_vserver.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_vservers_url) }
      format.xml  { head :ok }
    end
  end
  private
  def set_globals
    @CcObjectClass = HqVserver
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Virtual Server'
    @symbol_name = 'hq_vserver'
    @symbols_name = 'hq_vservers'
  end
end
