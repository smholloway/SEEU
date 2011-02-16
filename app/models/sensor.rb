class Sensor < ActiveRecord::Base
  attr_accessible :name, :description, :manufacturer, :model, :data_uri, :configuration_uri, :valid_values # set which parameters can be edited
  cattr_reader :per_page
  @@per_page = 10 

  has_many :readings, :dependent => :destroy

  #before_destroy :ensure_not_referenced_by_any_reading

  def self.get_id_from_name(input="")
    input.gsub("%20"," ").gsub("%23","#")
    @sensor = self.where('name like ?', input).first
    return @sensor.id
  end

  def self.valid_value_range()
    @ends = self.valid_values.gsub("-","..").split("..").map{|s| s.to_i}
    return Range.new(@ends[0],@ends[1])
  end

  def valid_value_range()
    @vals = self.valid_values
    if (@vals.index(".."))
      @ends = @vals.split("..").map{|s| s.to_i}
      return Range.new(@ends[0],@ends[1])
    elsif (@vals.index(","))
      @ends = @vals.split(",")
      return @ends
    else
      return Range.new(0,1)
    end
  end


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
