class HqRsrcUsagesController < ApplicationController
  before_filter :set_globals
  # GET /hq_rsrc_usages
  # GET /hq_rsrc_usages.xml
  def index
    @hq_rsrc_usages = HqRsrcUsage.all
    
    respond_to do |format|
      format.html { render :template => 'shared/index' }
      format.xml  { render :xml => @hq_rsrc_usages }
    end
  end
  
  # GET /hq_rsrc_usages/1
  # GET /hq_rsrc_usages/1.xml
  def show
    @hq_rsrc_usage = HqRsrcUsage.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hq_rsrc_usage }
    end
  end
  
  # GET /hq_rsrc_usages/new
  # GET /hq_rsrc_usages/new.xml
  def new
    @hq_rsrc_usage = HqRsrcUsage.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hq_rsrc_usage }
    end
  end
  
  # GET /hq_rsrc_usages/1/edit
  def edit
    @hq_rsrc_usage = HqRsrcUsage.find(params[:id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_rsrc_usages
  # POST /hq_rsrc_usages.xml
  def create
    @hq_rsrc_usage = HqRsrcUsage.new(params[:hq_rsrc_usage])
    
    respond_to do |format|
      if @hq_rsrc_usage.save
        flash[:notice] = 'Resource Usage was successfully created.'
        format.html { redirect_to(@hq_rsrc_usage) }
        format.xml  { render :xml => @hq_rsrc_usage, :status => :created, :location => @hq_rsrc_usage }
      else
        format.html { render :action => "new", :template => 'shared/new' }
        format.xml  { render :xml => @hq_rsrc_usage.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_rsrc_usages/1
  # PUT /hq_rsrc_usages/1.xml
  def update
    @hq_rsrc_usage = HqRsrcUsage.find(params[:id])
    
    respond_to do |format|
      if @hq_rsrc_usage.update_attributes(params[:hq_rsrc_usage])
        flash[:notice] = 'Resource Usage was successfully updated.'
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_rsrc_usage.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_rsrc_usages/1
  # DELETE /hq_rsrc_usages/1.xml
  def destroy
    @hq_rsrc_usage = HqRsrcUsage.find(params[:id])
    @hq_rsrc_usage.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_rsrc_usages_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def set_globals
    @screen_name = 'Resource'
    @symbol_name = 'hq_rsrc'
  end
  
end
