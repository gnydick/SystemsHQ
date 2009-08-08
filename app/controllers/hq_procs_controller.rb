class HqProcsController < ApplicationController
  before_filter :set_globals
  
  def order
    params[:hq_procs].each_index do |i|
      hq_proc = HqProc.find(params[:hq_procs][i])
      hq_proc.position = i + 1
      hq_proc.save
    end
    
    respond_to do |format|      
      format.js   { render :template => 'reflected/order' } if request.xhr? 
      format.html { render :template => 'reflected/index' }      
    end
  end
  
  
  
  # GET /hq_procs
  # GET /hq_procs.xml
  @page = ''
  def index
    @objects = HqProc.all(:order => 'name ASC').paginate :page => params[:page], :per_page => 10
    
    
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_procs/1
  # GET /hq_procs/1.xml
  def show
    @item = @object = @hq_proc = HqProc.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_proc }
    end
  end
  
  # GET /hq_procs/new
  # GET /hq_procs/new.xml
  def new
    @item = @object = @hq_proc = HqProc.new
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_proc }
    end
  end
  
  # GET /hq_procs/1/edit
  def edit
    @item = @object = @hq_proc = HqProc.find(params[:id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_procs
  # POST /hq_procs.xml
  def create
    @hq_proc = HqProc.new(params[:hq_proc])
    
    params[:hq_proc][:new_hq_rsrc_usage_attributes] ||= {}
    params[:hq_proc][:existing_hq_rsrc_usage_attributes] ||= {}
    params[:hq_proc][:assigned_hq_rsrc] ||= {}
    respond_to do |format|
      if @hq_proc.save
        flash[:notice] = 'Process was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_proc, :status => :created, :location => @hq_proc }
      else
        messages = '<ul>Error:'
        @hq_proc.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_proc.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_procs/1
  # PUT /hq_procs/1.xml
  def update
    @list = HqProc.all(:order => :name)
    @item = HqProc.find(params[:id])
    
    
    params[:hq_proc][:new_hq_rsrc_usage_attributes] ||= {}
    params[:hq_proc][:existing_hq_rsrc_usage_attributes] ||= {}
    params[:hq_proc][:assigned_hq_rsrc] ||= {}
    
    @hq_proc = HqProc.find(params[:id])
    respond_to do |format|
      if @hq_proc.update_attributes(params[:hq_proc])
        @objects = HqProc.all(:order => 'name ASC')
        flash[:notice] = 'Process was successfully updated.'
        format.js if request.xhr?
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_proc.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_proc.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_procs/1
  # DELETE /hq_procs/1.xml
  def destroy
    @hq_proc = HqProc.find(params[:id])
    @hq_proc.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_procs_url) }
      format.xml  { head :ok }
    end
  end
  private
  def set_globals
    @CcObjectClass = HqProc
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Process'
    @symbol_name = 'hq_proc'
    @symbols_name = 'hq_procs'
  end
end
