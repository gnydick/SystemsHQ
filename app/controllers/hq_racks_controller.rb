class HqRacksController < ApplicationController
  before_filter :set_globals
  
  # GET /hq_racks
  # GET /hq_racks.xml
  def index
    
    @filters = Hash.new
    HqRack.filters.each do |filter|
      value = params[filter.to_s+'_id'].to_i
      @filters[filter.to_s] = Array.new
      if value > 0
        @filters[filter.to_s] = eval(filter.to_s.camelize).find(value).id
      else
        @filters[filter.to_s] = eval(filter.to_s.camelize).all.collect(&:id)
      end
    end
    
    hq_racks = HqRack.by_cage(@filters['hq_cage'])
    @objects = hq_racks.paginate :page => params[:page], :per_page => 20
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_racks/1
  # GET /hq_racks/1.xml
  def show
    @object = HqRack.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_rack }
    end
  end
  
  # GET /hq_racks/new
  # GET /hq_racks/new.xml
  def new
    @object = @hq_rack = HqRack.new(:hq_site_id => @hq_site.id)    
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_rack }
    end
  end
  
  # GET /hq_racks/1/edit
  def edit
    @object = @hq_rack = HqRack.find(params[:id])
    @hq_racks = @hq_rack.hq_site.hq_racks
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_racks
  # POST /hq_racks.xml
  def create
    @hq_rack = HqRack.new(params[:hq_rack])
    @hq_rack.update_attributes(:hq_site_id => cookies[:hq_site_id])
    if params[:hq_rack][:new_hq_switch_attributes]
      params[:hq_rack][:new_hq_switch_attributes][:hq_site_id]=cookies[:hq_site_id]
    else
      params[:hq_rack][:new_hq_switch_attributes] ||= {}
    end
    
    if params[:hq_rack][:new_hq_server_attributes] ||= {}
      params[:hq_rack][:new_hq_server_attributes][:hq_site_id]=cookies[:hq_site_id]
    else
      params[:hq_rack][:new_hq_server_attributes] ||= {}
    end
    
    if params[:hq_rack][:new_hq_diskarray_attributes] ||= {}
      params[:hq_rack][:new_hq_diskarray_attributes][:hq_site_id]=cookies[:hq_site_id]
    else
      params[:hq_rack][:new_hq_diskarray_attributes] ||= {}
    end
    
    
    respond_to do |format|
      if @hq_rack.save
        flash[:notice] = 'Rack was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_rack, :status => :created, :location => @hq_rack }
      else
        messages = '<ul>Error:'
        @hq_rack.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_rack.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # PUT /hq_racks/1
  # PUT /hq_racks/1.xml
  def update
    
    
    params[:hq_rack][:new_hq_switch_attributes] ||= {}
    
    
    params[:hq_rack][:new_hq_server_attributes] ||= {}
    
    
    params[:hq_rack][:new_hq_diskarray_attributes] ||= {}
    
    
    
    
    params[:hq_rack][:existing_hq_switch_attributes] ||= {}
    
    
    
    params[:hq_rack][:existing_hq_server_attributes] ||= {}
    
    
    
    params[:hq_rack][:existing_hq_diskarray_attributes] ||= {}
    
    
    
    
    
    
    @hq_rack = HqRack.find(params[:id]) 
    respond_to do |format|
      if @hq_rack.update_attributes(params[:hq_rack])
        flash[:notice] = 'Rack was successfully updated.'
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_rack.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_rack.errors, :status => :unprocessable_entity }
      end
      
    end
  end 
  
  
  # DELETE /hq_racks/1
  # DELETE /hq_racks/1.xml
  def destroy
    @hq_rack = HqRack.find(params[:id])
    @hq_rack.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_racks_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def set_globals
    @CcObjectClass = HqRack
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Rack'
    @symbol_name = 'hq_rack'
    @symbols_name = 'hq_racks'
  end
end
