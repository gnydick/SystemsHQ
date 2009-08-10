class PptClassesController < ApplicationController
  
  before_filter :set_globals
  
  # GET /ppt_classes
  # GET /ppt_classes.xml
  def index
    
    
    
    @objects = PptClass.all(:order => :name).paginate :page => params[:page], :per_page => 20
    
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /ppt_classes/1
  # GET /ppt_classes/1.xml
  def show
    @object = @ppt_class = PptClass.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @ppt_class }
    end
  end
  
  # GET /ppt_classes/new
  # GET /ppt_classes/new.xml
  def new
    @object = @ppt_class = PptClass.new    
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @ppt_class }
    end
  end
  
  # GET /ppt_classes/1/edit
  def edit
    @object = @ppt_class = PptClass.find(params[:id])
    
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /ppt_classes
  # POST /ppt_classes.xml
  def create
    @ppt_class = PptClass.new(params[:ppt_class])
    params[:ppt_class][:assigned_ppt_node_hq_server] ||= {}
    params[:ppt_class][:assigned_ppt_node_hq_vserver] ||= {}
    
    respond_to do |format|
      if @ppt_class.save
        flash[:notice] = 'Puppet Class was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @ppt_class, :status => :created, :location => @ppt_class }
      else
        messages = '<ul>Error:'
        @ppt_class.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @ppt_class.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # PUT /ppt_classes/1
  # PUT /ppt_classes/1.xml
  def update
    params[:ppt_class][:assigned_ppt_node_hq_server] ||= {}
    params[:ppt_class][:assigned_ppt_node_hq_vserver] ||= {}
    
    
    @ppt_class = PptClass.find(params[:id]) 
    respond_to do |format|
      if @ppt_class.update_attributes(params[:ppt_class])
        flash[:notice] = 'Puppet Class was successfully updated.'
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @ppt_class.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @ppt_class.errors, :status => :unprocessable_entity }
      end
      
    end
  end 
  
  
  # DELETE /ppt_classes/1
  # DELETE /ppt_classes/1.xml
  def destroy
    @ppt_class = PptClass.find(params[:id])
    @ppt_class.destroy
    
    respond_to do |format|
      format.html { redirect_to(ppt_classes_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def set_globals
    @CcObjectClass = PptClass
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Server Role'
    @symbol_name = 'ppt_class'
    @symbols_name = 'ppt_classes'
  end
end
