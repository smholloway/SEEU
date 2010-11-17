class Sensor < ActiveRecord::Base
	attr_accessible :title, :description

	has_many :readings, :dependent => :destroy

	before_destroy :ensure_not_referenced_by_any_reading
end
