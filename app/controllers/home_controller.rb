class HomeController < ApplicationController
  def index
		@sensors = Sensor.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 20 || 1
		@actuators = Actuator.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 20 || 1
		@rules = Rule.all
	
		respond_to do |format|
			format.html
			format.xml { render :xml => @sensors }
		end
	end

  def about

		respond_to do |format|
			format.html
			format.xml { render :xml => @sensors }
		end
  end

  def feedback 

		respond_to do |format|
			format.html
			format.xml { render :xml => @sensors }
		end
  end

end

