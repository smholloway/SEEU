$(document).ready(function() {
  //-----------------------//
  // BEGIN MADLIBS METHODS //
  //-----------------------//
  $("select.sensor_name").live('change', function () {
    var id_value_string = $(this).val();
    var parent_div = $(this).parent();
    var sensor_operator_div = $(this).siblings("select.sensor_operator");
    var sensor_value_div = $(this).siblings("select.sensor_value");

    // clear the sibling dropdowns (value and operator)
    sensor_operator_div.empty();
    sensor_value_div.empty();

    if (id_value_string === "") {
      // if the sensor selection is empty clear sibling dropdowns
      var row = "<option value=\"" + "" + "\">" + "" + "</option>";
      $(row).appendTo(sensor_operator_div);
      $(row).appendTo(sensor_value_div);
    } else {
      $.ajax({
        dataType: "json",
        cache: false,
        url: '/sensors/' + id_value_string + "/valid_values",
        timeout: 2000,
        beforeSend: function (xhr) {
          xhr.setRequestHeader("Accept", "application/json");
        },
        error: function (XMLHttpRequest, errorTextStatus, error) {
          alert("Failed to submit : " + errorTextStatus + " ;" + error);
        },
        success: function (data) {
          // update the conditional dropdown
          if (typeof(data[0])=='string' && isNaN(data[0])) {
            // update the conditional dropdown for non-ordinal values (e.g., on,off)
            $('<option>=</option>').appendTo(sensor_operator_div);
          } else {
            // update the dropdown for ordinal values (e.g., 0..100)
            $('<option>></option>').appendTo(sensor_operator_div);
            $('<option>>=</option>').appendTo(sensor_operator_div);
            $('<option>=</option>').appendTo(sensor_operator_div);
            $('<option><=</option>').appendTo(sensor_operator_div);
            $('<option><</option>').appendTo(sensor_operator_div);
          }

          // fill the value dropdown
          $.each(data, function(i){
              row = "<option value=\"" + i + "\">" + data[i] + "</option>";
              $(row).appendTo(sensor_value_div);
          });
        }
      });
    }
  });

  $("select.actuator_name").live('change', function () {
    var id_value_string = $(this).val();
    var parent_div = $(this).parent();
    var actuator_operator_div = $(this).siblings("select.actuator_operator");
    var actuator_value_div = $(this).siblings("select.actuator_value");

    // Clear all options from sub category select
    actuator_value_div.empty();

    if (id_value_string === "") {
      // if the actuator selection is invalid empty the sibling dropdowns
      var row = "<option value=\"" + "" + "\">" + "" + "</option>";
      $(row).appendTo(actuator_value_div);
    } else {
      $.ajax({
        dataType: "json",
        cache: false,
        url: '/actuators/' + id_value_string + "/valid_values",
        timeout: 2000,
        beforeSend: function (xhr) {
          xhr.setRequestHeader("Accept", "application/json");
        },
        error: function (XMLHttpRequest, errorTextStatus, error) {
          alert("Failed to submit : " + errorTextStatus + " ;" + error);
        },
        success: function (data) {
          // Fill sub category select
          $.each(data, function(i){
              row = "<option value=\"" + i + "\">" + data[i] + "</option>";
              $(row).appendTo(actuator_value_div);
          });
        }
      });
    }

    // enable the create button to be pressed
    enableMadlibRuleCreation();
  });

  $("select.sensor_conditional").live('change', function () {
    var value_string  = $(this).val();
    var parent_div    = $(this).parent();
    var parent_div_id = $(this).parent().attr("id");
    var new_div_id    = incrementDivId(parent_div_id);

    if (value_string === "" || value_string === "then") {
      // disable any subsequent conditional divs
    } else {
      // enable another IF block
      var new_div = parent_div.clone().insertAfter(parent_div);
      new_div.attr("id", new_div_id);
    }
  });

  $("select.actuator_conditional").live('change', function () {
    var value_string  = $(this).val();
    var parent_div    = $(this).parent();
    var parent_div_id = $(this).parent().attr("id");
    var new_div_id    = incrementDivId(parent_div_id);

    if (value_string === "" || value_string === "then") {
      // disable any subsequent conditional divs
    } else {
      // enable another IF block
      var new_div = parent_div.clone().insertAfter(parent_div);
      new_div.attr("id", new_div_id);
    }
  });

	$('#madlib_create').submit(function() {
		//alert('madlib_create');			
		var sensor_id = $('#sensor_sensor_id').val();
		var sensor_comparator = $('#sensor_operator_sensor_operator').val();
		var sensor_value = $('#sensor_value_sensor_value').val();
		var actuator_id = $('#actuator_actuator_id').val();
		var actuator_value = $('#actuator_value_actuator_value').val();		
	
		var generatedRule = generateRule(sensor_id, sensor_comparator, sensor_value, actuator_id, actuator_value);
		$('textarea#rule_rule').val(generatedRule);
		alert("new_rule submitted: \n" + generatedRule);

		return false;
	});

  //------------------------//
  // END OF MADLIBS METHODS //
  //------------------------//



  //-------------------------------//
  // BEGIN MAGNETIC POETRY METHODS //
  //-------------------------------//
  $("#rules-sensors .clickable").click(function () {
    var id_value_string = $(this).html();
    id_value_string = convertStringToURI(id_value_string);
    var id_from_name = 1;
    //alert('id_value_string = ' + id_value_string + '\n.');
    if (id_value_string === "") {
      //do nothing
    } else {
      $.ajax({
        dataType: "json",
        cache: false,
        url: '/sensors/get_values_string_from_name/' + id_value_string,
        timeout: 2000,
        beforeSend: function (xhr) {
          xhr.setRequestHeader("Accept", "application/json");
        },
        error: function (XMLHttpRequest, errorTextStatus, error) {
          alert("Failed to submit : " + errorTextStatus + " ;" + error);
        },
        success: function (data) {
          $("#valid-sensor-values").html(" (valid values: " + data.valid_values + ")");
        }
      });
    }
  });

  $("#OLDrules-sensors .clickable").click(function () {
    var id_value_string = $(this).html();
    id_value_string = convertStringToURI(id_value_string);
    var id_from_name = 1;
    //alert('id_value_string = ' + id_value_string + '\n.');
    if (id_value_string === "") {
      //do nothing
    } else {
      $.ajax({
        dataType: "json",
        cache: false,
        url: '/sensors/get_id_from_name/' + id_value_string,
        timeout: 2000,
        beforeSend: function (xhr) {
          xhr.setRequestHeader("Accept", "application/json");
        },
        error: function (XMLHttpRequest, errorTextStatus, error) {
          alert("Failed to submit : " + errorTextStatus + " ;" + error);
        },
        success: function (data) {
          id_from_name = data;
          //alert("get_id_from_name data received " + data);
          //alert("id_from_name" + id_from_name);
          $("#valid-sensor-values").html = data;
          //id_from_name = $("#valid-sensor-values").html();
          //alert("id_from_name" + id_from_name);

          $.ajax({
            dataType: "json",
            cache: false,
            url: '/sensors/' + id_from_name + '/valid_values',
            timeout: 2000,
            error: function (XMLHttpRequest, errorTextStatus, error) {
              alert("Failed to submit : " + errorTextStatus + " ;" + error);
            },
            success: function (data) {
              //alert("valid_values data received " + data.valid_values);
              $("#valid-sensor-values").html(" (valid values: " + data.valid_values + ")");
            }
          });
        }
      });
    }
  });


  $("#rules-actuators .clickable").click(function () {
    var id_value_string = $(this).html();
    id_value_string = convertStringToURI(id_value_string);
    var id_from_name = 1;
    alert('id_value_string = ' + id_value_string + '\n.');
    if (id_value_string === "") {
      //do nothing
    } else {
      $.ajax({
        dataType: "json",
        cache: false,
        url: '/actuators/get_values_from_name/' + id_value_string,
        timeout: 2000,
        beforeSend: function (xhr) {
          xhr.setRequestHeader("Accept", "application/json");
        },
        error: function (XMLHttpRequest, errorTextStatus, error) {
          alert("Failed to submit : " + errorTextStatus + " ;" + error);
        },
        success: function (data) {
          //alert("valid_values data received " + data.valid_values);
          $("#valid-actuator-values").html(" (valid values: " + data.valid_values + ")");
        }
      });
    }
  });

	$('#magnetic_create').submit(function() {
		//alert('magnetic_create');			
		var rule = $("div#click-rules-written").text();

		var sensor_id = $('#sensor_sensor_id').val();
		var sensor_comparator = $('#sensor_operator_sensor_operator').val();
		var sensor_value = $('#sensor_value_sensor_value').val();
		var actuator_id = $('#actuator_actuator_id').val();
		var actuator_value = $('#actuator_value_actuator_value').val();		

		var generatedRule = generateRule(sensor_id, sensor_comparator, sensor_value, actuator_id, actuator_value);
		$('textarea#rule_rule').val(generatedRule);
		//alert("new_rule submitted: \n" + generatedRule);

		return true;
	});
	
  $("span.clickable").click(function () {
    var buttonText = $(this).html();
    var buttonDiv = $(this).parent("div").attr("id");

    $("div#click-rules-written").append(buttonText+' ');

    if ( buttonDiv == "rules-operators" ) {
      switch(buttonText) {
        case "greater than":
          buttonText = ">";
          break; 
        case "less than":
          buttonText = "<";
          break; 
        case "greater than or equal to":
          buttonText = ">=";
          break; 
        case "less than or equal to":
          buttonText = "<=";
          break; 
        case "equal to":
          buttonText = "==";
          break; 
        default:
          buttonText = ">";
      }
      $('#sensor_operator_sensor_operator').val(buttonText);
    } else if ( buttonDiv == "rules-sensors" ) {
      $('#sensor_sensor_id').val(buttonText);
    } else if ( buttonDiv == "rules-actuators" ) {
      $('#actuator_actuator_id').val(buttonText);
    } else if ( buttonDiv == "rules-sensor-values" ) {
      $('#sensor_value_sensor_value').val(buttonText);
    } else if ( buttonDiv == "rules-actuator-values" ) {
      $('#actuator_value_actuator_value').val(buttonText);
    }

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
    $('#buttonText').focus();

    $("form#editable").submit(function () {
      var buttonText = $("#buttonText").val();
      var buttonDiv = $(this).parent("div").attr("id");
      $("form#editable").remove();

      if ( buttonDiv == "rules-sensor-values" ) {
        $('#sensor_value_sensor_value').val(buttonText);
      } else if ( buttonDiv == "rules-actuator-values" ) {
        $('#actuator_value_actuator_value').val(buttonText);
        enableRuleCreation(); 
      }

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
  //-----------------------------//
  // END MAGNETIC POETRY METHODS //
  //-----------------------------//



  //-----------------------//
  // BEGIN UTILITY METHODS //
  //-----------------------//
  function enableRuleCreation(interfaceToEnable) {
    if (interfaceToEnable == "madlib") {
      enableMadlibRuleCreation();
    } else {
      enableMagneticRuleCreation();
    }
  }

  function convertStringToURI(input) {
    return encodeURI(input).replace("#", "%23");
  }

  function enableMadlibRuleCreation() {
    $("#madlib-create").attr('disabled','');
  }

  function enableMagneticRuleCreation() {
    $('#magnetic-create').attr('disabled', '');
  }

  function incrementDivId(input) {
    var tokens = input.split("_");
    var num = parseInt(tokens[1]);
    num+=1;
    var output = tokens[0] + "_" + num;
    return output;
  }

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

  //---------------------//
  // END UTILITY METHODS //
  //---------------------//
});
