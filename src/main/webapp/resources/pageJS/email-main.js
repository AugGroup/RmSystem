$(function(){
	
	var $parentNew = $("#email-appointment-new-parent");
	var $parentUpdate = $("#email-appointment-update-parent");
	
	var $emailAppointmentNew = $("#email-appointment-new");
	var $emailAppointmentUpdate = $("#email-appointment-update");
	
	var $btnEmail = $("#btn_email");
	
	

	//set new appointment
	$.ajax({
		url: contextPath + "/email/find/waitAppointment",
		type: "GET",
		success: function(data) {
			if (!data) {
				removeNotification($btnEmail, $parentNew, $emailAppointmentNew);
				$emailAppointmentNew.empty().append('<li><a href="#">Send all new appoinment success.</a></li>');
			} else {
				setNotification($btnEmail, $parentNew, $emailAppointmentNew);
				var result = "";
				$.each(data, function(index, value) {					
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
				removeNotification($btnEmail, $parentUpdate, $emailAppointmentUpdate);
				$emailAppointmentUpdate.empty().append('<li><a href="#">Send all update appoinment success</a></li>');
			} else {
				setNotification($btnEmail, $parentUpdate, $emailAppointmentUpdate);
				var result = "";
				$.each(data, function(index, value) {
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
		window.location.replace(contextPath + "/email/write/appointment/" + $(this).data("id"));
	});
	
	$emailAppointmentUpdate.off().on("click", ".update-email", function(){
		window.location.replace(contextPath + "/email/write/appointment/" + $(this).data("id"));
	});
});

function setNotification(btn, parent, appointment) {
	btn.tooltip({
	    container: 'body',
	    trigger: 'manual'
	});
	btn.tooltip("show");
	//$("#btn_email").addClass("btn-email-alert");
	btn.addClass("btn-email-alert");
	parent.addClass("email-notification");
	appointment.addClass("email-notification");
}

function removeNotification(btn, parent, appointment) {
	
	btn.tooltip("destroy");
	btn.removeClass("btn-email-alert");
	parent.removeClass("email-notification");
	appointment.removeClass("email-notification");
}









