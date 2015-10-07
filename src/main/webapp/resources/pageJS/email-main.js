$(function(){
	
	var $emailAppointmentNew = $("#email-appointment-new");
	var $emailAppointmentUpdate = $("#email-appointment-update");
	
	//set new appointment
	$.ajax({
		url: contextPath + "/email/find/waitAppointment",
		type: "GET",
		success: function(data) {
			if (!data) {
				//alert("null");
				$emailAppointmentNew.empty().append('<li><a href="#">Send all new appoinment success.</a></li>');
			} else {
//				alert("appointment not null");
//				alert(data);
//				console.log(data);
				var result = "";
				$.each(data, function(index, value) {
//					alert(index + ": " + value.firstNameEN);
//					var firstName = value.firstNameEN;
//					var position = value.technology.name + " " + value.joblevel.name;
//					var trackingStatus = value.trackingStatus;
					
//					result += '<li><a href="#" class="new-email">' + firstName + " (" + position + ") " + trackingStatus + '</a></li>';
					result += '<li><a href="#" class="new-email" data-id="' + value.id + '">' + value.topic + '</a></li>';
				})
				$emailAppointmentNew.empty().append(result);
			}
		},
		error: function() {
			alert("error find new appoinment");
		}
	});
	
	//set update appointment
	$.ajax({
		url: contextPath + "/email/find/updateAppointment",
		type: "GET",
		success: function(data) {
			if (!data) {
				//alert("null");
				$emailAppointmentUpdate.empty().append('<li><a href="#">Send all update appoinment success</a></li>');
			} else {
//				alert("appointment not null");
//				alert(data);
//				console.log(data);
				var result = "";
				$.each(data, function(index, value) {
//					alert(index + ": " + value.firstNameEN);
//					var firstName = value.firstNameEN;
//					var position = value.technology.name + " " + value.joblevel.name;
//					var trackingStatus = value.trackingStatus;
//					
//					result += '<li><a href="#" class="update-email">' + firstName + " (" + position + ") " + trackingStatus + '</a></li>';
					result += '<li><a href="#" class="update-email" data-id="' + value.id + '">' + value.topic + '</a></li>';
				})
				$emailAppointmentUpdate.empty().append(result);
			}
		},
		error: function() {
			alert("error find update appoinment");
		}
	});
	
	$emailAppointmentNew.off().on("click", ".new-email", function(){
		//alert("new " + $(this).data("id"));
		window.location.replace(contextPath + "/email/write/appointment/" + $(this).data("id"));
	});
	
	$emailAppointmentUpdate.off().on("click", ".update-email", function(){
		//alert("update " + $(this).data("id"));
		window.location.replace(contextPath + "/email/write/appointment/" + $(this).data("id"));
	});
});













