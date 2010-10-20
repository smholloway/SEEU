class HomeController < ApplicationController
  def index
	@sensors = Sensor.all
	@actuators = Actuator.all
	@rules = Rule.all
	
	respond_to do |format|
		format.html
		format.xml { render :xml => @sensors }
	end
  end
end
