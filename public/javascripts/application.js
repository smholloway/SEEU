$(document).ready(function() {
  //-----------------------
  // BEGIN MADLIBS METHODS
  //-----------------------
  $("select#sensor_name").change(function () {
    var id_value_string = $(this).val();
    //alert('id_value_string = ' + id_value_string);
    if (id_value_string === "") {
      // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
      $("select#sensor_value option").remove();
      $("select#sensor_operator option").remove();
      var row = "<option value=\"" + "" + "\">" + "" + "</option>";
      $(row).appendTo("select#sensor_value");
      $(row).appendTo("select#sensor_operator");
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
          //alert(typeof(data[0])=='string' && isNaN(data[0]));
          // update the conditional dropdown for non-ordinal values
          if (typeof(data[0])=='string' && isNaN(data[0])) {
            $("select#sensor_operator option").remove();
            $('<option>=</option>').appendTo("select#sensor_operator");
          } else {
            $("select#sensor_operator option").remove();
            $('<option>></option>').appendTo("select#sensor_operator");
            $('<option>>=</option>').appendTo("select#sensor_operator");
            $('<option>=</option>').appendTo("select#sensor_operator");
            $('<option><=</option>').appendTo("select#sensor_operator");
            $('<option><</option>').appendTo("select#sensor_operator");
          }
          //alert("valid_values data received " + data);
          // Clear all options from sub category select
          $("select#sensor_value option").remove();
          // Fill sub category select
          $.each(data, function(i, j){
              row = "<option value=\"" + i + "\">" + data[i] + "</option>";
              $(row).appendTo("select#sensor_value");
          });
        }
      });
    }
  });

  $("select#actuator_name").change(function () {
    var id_value_string = $(this).val();
    //alert('id_value_string = ' + id_value_string);
    if (id_value_string === "") {
      // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
      $("select#actuator_value option").remove();
      var row = "<option value=\"" + "" + "\">" + "" + "</option>";
      $(row).appendTo("select#actuator_value");
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
          //alert("valid_values data received " + data);
          // Clear all options from sub category select
          $("select#actuator_value option").remove();
          // Fill sub category select
          $.each(data, function(i, j){
              row = "<option value=\"" + i + "\">" + data[i] + "</option>";
              $(row).appendTo("select#actuator_value");
          });
        }
      });
    }
  });

  $("select#sensor_conditional").change(function () {
    var id_value_string = $(this).val();
    alert('id_value_string = ' + id_value_string);
    if (id_value_string === "") {
      // this should not happen
    } else {
    }
  });

  //-----------------------
  // END OF MADLIBS METHODS
  //-----------------------


  $("select#sensor_sensor_id").change(function () {
    var id_value_string = $(this).val();
    id_value_string = convertStringToURI(id_value_string);
    var id_from_name = 1;
    //alert('id_value_string = ' + id_value_string);
    if (id_value_string === "") {
      // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
      $("select#readings_readings_id option").remove();
      var row = "<option value=\"" + "" + "\">" + "" + "</option>";
      $(row).appendTo("select#readings_readings_id");
    } else {
      $.ajax({
        dataType: "json",
        cache: false,
        url: '/sensors/get_values_from_name/' + id_value_string,
        timeout: 2000,
        beforeSend: function (xhr) {
          xhr.setRequestHeader("Accept", "application/json");
        },
        error: function (XMLHttpRequest, errorTextStatus, error) {
          alert("Failed to submit : " + errorTextStatus + " ;" + error);
        },
        success: function (data) {
          //alert("valid_values data received " + data);
          // Clear all options from sub category select
          $("select#readings_readings_id option").remove();
          //put in a empty default line
          //var row = "<option value=\"" + "" + "\">" + "" + "</option>";
          //$(row).appendTo("select#readings_readings_id");
          // Fill sub category select
          $.each(data, function(i, j){
              row = "<option value=\"" + i + "\">" + data[i] + "</option>";
              $(row).appendTo("select#readings_readings_id");
          });
        }
      });
    }
  });

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

  function convertStringToURI(input) {
    return encodeURI(input).replace("#", "%23");
  }

	$('#madlib_create').submit(function() {
		//amlert('madlib_create');			
		var sensor_id = $('#sensor_sensor_id').val();
		var sensor_comparator = $('#sensor_operator_sensor_operator').val();
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
		//alert("new_rule submitted: \n" + generatedRule);

		return true;
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

  $("select#actuator_value_actuator_value").click(function () {
    //alert('clicked actuator_value_actuator_value');
    enableMadlibRuleCreation();
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


  function enableRuleCreation(interfaceToEnable) {
    if (interfaceToEnable == "madlib") {
      enableMadlibRuleCreation();
    } else {
      enableMagneticRuleCreation();
    }
  }

  function enableMadlibRuleCreation() {
    $('#madlib-create').css('display', 'all');
    $('#madlib-create').toggle();
  }

  function enableMagneticRuleCreation() {
    $('#magnetic-create').css('display', 'all');
    $('#magnetic-create').toggle();
  }

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
