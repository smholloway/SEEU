class ActuatorsController < ApplicationController
  # GET /actuators
  # GET /actuators.xml
  def index
    @actuators = Actuator.paginate :per_page => 5, :page => params[:page], :order => 'created_at DESC' || 1

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @actuators }
    end
  end

  # GET /actuators/1
  # GET /actuators/1.xml
  def show
    @actuator = Actuator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @actuator }
    end
  end

  # GET /actuators/new
  # GET /actuators/new.xml
  def new
    @actuator = Actuator.new
		@actuator.command = Command.new unless @actuator.command

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @actuator }
    end
  end

  # GET /actuators/1/edit
  def edit
    @actuator = Actuator.find(params[:id])
  end

  # POST /actuators
  # POST /actuators.xml
  def create
    @actuator = Actuator.new(params[:actuator])
    @actuator.command = Command.new

    if @actuator.save
      @actuator.data_uri = sensor_readings_path(@atuator)
      @actuator.configuration_uri = sensor_path(@actuator)
    end 

    respond_to do |format|
      if @actuator.save
        format.html { redirect_to(@actuator, :notice => 'Actuator was successfully created.') }
        format.xml  { render :xml => @actuator, :status => :created, :location => @actuator }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @actuator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /actuators/1
  # PUT /actuators/1.xml
  def update
    @actuator = Actuator.find(params[:id])

    respond_to do |format|
      if @actuator.update_attributes(params[:actuator])
        format.html { redirect_to(@actuator, :notice => 'Actuator was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @actuator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /actuators/1
  # DELETE /actuators/1.xml
  def destroy
    @actuator = Actuator.find(params[:id])
    @actuator.destroy

    respond_to do |format|
      format.html { redirect_to(actuators_url) }
      format.xml  { head :ok }
    end
  end

  def get_values_from_name
    @actuator_id = Actuator.get_id_from_name(params[:name])
    @actuator = Actuator.find(@actuator_id)
    @vv = @actuator.valid_values # this returns the string representation of valid values
    @vvr = @actuator.valid_value_range() # this returns the range of valid values

    respond_to do |format|
      format.html { @vv }
      format.json { render :json => { :valid_values => @vv } }
    end
  end

  def valid_values
    @actuator = Actuator.find(params[:id])
    @vv = @actuator.valid_values # this returns the string representation of valid values
    @vvr = @actuator.valid_value_range() # this returns the range of valid values

    respond_to do |format|
      format.html { @vv }
      format.json { render :json => @vvr }
    end
  end

  def valid_values_string
    @actuator = Actuator.find(params[:id])
    @vv = @actuator.valid_values # this returns the string representation of valid values
    @vvr = @actuator.valid_value_range() # this returns the range of valid values

    respond_to do |format|
      format.html { @vv }
      format.json { render :json => { :valid_values => @vv } }
    end
  end

end
