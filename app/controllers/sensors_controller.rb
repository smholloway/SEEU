class SensorsController < ApplicationController
  # GET /sensors
  # GET /sensors.xml
  def index
    @sensors = Sensor.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC' || 1

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sensors }
    end
  end

  # GET /sensors/1
  # GET /sensors/1.xml
  def show
    @sensor = Sensor.find(params[:id])
    @readings = @sensor.readings.paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC' || 1

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sensor }
    end
  end

  # GET /sensors/new
  # GET /sensors/new.xml
  def new
    @sensor = Sensor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sensor }
    end
  end

  # GET /sensors/1/edit
  def edit
    @sensor = Sensor.find(params[:id])
  end

  # POST /sensors
  # POST /sensors.xml
  def create
    @sensor = Sensor.new(params[:sensor].each_value(&:strip!))
    if @sensor.save
      @sensor.data_uri = sensor_readings_path(@sensor)
      @sensor.configuration_uri = sensor_path(@sensor)

      #@sensor.valid_values = params[:valid_values].downcase
    end

    respond_to do |format|
      if @sensor.save
        format.html { redirect_to(@sensor, :notice => 'Sensor was successfully created.') }
        format.xml  { render :xml => @sensor, :status => :created, :location => @sensor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sensor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sensors/1
  # PUT /sensors/1.xml
  def update
    @sensor = Sensor.find(params[:id])

    respond_to do |format|
      if @sensor.update_attributes(params[:sensor].each_value(&:strip!))
        format.html { redirect_to(@sensor, :notice => 'Sensor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sensor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sensors/1
  # DELETE /sensors/1.xml
  def destroy
    @sensor = Sensor.find(params[:id])
    @sensor.destroy

    respond_to do |format|
      format.html { redirect_to(sensors_url) }
      format.xml  { head :ok }
    end
  end


  def valid_values
    @sensor = Sensor.find(params[:id])
    @vvr = @sensor.valid_value_range() # this returns the range of valid values

    respond_to do |format|
      format.html { @vv }
      format.json { render :json => @vvr }
    end
  end

  def valid_values_string
    @sensor = Sensor.find(params[:id])
    @vv = @sensor.valid_values # this returns the string representation of valid values

    respond_to do |format|
      format.html { @vv }
      format.json { render :json => { :valid_values => @vv } }
    end
  end

  def get_id_from_name
    @sensor_id = Sensor.get_id_from_name(params[:name])

    respond_to do |format|
      format.html { @sensor_id }
      format.json { render :json => @sensor_id }
    end
  end

  def get_values_from_name
    @sensor_id = Sensor.get_id_from_name(params[:name])
    @sensor = Sensor.find(@sensor_id)
    @vv = @sensor.valid_values
    @vvr = @sensor.valid_value_range()

    respond_to do |format|
      format.html { @vv }
      format.json { render :json => @vvr }
    end
  end

  def get_values_string_from_name
    @sensor_id = Sensor.get_id_from_name(params[:name])
    @sensor = Sensor.find(@sensor_id)
    @vv = @sensor.valid_values
    @vvr = @sensor.valid_value_range()

    respond_to do |format|
      format.html { @vv }
      format.json { render :json => { :valid_values => @vv } }
    end
  end

end
