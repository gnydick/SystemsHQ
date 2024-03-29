class HqServersController < ApplicationController
  before_filter :set_globals
  
  # GET /hq_servers
  # GET /hq_servers.xml
  def index
    @filters = Hash.new
    HqServer.filters.each do |filter|
      value = params[filter.to_s+'_id'].to_i
      @filters[filter.to_s] = Array.new
      if value > 0
        @filters[filter.to_s] = eval(filter.to_s.camelize).find(value).id
      else
        @filters[filter.to_s] = eval(filter.to_s.camelize).all.collect(&:id)
      end
    end
    
    hq_servers = HqServer.by_rack(@filters['hq_rack'])
    @objects = hq_servers.paginate :page => params[:page], :per_page => 20
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_servers/1
  # GET /hq_servers/1.xml
  def show
    @object = @hq_server = HqServer.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_server }
    end
  end
  
  # GET /hq_servers/new
  # GET /hq_servers/new.xml
  def new
    @object = @hq_server = HqServer.new(:hq_site_id => @hq_site.id)    
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_server }
    end
  end
  
  # GET /hq_servers/1/edit
  def edit
    @object = @hq_server = HqServer.find(params[:id])
    @hq_racks = @hq_server.hq_site.hq_racks
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_servers
  # POST /hq_servers.xml
  def create
    @hq_server = HqServer.new(params[:hq_server])
    @hq_server.update_attributes(:hq_site_id => cookies[:hq_site_id])
    
    respond_to do |format|
      if @hq_server.save
        flash[:notice] = 'Server was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_server, :status => :created, :location => @hq_server }
      else
        messages = '<ul>Error:'
        @hq_server.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_server.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # PUT /hq_servers/1
  # PUT /hq_servers/1.xml
  def update
    params[:hq_server][:existing_hq_vserver_attributes] ||= {}
    params[:hq_server][:existing_hq_nic_attributes] ||= {}
    
    
    @hq_server = HqServer.find(params[:id]) 
    respond_to do |format|
      if @hq_server.update_attributes(params[:hq_server])
        flash[:notice] = 'Server was successfully updated.'
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_server.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_server.errors, :status => :unprocessable_entity }
      end
      
    end
  end 
  
  
  # DELETE /hq_servers/1
  # DELETE /hq_servers/1.xml
  def destroy
    @hq_server = HqServer.find(params[:id])
    @hq_server.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_servers_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def set_globals
    @CcObjectClass = HqServer
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Server'
    @symbol_name = 'hq_server'
    @symbols_name = 'hq_servers'
  end
end
