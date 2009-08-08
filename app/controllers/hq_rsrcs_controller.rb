class HqRsrcsController < ApplicationController
  before_filter :set_globals
  # GET /hq_rsrcs
  # GET /hq_rsrcs.xml
  
  def index
    
    hq_rsrcs = HqRsrcUsage.find_all_by_hq_proc_id(params[:hq_proc_id]).collect {|x| HqRsrc.find(x.hq_rsrc_id)}.paginate :page => params[:page], :per_page => 10 if params[:hq_proc_id].to_i > 0
    hq_rsrcs = HqRsrc.all(:order => 'name ASC').paginate :page => params[:page], :per_page => 10 unless params[:hq_proc_id].to_i > 0 
    
    @objects = hq_rsrcs
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_rsrcs/1
  # GET /hq_rsrcs/1.xml
  def show
    @object = @hq_rsrc = HqRsrc.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_rsrc }
    end
  end
  
  # GET /hq_rsrcs/new
  # GET /hq_rsrcs/new.xml
  def new
    @object = @hq_rsrc = HqRsrc.new
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_rsrc }
    end
  end
  
  # GET /hq_rsrcs/1/edit
  def edit
    @object = @hq_rsrc = HqRsrc.find(params[:id])
    
    
    
    @hq_slices = HqSlice.by_site(cookies[:hq_site_id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_rsrcs
  # POST /hq_rsrcs.xml
  def create
    @hq_rsrc = HqRsrc.new(params[:hq_rsrc])
    params[:hq_rsrc][:new_hq_rsrc_usage_attributes] ||= {}
    params[:hq_rsrc][:existing_hq_rsrc_usage_attributes] ||= {}
    
    respond_to do |format|
      if @hq_rsrc.save
        flash[:notice] = 'Resource was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_rsrc, :status => :created, :location => @hq_rsrc }
      else
        messages = '<ul>Error:'
        @hq_rsrc.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_rsrc.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_rsrcs/1
  # PUT /hq_rsrcs/1.xml
  def update
    @list = HqRsrc.all(:order => :name)
    @object = HqRsrc.find(params[:id])
    params[:hq_rsrc][:new_hq_rsrc_usage_attributes] ||= {}
    params[:hq_rsrc][:existing_hq_rsrc_usage_attributes] ||= {}
    
    
    @hq_rsrc = HqRsrc.find(params[:id])
    respond_to do |format|
      if @hq_rsrc.update_attributes(params[:hq_rsrc])
        @objects = HqRsrc.all
        flash[:notice] = 'Resource was successfully updated.'
        format.js if request.xhr?
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_rsrc.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_rsrc.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_rsrcs/1
  # DELETE /hq_rsrcs/1.xml
  def destroy
    @hq_rsrc = HqRsrc.find(params[:id])
    @hq_rsrc.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_rsrcs_url) }
      format.xml  { head :ok }
    end
  end
  private
  def set_globals
    @CcObjectClass = HqRsrc
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Resource'
    @symbol_name = 'hq_rsrc'
    @symbols_name = 'hq_rsrcs'
  end
end
