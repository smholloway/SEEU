class ReadingsController < ApplicationController

	before_filter :run_rules

  # GET /readings
  # GET /readings.xml
  def index
	  @sensor = Sensor.find(params[:sensor_id])
		@readings = @sensor.readings
    @readings = @sensor.readings.paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC' || 1

#    @readings = Reading.all
#
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @readings }
    end
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

    respond_to do |format|
      if @reading.save
        format.html { redirect_to sensor_reading_url(@sensor, @reading) }
		format.js
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
				format.js
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
		Rule.all.each do |r|
			#code = Rule.sanitize(r.rule).to_s
			code = r.rule
      logger.info "Running rule " + code
      eval(code)
		end
	end

end

