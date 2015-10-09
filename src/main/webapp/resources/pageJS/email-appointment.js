$(function(){
	
	CKEDITOR.replace( 'preview', {
	    customConfig: contextPath + '/static/resources/ckeditor/config.js'
	});
	
	$(".bootstrap-tagsinput").css("display","block");
	$(".bootstrap-tagsinput").find("input").css("width","auto");
	
	
	$("#mailTemplate").on("change",function(){
		  getTemplate($(this).val());
	});
	
	$("#send").on("click", function(){
//		sendEmail($("#applicant option:selected").val(), $("#mailTemplate option:selected").val(), $("#cc").val(), $("#subject").val());
		var appointmentId = $("#receiver").data("id");
		var cc = $("#cc").val();
		var subject = $("#subject").val();
		var content = CKEDITOR.instances.preview.getData();
		
//		alert(receiver + " " + cc + " " + subject);
//		alert(content);
		
		sendEmail(appointmentId, cc, subject, content);
	});
});

function sendEmail(appointmentId, cc, subject, content){
	
	//alert(receiver + " " + cc + " " + subject + " " + content);
	
	$.ajax({
		url: contextPath + "/email/send/appointment",
		type: "POST",
		data: {
			"appointmentId": appointmentId,
			"cc": cc,
			"subject": subject,
			"content": content
		},
		success: function(data) {
//			alert("send email success...");
			$("#email-appointment-form").trigger("reset");
			setNotify("Success", "Send email success.", "ok", "success");
			//window.location.replace(contextPath + "/email/write");
		},
		error: function(){
			setNotify("Fail", "Send email fail.<br>please check your email before send.", "remove", "danger");
		}
	});
}

function getTemplate(id) {
	
	if(id == "") {
		CKEDITOR.instances.preview.setData("");
	} else {
		$.ajax({
			url: contextPath + "/email/findTemplate/" + id,
			type: "GET",
			success: function(data) {
				CKEDITOR.instances.preview.setData(data.template);
			},
			error: function(data) {
				alert("get template error");
			}
		});
	}
}

function setNotify(title, text, icon, type) {
	new PNotify({
	    title: title,
	    text: text,
	    icon: 'glyphicon glyphicon-' + icon,
	    type: type,
	    styling: 'bootstrap3'
	});
}





















