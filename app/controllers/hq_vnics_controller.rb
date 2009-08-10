class HqVnicsController < ApplicationController
  before_filter :set_globals
  # GET /hq_vnics
  # GET /hq_vnics.xml
  def index
    @hq_vnichaving = find_nichaving
    @hq_vnics = HqVnic.paginate :page => params[:page], :per_page => 20
    
    respond_to do |format|
      format.html { render :template => 'shared/index' }
      format.xml  { render :xml => @hq_vnics }
    end
  end
  
  # GET /hq_vnics/1
  # GET /hq_vnics/1.xml
  def show
    @hq_vnic = HqVnic.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hq_vnic }
    end
  end
  
  # GET /hq_vnics/new
  # GET /hq_vnics/new.xml
  def new
    @hq_vnic = HqVnic.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hq_vnic }
    end
  end
  
  # GET /hq_vnics/1/edit
  def edit
    @hq_vnic = HqVnic.find(params[:id])
    
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
    
  end
  
  # POST /hq_vnics
  # POST /hq_vnics.xml
  def create
    @hq_vnic = HqVnic.new(params[:hq_vnic])
    
    respond_to do |format|
      if @hq_vnic.save
        flash[:notice] = 'Network Interface was successfully created.'
        format.html { redirect_to(@hq_vnic) }
        format.xml  { render :xml => @hq_vnic, :status => :created, :location => @hq_vnic }
      else
        messages = '<ul>Error:'
        @hq_vnic.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { render :action => "new", :template => 'shared/new' }
        format.xml  { render :xml => @hq_vnic.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_vnics/1
  # PUT /hq_vnics/1.xml
  def update
    @hq_vnic = HqVnic.find(params[:id])
    
    respond_to do |format|
      if @hq_vnic.update_attributes(params[:hq_vnic])
        flash[:notice] = 'Network Interface was successfully updated.'
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_vnic.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_vnic.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_vnics/1
  # DELETE /hq_vnics/1.xml
  def destroy
    @hq_vnic = HqVnic.find(params[:id])
    @hq_vnic.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_vnics_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_nichaving
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end 
    nil
  end
  
  private
  def set_globals
    @screen_name = 'Network Interface'
    @symbol_name = 'hq_vnic'
  end
  
end