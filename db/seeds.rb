# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#sensors = Sensor.create([{ :title => 'Sensor1', :description => 'Sensor1'}])
#rules = Rule.create([{ :rule => 'if (Sensor.where("name = 'Sensor1'").first.readings.last.data > 0.to_s) then a = Actuator.where("name = 'actuator1'").first; a.command.data = 0.6; a.save end', :description => 'if (Sensor.where("name = 'Sensor1'").first.readings.last.data > 0.to_s) then a = Actuator.where("name = 'actuator1'").first; a.command.data = 0.6; a.save end'}])
sensor1 = Sensor.create([{ :title => 'thermometer', :description => 'Sun SPOT reporting temperature data', :valid_values => '0..212', :manufacturer => 'Sun', :model => 'SPOT' }])
sensor2 = Sensor.create([{ :title => 'light', :description => 'Sun SPOT reporting light levels', :valid_values => '0..100', :manufacturer => 'Sun', :model => 'SPOT' }])
sensor3 = Sensor.create([{ :title => 'tiltometer', :description => 'Sun SPOT reporting direction in X dimension', :valid_values => '-1.58..1.58', :manufacturer => 'Sun', :model => 'SPOT' }])

actuator1 = Actuator.create([{ :title => 'thermostat', :description => 'Sun SPOT device representing a thermostat LEDs display the set temperature in binary', :valid_values => '0..255', :manufacturer => 'Sun', :model => 'SPOT' }])
actuator2 = Actuator.create([{ :title => 'alarm', :description => 'Sun SPOT device representing an alarm', :valid_values => '0..255', :manufacturer => 'Sun', :model => 'SPOT' }])
actuator3 = Actuator.create([{ :title => 'fan', :description => 'Sun SPOT device representing a fan', :valid_values => 'off,low,medium,high', :manufacturer => 'Sun', :model => 'SPOT' }])

rule1 = Rule.create([{ :rule => 'if ((Sensor.find(1).readings.first.data < 0.to_s)) then a = Actuator.find(3).command; a.data = \"high\"; a.save; end', :description => 'if the x sensor is negative, turn the fan to high' }])
rule2 = Rule.create([{ :rule => 'if ((Sensor.find(3).readings.first.data > 75.to_s)) then a = Actuator.find(4).command; a.data = 72.to_s; a.save; end', :description => 'when its hot, turn on the thermostat' }])
