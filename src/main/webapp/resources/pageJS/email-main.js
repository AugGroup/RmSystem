$(function(){
	
	var $emailAppointment = $("#email-appointment"); 
	
	$.ajax({
		url: contextPath + "/email/find/waitAppoinment",
		type: "GET",
		success: function(data) {
			if (!data) {
				//alert("null");
				$emailAppointment.empty().append('<li><a href="#">send all appoinment success</a></li>');
			} else {
//				alert("appointment not null");
//				alert(data);
//				console.log(data);
				var result = "";
				$.each(data, function(index, value) {
//					alert(index + ": " + value.firstNameEN);
					var firstName = value.firstNameEN;
					var position = value.technology.name + " " + value.joblevel.name;
					
					result += '<li><a href="#">' + firstName + " (" + position + ")"+ '</a></li>';
				})
				$emailAppointment.empty().append(result);
			}
		},
		error: function() {
			alert("error find wait appoinment");
		}
	});
	
});