class Sensor < ActiveRecord::Base
	has_many :readings

	before_destroy :ensure_not_referenced_by_any_reading
end
