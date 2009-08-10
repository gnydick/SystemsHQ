class HqEnvsController < ApplicationController
  before_filter :set_globals
  # GET /hq_envs
  # GET /hq_envs.xml
  def index
    @hq_envs = HqEnv.paginate :page => params[:page], :per_page => 20
    
    respond_to do |format|
      format.html { render :template => 'shared/index' }
      format.xml  { render :xml => @hq_envs }
    end
  end
  
  # GET /hq_envs/1
  # GET /hq_envs/1.xml
  def show
    @hq_env = HqEnv.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hq_env }
    end
  end
  
  # GET /hq_envs/new
  # GET /hq_envs/new.xml
  def new
    @hq_env = HqEnv.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hq_env }
    end
  end
  
  # GET /hq_envs/1/edit
  def edit
    @hq_env = HqEnv.find(params[:id])
    respond_to do |format|
      format.js { render :template => 'reflected/edit' } if request.xhr?
      format.html { render :template => 'reflected/edit' }
    end
  end
  
  # POST /hq_envs
  # POST /hq_envs.xml
  def create
    @hq_env = HqEnv.new(params[:hq_env])
    
    respond_to do |format|
      if @hq_env.save
        flash[:notice] = 'Environment was successfully created.'
        format.html { redirect_to(@hq_env) }
        format.xml  { render :xml => @hq_env, :status => :created, :location => @hq_env }
      else
        messages = '<ul>Error:'
        @hq_env.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { render :action => "new", :template => 'shared/new' }
        format.xml  { render :xml => @hq_env.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /hq_envs/1
  # PUT /hq_envs/1.xml
  def update
    @hq_env = HqEnv.find(params[:id])
    
    respond_to do |format|
      if @hq_env.update_attributes(params[:hq_env])
        flash[:notice] = 'Environment was successfully updated.'
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { head :ok }
      else
        messages = '<ul>Error:'
        @hq_env.errors.full_messages.each {|msg| messages += '<li>'+msg+'</li>'}
        messages += '</ul>'
        flash[:notice] = messages
        format.html { redirect_to :action => "edit", :template => 'reflected/edit' }
        format.xml  { render :xml => @hq_env.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /hq_envs/1
  # DELETE /hq_envs/1.xml
  def destroy
    @hq_env = HqEnv.find(params[:id])
    @hq_env.destroy
    
    respond_to do |format|
      format.html { redirect_to(hq_envs_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def set_globals
    @screen_name = 'Environment'
    @symbol_name = 'hq_env'
  end
  
end
