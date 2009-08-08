class HqSlicesController < ApplicationController
  
  # GET /hq_slices
  # GET /hq_slices.xml
  def index
    @hq_slices = HqSlice.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hq_slices }
    end
  end
  
  # GET /hq_slices/1
  # GET /hq_slices/1.xml
  def show
    @hq_slice = HqSlice.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hq_slice }
    end
  end
  
  # GET /hq_slices/new
  # GET /hq_slices/new.xml
  def new
    @hq_slice = HqSlice.new
    
    @hq_slices = HqSite.
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hq_slice }
    end
  end
  
  # GET /hq_slices/1/edit
  def edit
    @hq_slice = HqSlice.find(params[:id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_slices
  # POST /hq_slices.xml
  def create
    @hq_slice = HqSlice.new(params[:hq_slice])
    
    respond_to do |format|
      if @hq_slice.save
        flash[:notice] = 'HqSlice was successfully created.'
        format.html { redirect_to(@hq_slice) }
        format.xml  { render :xml => @hq_slice, :status => :created, :location => @hq_slice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hq_slice.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_slices/1
  # PUT /hq_slices/1.xml
  def update
    @hq_slice = HqSlice.find(params[:id])
    
    respond_to do |format|
      if @hq_slice.update_attributes(params[:hq_slice])
        flash[:notice] = 'HqSlice was successfully updated.'
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_slice.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_slices/1
  # DELETE /hq_slices/1.xml
  def destroy
    @hq_slice = HqSlice.find(params[:id])
    @hq_slice.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_slices_url) }
      format.xml  { head :ok }
    end
  end
end
