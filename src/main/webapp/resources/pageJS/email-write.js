$(function(){
	
	CKEDITOR.replace( 'preview', {
	    customConfig: contextPath + '/static/resources/ckeditor/config.js'
	});
	
	$(".bootstrap-tagsinput").css("display","block");
	$(".bootstrap-tagsinput").find("input").css("width","auto");
	
	$("#send").on("click", function(){
//		sendEmail($("#applicant option:selected").val(), $("#mailTemplate option:selected").val(), $("#cc").val(), $("#subject").val());
		var receiver = $("#receiver").val();
		var cc = $("#cc").val();
		var subject = $("#subject").val();
		var content = CKEDITOR.instances.preview.getData();
		
		//alert(receiver + " " + cc + " " + subject);
		//alert(content);
		
		sendEmail(receiver, cc, subject, content);
	});
});

function sendEmail(receiver, cc, subject, content){
	
	$("#emali-sending").modal("show");
	$.ajax({
		url: contextPath + "/email/send",
		type: "POST",
		//contentType: "application/json; charset=utf-8",
		//dataType: "json",
		data: {
			"receiver": receiver,
			"cc": cc,
			"subject": subject,
			"content": content
		},
		success: function(data) {
			$("#emali-sending").modal("hide");
			if (data == "success") {
				window.location.replace(contextPath + "/email/write");
				//alert("send success");
			} else {
				//setNotify("Success", "Send email success.", "ok", "success");
				setNotify("Fail", "Send email fail.<br>please check your email before send.", "remove", "danger");
			}
		},
		error: function(){
			$("#emali-sending").modal("hide");
			setNotify("Fail", "Send email fail.<br>please check your email before send.", "remove", "danger");
		}
	});
}

function setNotify(title, text, icon, type) {
	new PNotify({
	    title: title,
	    text: text,
	    icon: 'glyphicon glyphicon-' + icon,
	    type: type,
	    delay: 2000,
	    styling: 'bootstrap3'
	});
}