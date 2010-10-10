class ReadingsController < ApplicationController

	before_filter :run_rules

  # GET /readings
  # GET /readings.xml
  def index
	  @sensor = Sensor.find(params[:sensor_id])
		@readings = @sensor.readings

#    @readings = Reading.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @readings }
#    end
  end

  # GET /readings/1
  # GET /readings/1.xml
  def show
		@sensor = Sensor.find(params[:sensor_id])
    @reading = Reading.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reading }
    end
  end

  # GET /readings/new
  # GET /readings/new.xml
  def new
	  @sensor = Sensor.find(params[:sensor_id])
    @reading = @sensor.readings.build
#		@reading = Reading.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @reading }
#    end
  end

  # GET /readings/1/edit
  def edit
		@sensor = Sensor.find(params[:sensor_id])
	  @reading = @sensor.readings.find(params[:id])
  end

  # POST /readings
  # POST /readings.xml
  def create
		@sensor = Sensor.find(params[:sensor_id])
    @reading = @sensor.readings.build(params[:reading])

# 	@reading = Reading.new(params[:reading])

    respond_to do |format|
      if @reading.save
#        format.html { redirect_to(@reading, :notice => 'Reading was successfully created.') }
        format.html { redirect_to sensor_reading_url(@sensor, @reading) }
        format.xml  { render :xml => @reading, :status => :created, :location => @reading }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reading.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /readings/1
  # PUT /readings/1.xml
  def update
		@sensor = Sensor.find(params[:sensor_id])
    @reading = Reading.find(params[:id])

    respond_to do |format|
      if @reading.update_attributes(params[:reading])
        format.html { redirect_to sensor_reading_url(@sensor, @reading) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reading.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /readings/1
  # DELETE /readings/1.xml
  def destroy
	  @sensor = Sensor.find(params[:sensor_id])
	  @reading = Reading.find(params[:id])
    @reading.destroy

    respond_to do |format|
      format.html { redirect_to sensor_readings_path(@sensor) }
      format.xml  { head :ok }
    end
  end


	private

	def run_rules()
		a = Actuator.find(1).command
		@reading = Reading.find(params[:id])

		### previous attempts
		# works, but is not general
#		if Sensor.find(1).readings.find(1).data.to_s == "1"
#		end

		# works, but is longer than accessing reading directly
#		if Sensor.find(params[:sensor_id]).readings.find(params[:id]).data.to_s == "1" 
#		end

		if Reading.find(params[:id]).data.to_s == "1"
			a.data = "1"
		else
			a.data = "0"
		end
		a.save
	end

# maybe try something like this...
#	create a rules database
#	r = Rules.find(params[:sensor_id])
#	r.each do |r|
#		#test rule
#	end
#
#	if (Sensor.find(#).readings.last.data or Sensor.find(r[i].sensor).readings.last.data r[i].operator r[i].threshold)
#		a = Actuator.find(r[i].actuator)
#		a.command.data = r[i].output
#		a.save
#	end
end

