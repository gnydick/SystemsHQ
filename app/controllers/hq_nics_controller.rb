class HqNicsController < ApplicationController
  before_filter :set_globals
  # GET /hq_nics
  # GET /hq_nics.xml
  def index
    @hq_nichaving = find_nichaving
    @hq_nics = HqNic.paginate :page => params[:page], :per_page => 10
    
    respond_to do |format|
      format.html { render :template => 'shared/index' }
      format.xml  { render :xml => @hq_nics }
    end
  end
  
  # GET /hq_nics/1
  # GET /hq_nics/1.xml
  def show
    @hq_nic = HqNic.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hq_nic }
    end
  end
  
  # GET /hq_nics/new
  # GET /hq_nics/new.xml
  def new
    @hq_nic = HqNic.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hq_nic }
    end
  end
  
  # GET /hq_nics/1/edit
  def edit
    @hq_nic = HqNic.find(params[:id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
    
  end
  
  # POST /hq_nics
  # POST /hq_nics.xml
  def create
    @hq_nic = HqNic.new(params[:hq_nic])
    
    respond_to do |format|
      if @hq_nic.save
        flash[:notice] = 'Network Interface was successfully created.'
        format.html { redirect_to(@hq_nic) }
        format.xml  { render :xml => @hq_nic, :status => :created, :location => @hq_nic }
      else
        messages = '<ul>Error:'
        @hq_nic.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { render :action => "new", :template => 'shared/new' }
        format.xml  { render :xml => @hq_nic.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_nics/1
  # PUT /hq_nics/1.xml
  def update
    @hq_nic = HqNic.find(params[:id])
    
    respond_to do |format|
      if @hq_nic.update_attributes(params[:hq_nic])
        flash[:notice] = 'Network Interface was successfully updated.'
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_nic.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_nic.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_nics/1
  # DELETE /hq_nics/1.xml
  def destroy
    @hq_nic = HqNic.find(params[:id])
    @hq_nic.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_nics_url) }
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
    @symbol_name = 'hq_nic'
  end
  
end