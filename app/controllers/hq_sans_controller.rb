class HqSansController < ApplicationController
  
  
  before_filter :set_globals
  # GET /hq_sans
  # GET /hq_sans.xml
  @page = ''
  def index
    @objects = HqSan.by_site(@hq_site).paginate :page => params[:page], :per_page => 10
    
    
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_sans/1
  # GET /hq_sans/1.xml
  def show
    @object = @hq_san = HqSan.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_san }
    end
  end
  
  # GET /hq_sans/new
  # GET /hq_sans/new.xml
  def new
    @object = @hq_san = HqSan.new
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_san }
    end
  end
  
  # GET /hq_sans/1/edit
  def edit
    @object = @hq_san = HqSan.find(params[:id])
    
    
    
    @hq_slices = HqSlice.by_site(cookies[:hq_site_id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_sans
  # POST /hq_sans.xml
  def create
    @hq_san = HqSan.new(params[:hq_san])
    params[:hq_san][:new_hq_diskarray_attributes] ||= {}
    params[:hq_san][:new_hq_slice_attributes] ||= {}
    
    respond_to do |format|
      if @hq_san.save
        flash[:notice] = 'SAN was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_san, :status => :created, :location => @hq_san }
      else
        messages = '<ul>Error:'
        @hq_san.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_san.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_sans/1
  # PUT /hq_sans/1.xml
  def update
    @list = HqSan.all(:order => :name)
    @object = HqSan.find(params[:id])
    
    params[:hq_san][:existing_hq_diskarray_attributes] ||= {}
    params[:hq_san][:existing_hq_slice_attributes] ||= {}
    params[:hq_san][:new_hq_diskarray_attributes] ||= {}
    params[:hq_san][:new_hq_slice_attributes] ||= {}
    
    
    @hq_san = HqSan.find(params[:id])
    respond_to do |format|
      if @hq_san.update_attributes(params[:hq_san])
        @objects = HqSan.by_site(cookies[:hq_site_id])
        flash[:notice] = 'SAN was successfully updated.'
        format.js if request.xhr?
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_san.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_san.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_sans/1
  # DELETE /hq_sans/1.xml
  def destroy
    @hq_san = HqSan.find(params[:id])
    @hq_san.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_sans_url) }
      format.xml  { head :ok }
    end
  end
  private
  def set_globals
    @CcObjectClass = HqSan
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'SAN'
    @symbol_name = 'hq_san'
    @symbols_name = 'hq_sans'
  end
end
