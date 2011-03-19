# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

sensor1 = Sensor.create([{
  :id => 1,
  :name => 'thermometer',
  :description => 'Sun SPOT reporting temperature data',
  :valid_values => '0..212',
  :manufacturer => 'Sun',
  :model => 'SPOT' 
}])
sensor2 = Sensor.create([{ 
  :id => 2,
  :name => 'light', 
  :description => 'Sun SPOT reporting light levels', 
  :valid_values => '0..100', 
  :manufacturer => 'Sun', 
  :model => 'SPOT' 
}])
sensor3 = Sensor.create([{ 
  :id => 3,
  :name => 'tiltometer', 
  :description => 'Sun SPOT reporting tilt in the X dimension', 
  :valid_values => '-1.58..1.58', 
  :manufacturer => 'Sun', 
  :model => 'SPOT' 
}])

actuator1 = Actuator.create([{ 
  :id => 1,
  :name => 'air conditioner', 
  :description => 'Sun SPOT device representing an air conditioner with LEDs displaying the temperature in binary', 
  :valid_values => '0..255', 
  :manufacturer => 'Sun', 
  :model => 'SPOT' 
}])
actuator2 = Actuator.create([{ 
  :id => 2,
  :name => 'alarm', 
  :description => 'Sun SPOT device representing an alarm', 
  :valid_values => 'off,on', 
  :manufacturer => 'Sun', 
  :model => 'SPOT' 
}])
actuator3 = Actuator.create([{ 
  :id => 3,
  :name => 'fan', 
  :description => 'Sun SPOT device representing a fan', 
  :valid_values => 'off,low,medium,high', 
  :manufacturer => 'Sun', 
  :model => 'SPOT' 
}])

command1 = Command.create([{ 
  :actuator_id => 1
}])
command2 = Command.create([{ 
  :actuator_id => 2
}])
command3 = Command.create([{ 
  :actuator_id => 3
}])

rule1 = Rule.create([{ 
  :id => 1,
  :rule => 'if ((Sensor.find(3).readings.first.data < 0.to_s)) then a = Actuator.find(3).command; a.data = "high"; a.save; end', 
  :description => 'if the tiltometer is negative, turn the fan to high' 
}])
rule2 = Rule.create([{ 
  :id => 2,
  :rule => 'if ((Sensor.find(1).readings.first.data > 78.to_s)) then a = Actuator.find(1).command; a.data = 72.to_s; a.save; end', 
  :description => 'when the temperature is above 78, turn the air conditioner to 72' 
}])
