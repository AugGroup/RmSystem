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
		sendEmail($("#applicant option:selected").val(), $("#mailTemplate option:selected").val(), $("#cc").val(), $("#subject").val());
	});
});

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

function sendEmail(applicantId, templateId, cc, subject){
	alert(applicantId + " " + templateId + " " + " " + cc + " " + subject);
	
	$.ajax({
		url: contextPath + "/email/send/applicant",
		type: "POST",
		//contentType: "application/json; charset=utf-8",
		//dataType: "json",
		data: {
			"applicantId": applicantId,
			"templateId": templateId,
			"cc": cc,
			"subject": subject
		},
		success: function(data) {
			alert(data);
		},
		error: function(){
			alert("send error");
		}
	});
}