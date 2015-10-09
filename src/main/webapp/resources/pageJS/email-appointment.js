$(function(){
	
	CKEDITOR.replace( 'preview', {
	    customConfig: contextPath + '/static/resources/ckeditor/config.js'
	});
	
	$(".bootstrap-tagsinput").css("display","block");
	$(".bootstrap-tagsinput").find("input").css("width","auto");
	
	
	$("#mailTemplate").on("change",function(){
		  getTemplate($(this).val());
	});
	
	$("#test").on("click", function(){
		$("#email-sending").modal("show");
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
		beforeSend: function(){
			//alert("sending");
			$("#emali-sending").modal("show");
		},
		success: function(data) {
			if (data == "success") {
				window.location.replace(contextPath + "/email/write");
			} else {
				//setNotify("Success", "Send email success.", "ok", "success");
				setNotify("Fail", "Send email fail.<br>please check your email before send.", "remove", "danger");
			}
		},
		complete: function(){
			//alert("send success")
			$("#emali-sending").modal("hide");
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





















