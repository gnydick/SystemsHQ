class HqSwitchesController < ApplicationController
  before_filter :set_globals
  
  # GET /hq_switches
  # GET /hq_switches.xml
  def index
    
    @filters = Hash.new
    
    HqSwitch.filters.each do |filter|
      value = params[filter.to_s+'_id'].to_i
      @filters[filter.to_s] = Array.new
      if value > 0
        @filters[filter.to_s] = eval(filter.to_s.camelize).find(value).id
      else
        @filters[filter.to_s] = eval(filter.to_s.camelize).all.collect(&:id)
      end
    end
    
    hq_switches = HqSwitch.by_rack(@filters['hq_rack'])
    @objects = hq_switches.paginate :page => params[:page], :per_page => 20
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_switches/1
  # GET /hq_switches/1.xml
  def show
    @object = @hq_switch = HqSwitch.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_switch }
    end
  end
  
  # GET /hq_switches/new
  # GET /hq_switches/new.xml
  def new
    @object = @hq_switch = HqSwitch.new(:hq_site_id => @hq_site.id)    
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_switch }
    end
  end
  
  # GET /hq_switches/1/edit
  def edit
    @object = @hq_switch = HqSwitch.find(params[:id])
    @hq_racks = @hq_switch.hq_site.hq_racks
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_switches
  # POST /hq_switches.xml
  def create
    @hq_switch = HqSwitch.new(params[:hq_switch])
    @hq_switch.update_attributes(:hq_site_id => cookies[:hq_site_id])
    params[:hq_switch][:existing_hq_nic_attributes] ||= {}
    params[:hq_switch][:new_hq_nic_attributes] ||= {}
    respond_to do |format|
      if @hq_switch.save
        flash[:notice] = 'Switch was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_switch, :status => :created, :location => @hq_switch }
      else
        messages = '<ul>Error:'
        @hq_switch.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_switch.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # PUT /hq_switches/1
  # PUT /hq_switches/1.xml
  def update
    
    params[:hq_switch][:existing_hq_nic_attributes] ||= {}
    params[:hq_switch][:new_hq_nic_attributes] ||= {}
    
    
    @hq_switch = HqSwitch.find(params[:id]) 
    respond_to do |format|
      if @hq_switch.update_attributes(params[:hq_switch])
        flash[:notice] = 'Switch was successfully updated.'
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_switch.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_switch.errors, :status => :unprocessable_entity }
      end
      
    end
  end 
  
  
  # DELETE /hq_switches/1
  # DELETE /hq_switches/1.xml
  def destroy
    @hq_switch = HqSwitch.find(params[:id])
    @hq_switch.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_switches_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def set_globals
    @CcObjectClass = HqSwitch
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Switch'
    @symbol_name = 'hq_switch'
    @symbols_name = 'hq_switches'
  end
end
