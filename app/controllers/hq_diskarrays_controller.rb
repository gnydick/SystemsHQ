class HqDiskarraysController < ApplicationController
  
  
  before_filter :set_globals
  # GET /hq_diskarrays
  # GET /hq_diskarrays.xml
  
  def index
    @filters = Hash.new
    
    HqDiskarray.filters.each do |filter|
      value = params[filter.to_s+'_id'].to_i
      @filters[filter.to_s] = Array.new
      if value > 0
        @filters[filter.to_s] = eval(filter.to_s.camelize).find(value).id
      else
        @filters[filter.to_s] = eval(filter.to_s.camelize).all.collect(&:id)
      end
    end
    
    hq_diskarrays = HqDiskarray.by_rack(@filters['hq_rack']).by_san(@filters['hq_san'])
    @objects = hq_diskarrays.paginate :page => params[:page], :per_page => 20
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_diskarrays/1
  # GET /hq_diskarrays/1.xml
  def show
    @object = @hq_diskarray = HqDiskarray.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_diskarray }
    end
  end
  
  # GET /hq_diskarrays/new
  # GET /hq_diskarrays/new.xml
  def new
    @object = @hq_diskarray = HqDiskarray.new
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_diskarray }
    end
  end
  
  # GET /hq_diskarrays/1/edit
  def edit
    @object = @hq_diskarray = HqDiskarray.find(params[:id])
    
    
    
    @hq_slices = HqSlice.by_site(cookies[:hq_site_id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_diskarrays
  # POST /hq_diskarrays.xml
  def create
    @hq_diskarray = HqDiskarray.new(params[:hq_diskarray])
    params[:hq_diskarray][:new_hq_nic_attributes] ||= {}
    
    
    respond_to do |format|
      if @hq_diskarray.save
        flash[:notice] = 'Disk Array was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_diskarray, :status => :created, :location => @hq_diskarray }
      else
        messages = '<ul>Error:'
        @hq_diskarray.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_diskarray.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_diskarrays/1
  # PUT /hq_diskarrays/1.xml
  def update
    @list = HqDiskarray.all(:order => :name)
    @object = HqDiskarray.find(params[:id])
    
    params[:hq_diskarray][:existing_hq_nic_attributes] ||= {}
    params[:hq_diskarray][:new_hq_nic_attributes] ||= {}
    
    
    
    @hq_diskarray = HqDiskarray.find(params[:id])
    respond_to do |format|
      if @hq_diskarray.update_attributes(params[:hq_diskarray])
        @objects = HqDiskarray.by_site(cookies[:hq_site_id])
        flash[:notice] = 'Disk Array was successfully updated.'
        format.js if request.xhr?
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_diskarray.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_diskarray.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_diskarrays/1
  # DELETE /hq_diskarrays/1.xml
  def destroy
    @hq_diskarray = HqDiskarray.find(params[:id])
    @hq_diskarray.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_diskarrays_url) }
      format.xml  { head :ok }
    end
  end
  private
  def set_globals
    @CcObjectClass = HqDiskarray
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Disk Array'
    @symbol_name = 'hq_diskarray'
    @symbols_name = 'hq_diskarrays'
  end
end
