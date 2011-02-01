class Sensor < ActiveRecord::Base
  attr_accessible :name, :description, :manufacturer, :model, :data_uri, :configuration_uri # set which parameters can be edited
  cattr_reader :per_page
  @@per_page = 20 

  has_many :readings, :dependent => :destroy

  #before_destroy :ensure_not_referenced_by_any_reading

  # ensure that there are no line items referencing this product 
  def ensure_not_referenced_by_any_line_item 
    if readings.count.zero? 
      return true 
    else 
      errors[:base] << "Readings present" 
      return false 
    end 
  end 
end
