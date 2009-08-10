class HqFirewallsController < ApplicationController
  before_filter :set_globals
  
  # GET /hq_firewalls
  # GET /hq_firewalls.xml
  def index
    @filters = Hash.new
    HqFirewall.filters.each do |filter|
      value = params[filter.to_s+'_id'].to_i
      @filters[filter.to_s] = Array.new
      if value > 0
        @filters[filter.to_s] = eval(filter.to_s.camelize).find(value).id
      else
        @filters[filter.to_s] = eval(filter.to_s.camelize).all.collect(&:id)
      end
    end
    
    hq_firewalls = HqFirewall.by_rack(@filters['hq_rack'])
    @objects = hq_firewalls.paginate :page => params[:page], :per_page => 20
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_firewalls/1
  # GET /hq_firewalls/1.xml
  def show
    @object = @hq_firewall = HqFirewall.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_firewall }
    end
  end
  
  # GET /hq_firewalls/new
  # GET /hq_firewalls/new.xml
  def new
    @object = @hq_firewall = HqFirewall.new(:hq_site_id => @hq_site.id)    
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_firewall }
    end
  end
  
  # GET /hq_firewalls/1/edit
  def edit
    @object = @hq_firewall = HqFirewall.find(params[:id])
    @hq_racks = @hq_firewall.hq_site.hq_racks
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_firewalls
  # POST /hq_firewalls.xml
  def create
    @hq_firewall = HqFirewall.new(params[:hq_firewall])
    @hq_firewall.update_attributes(:hq_site_id => cookies[:hq_site_id])
    params[:hq_firewall][:existing_hq_nic_attributes] ||= {}
    params[:hq_firewall][:new_hq_nic_attributes] ||= {}
    respond_to do |format|
      if @hq_firewall.save
        flash[:notice] = 'Firewall was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_firewall, :status => :created, :location => @hq_firewall }
      else
        messages = '<ul>Error:'
        @hq_firewall.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_firewall.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # PUT /hq_firewalls/1
  # PUT /hq_firewalls/1.xml
  def update
    
    params[:hq_firewall][:existing_hq_nic_attributes] ||= {}
    params[:hq_firewall][:new_hq_nic_attributes] ||= {}
    
    
    @hq_firewall = HqFirewall.find(params[:id]) 
    respond_to do |format|
      if @hq_firewall.update_attributes(params[:hq_firewall])
        flash[:notice] = 'Firewall was successfully updated.'
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_firewall.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_firewall.errors, :status => :unprocessable_entity }
      end
      
    end
  end 
  
  
  # DELETE /hq_firewalls/1
  # DELETE /hq_firewalls/1.xml
  def destroy
    @hq_firewall = HqFirewall.find(params[:id])
    @hq_firewall.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_firewalls_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def set_globals
    @CcObjectClass = HqFirewall
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Firewall'
    @symbol_name = 'hq_firewall'
    @symbols_name = 'hq_firewalls'
  end
end
