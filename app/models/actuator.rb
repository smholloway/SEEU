class Actuator < ActiveRecord::Base
  has_one :command, :dependent => :destroy, :autosave => true
  cattr_reader :per_page
  @@per_page = 10

  #after_create :create_command

  def self.get_id_from_name(input="")
    input.gsub("%20"," ").gsub("%23","#")
    @actuator = self.where('name like ?', input).first
    return @actuator.id
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


  private
	def create_command
	  Command.create(:actuator => self)
	end
end
