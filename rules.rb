if (Sensor.where("name = 'Sensor1'").first.readings.last.data > 0.to_s) then a = Actuator.where("name = 'actuator1'").first; a.command.data = 0.5; a.save end
