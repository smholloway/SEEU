def convertRuleToMagnetic(rule='')
  puts "convertRuleToMagnetic(\"#{rule}\")"
end

def convertMagneticToRule(rule='')
  puts "convertMagneticToRule(\"#{rule}\")"
  @sensorName = ""
  @sensorOperator = ""
  @sensorValue = ""
  @actuatorName = ""
  if isValidRule(rule)
    output = 'if (Sensor.where(\"name=\''
    rule.split(' ').each do |word|
      puts "word =#{word}"
      if word.include?("ensor")
        @sensorName = word
      elsif word.include?("ctuator")
        @actuatorName = word
      elsif word =~ /<=>/ 
        @sensorOperator = word
      elsif word.include?("greater")
        @sensorOperator = ">" 
      elsif word.include?("less")
        @sensorOperator = "<" 
      elsif word.include?("equal")
        @sensorOperator = "==" 
      end
    end
  end
  output = 'if (Sensor.where(\"name=\''+@sensorName+'\'\").first.readings.last.data'+@sensorOperator+@sensorValue+'.to_s)'
  output
end

def isValidRule(rule='')
  return true
end

testRule = 'if (Sensor.where(\"name=\'Sensor1\'\").first.readings.last.data>0.to_s) then a=Actuator.where(\"name=\'actuator1\'\").first; a.command.data=0.6; a.save end'
testMagnetic = 'if Sensor1 equal to 15 then actuator1 1'

puts convertRuleToMagnetic()
puts convertRuleToMagnetic(testRule)

puts convertMagneticToRule()
puts convertMagneticToRule(testMagnetic)
