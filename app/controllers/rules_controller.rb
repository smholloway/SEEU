class RulesController < ApplicationController
  # GET /rules
  # GET /rules.xml
  def index
    @rules     = Rule.all
	  @sensors   = Sensor.all
	  @actuators = Actuator.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rules }
    end
  end

  # GET /rules/1
  # GET /rules/1.xml
  def show
    @rule = Rule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rule }
    end
  end

  # GET /rules/new
  # GET /rules/new.xml
  def new
    @rule = Rule.new
	  @sensors   = Sensor.all
	  @actuators = Actuator.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rule }
    end
  end

  # GET /rules/1/edit
  def edit
    @rule = Rule.find(params[:id])
  end

  # POST /rules
  # POST /rules.xml
  def create
    @rule = Rule.new(params[:rule])

    respond_to do |format|
      if @rule.save
        format.html { redirect_to(@rule, :notice => 'Rule was successfully created.') }
        format.xml  { render :xml => @rule, :status => :created, :location => @rule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rules/1
  # PUT /rules/1.xml
  def update
    @rule = Rule.find(params[:id])

    respond_to do |format|
      if @rule.update_attributes(params[:rule])
        format.html { redirect_to(@rule, :notice => 'Rule was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.xml
  def destroy
    @rule = Rule.find(params[:id])
    @rule.destroy

    respond_to do |format|
      format.html { redirect_to(rules_url) }
      format.xml  { head :ok }
    end
  end

  # PLAYING /rules
  # PLAYING /rules.xml
  def playing 
    @rules     = Rule.all
		@rule      = Rule.find(params[:id])
		@sensors   = Sensor.all
		@actuators = Actuator.all
		
		@rule_sensors = []
		@rule_sensor_data = []
		@rule_actuators = []
		@rule_actuator_data = []

    respond_to do |format|
      format.html # playing.html.erb
      format.xml  { render :xml => @rules }
    end
  end


  def for_sensorid
    @sensors = Sensor.find( :all, :conditions => [" sensor_id = ?", params[:id]]  ).sort_by{ |k| k['name'] }    
    respond_to do |format|
      format.json  { render :json => @sensors }
    end
  end

end
