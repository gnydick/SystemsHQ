class HqTasksController < ApplicationController
  before_filter :set_globals
  
  def order
    params[:hq_tasks].each_index do |i|
      hq_task = HqTask.find(params[:hq_tasks][i])
      hq_task.position = i + 1
      hq_task.save
    end
    
    respond_to do |format|      
      format.js   { render :template => 'reflected/order' } if request.xhr? 
      format.html { render :template => 'reflected/order' }      
    end
  end
  
  
  # GET /hq_tasks
  # GET /hq_tasks.xml
  def index
    @filters = Hash.new
    HqTask.filters.each do |filter|
      value = params[filter.to_s+'_id'].to_i
      @filters[filter.to_s] = Array.new
      if value > 0
        @filters[filter.to_s] = eval(filter.to_s.camelize).find(value).id
      else
        @filters[filter.to_s] = eval(filter.to_s.camelize).all.collect(&:id)
      end
    end
    
    hq_tasks = HqTask.by_app(@filters['hq_app'])
    @objects = hq_tasks.paginate :page => params[:page], :per_page => 20
    respond_to do |format|
      format.html { render :template => 'reflected/index' }
      format.xml  { render :xml => @objects }
    end
  end
  
  # GET /hq_tasks/1
  # GET /hq_tasks/1.xml
  def show
    @object = HqTask.find(params[:id])
    
    respond_to do |format|
      format.js  {render :template => 'reflected/show' }if request.xhr?
      format.html # show.html.erb
      format.xml  { render :xml => @hq_task }
    end
  end
  
  # GET /hq_tasks/new
  # GET /hq_tasks/new.xml
  def new
    @object = @hq_task = HqTask.new
    respond_to do |format|
      format.html { render :template => 'reflected/new' }
      format.xml  { render :xml => @hq_task }
    end
  end
  
  # GET /hq_tasks/1/edit
  def edit
    @object = @hq_task = HqTask.find(params[:id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_tasks
  # POST /hq_tasks.xml
  def create
    @hq_task = HqTask.new(params[:hq_task])
    params[:hq_task][:new_hq_proc_attributes] ||= {}
    params[:hq_task][:existing_hq_proc_attributes] ||= {}
    
    respond_to do |format|
      if @hq_task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @hq_task, :status => :created, :location => @hq_task }
      else
        messages = '<ul>Error:'
        @hq_task.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to  :action => "new", :template => 'reflected/new' }
        format.xml  { render :xml => @hq_task.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_tasks/1
  # PUT /hq_tasks/1.xml
  def update
    @list = HqTask.all(:order => :name)
    @object = HqTask.find(params[:id])
    
    params[:hq_task][:new_hq_proc_attributes] ||= {}
    params[:hq_task][:existing_hq_proc_attributes] ||= {}
    
    
    @hq_task = HqTask.find(params[:id])
    respond_to do |format|
      if @hq_task.update_attributes(params[:hq_task])
        @objects = HqTask.all
        flash[:notice] = 'Task was successfully updated.'
        format.js if request.xhr?
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_task.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_task.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_tasks/1
  # DELETE /hq_tasks/1.xml
  def destroy
    @hq_task = HqTask.find(params[:id])
    @hq_task.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_tasks_url) }
      format.xml  { head :ok }
    end
  end
  private
  def set_globals
    @CcObjectClass = HqTask
    @hq_site = HqSite.find(cookies[:hq_site_id])
    @screen_name = 'Task'
    @symbol_name = 'hq_task'
    @symbols_name = 'hq_tasks'
  end
end
