// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
	$('#madlib_create').submit(function() {
		alert('madlib_create');			
		var sensor_id = $('#sensor_sensor_id').val();
		var sensor_comparator = $('#sensor_operator_sensor_operator').val();
		var sensor_value = $('#sensor_value_sensor_value').val();
		var actuator_id = $('#actuator_actuator_id').val();
		var actuator_value = $('#actuator_value_actuator_value').val();		
	
		var generatedRule = generateRule(sensor_id, sensor_comparator, sensor_value, actuator_id, actuator_value);
		$('textarea#rule_rule').val(generatedRule);
		alert("new_rule submitted: \n" + generatedRule);

		return true;
	});
	
	$('#magnetic_create').submit(function() {
		alert('magnetic_create');			
		var rule = $("div#click-rules-written").text();

		var sensor_id = $('#sensor_sensor_id').val();
		var sensor_comparator = $('#sensor_operator_sensor_operator').val();
		var sensor_value = $('#sensor_value_sensor_value').val();
		var actuator_id = $('#actuator_actuator_id').val();
		var actuator_value = $('#actuator_value_actuator_value').val();		

		var generatedRule = generateMagneticRule(rule);
		var generatedRule = generateRule(sensor_id, sensor_comparator, sensor_value, actuator_id, actuator_value);
		$('textarea#rule_rule').val(generatedRule);
		alert("new_rule submitted: \n" + generatedRule);

		return false;
	});
	
	function generateRule(sensor_id, sensor_comparator, sensor_value, actuator_id, actuator_value) {
		var rule = "if (Sensor.where(\"name = \'" + sensor_id + "\'\").first.readings.last.data " + 
								sensor_comparator +
								" " + sensor_value + ".to_s);\n" +
		  					"a = Actuator.where(\"name = \'" + actuator_id + "\'\").first;\n" + 
		  					"a.command.data = " + actuator_value + ";\n" +
		  					"a.save;\n" +
								"end;";
		return rule;
	}
	
	function generateMagneticRule(r) {
		var rule = r;
		return rule;
	}
	
  function disableButtonsInDiv(inputDiv) {
    $('div#' + inputDiv + ' span').each(function () {
    $(this).css('display', 'none');
    });
  }
  function enableButtonsInDiv(inputDiv) {
    $('div#' + inputDiv + ' span').each(function () {
      $(this).css('display', 'inline');
    });
  }

  $("span.clickable").click(function () { 
    var buttonText = $(this).html();
    var buttonDiv = $(this).parent("div").attr("id");

    $("div#click-rules-written").append(buttonText+' ');
    enableButtons( buttonText, buttonDiv );
  });
  $("span.clickable").hover(function () {
    $(this).addClass("hilite");
    }, function () {
      $(this).removeClass("hilite");
    });

  $("span.editable").click(function () { 
    var buttonDiv = $(this).parent("div").attr("id");
    $(this).replaceWith('<form id="editable"><input type="text" size="8" maxlength="8" id="buttonText" value="'+$(this).html()+'"></form>');
    $("form#editable").submit(function () {
      var buttonText = $("#buttonText").val();
      $("form#editable").remove();

      $("div#click-rules-written").append(buttonText +' ');
      enableButtons( buttonText, buttonDiv );

      return false;
    });
    return false;
  });
  $("span.editable").hover(function () {
    $(this).addClass("hilite");
    }, function () {
    $(this).removeClass("hilite");
  });



  function enableButtons(clickedText, clickedDiv) {
    disableButtonsInDiv("click-rules");

    if ( clickedDiv == "rules-if" ) {
      enableButtonsInDiv("rules-sensors");
    } else if ( clickedDiv == "rules-conditionals" ) {
      if ( clickedText == "then" ) {
        enableButtonsInDiv("rules-actuators");
      } else {
        enableButtonsInDiv("rules-sensors");
      }
    } else if ( clickedDiv == "rules-sensor-values" ) {
      enableButtonsInDiv("rules-conditionals");
    } else if ( clickedDiv == "rules-actuator-values" ) {
    } else if ( clickedDiv == "rules-sensors" ) {
      enableButtonsInDiv("rules-operators");
    } else if ( clickedDiv == "rules-actuators" ) {
      enableButtonsInDiv("rules-actuator-values");
    } else if ( clickedDiv == "rules-operators" ) {
      enableButtonsInDiv("rules-sensor-values");
    } else {
      alert("clickedText = " + clickedText + "\n clickedDiv = " + clickedDiv);
    }
  }

  function enableProperButtons(inputText) {
    disableButtonsInDiv("click-rules");
    if (inputText == "rules-if") {
      enableButtonsInDiv("rules-sensors");
    } else if (inputText == "rules-conditionals") {
      enableButtonsInDiv("rules-actuators");
    } else if (inputText == "rules-values") {
      enableButtonsInDiv("rules-conditionals");
    } else if (inputText == "rules-sensors") {
      enableButtonsInDiv("rules-operators");
    } else if (inputText == "rules-actuators") {
      enableButtonsInDiv("rules-values");
    } else if (inputText == "rules-operators") {
      enableButtonsInDiv("rules-values");
    } else {
      alert(inputText);
    }
  }
});
