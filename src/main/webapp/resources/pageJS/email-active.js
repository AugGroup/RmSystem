function showNotity(title,type) {
	new PNotify({
		title: title,
	    type: type,
	    delay: 3000
	});
}
function showModal(title, detail,btn) {
	$("#showModal").modal("show");
	$("#title-detail").text(title);
	$("#body-detail").text(detail);
	$("#btnActive").addClass(btn);
}

function cleanModal() {
	$("#btnActive").removeClass("btn-warning");
	$("#btnActive").removeClass("btn-danger");
	$("#btnActive").removeClass("btn-success");
	$("#btnActive").removeClass("btn-primary");
}
$( document ).ready(function() {
	var $id;
	var $name;
	$("#mailTemplate").change(function(){		
		$id = $("#mailTemplate").val();
		$name = $('#mailTemplate option:selected').text();
		if($id == ""){
			CKEDITOR.instances.template.setData("");	
		}else{
			$.ajax({
			    url: contextPath+'/email/edit/update/'+$id,
			    type : 'GET',
			    success : function(data){
			    	CKEDITOR.instances.template.setData(data);
			    },
			    error:function (jqXHR, textStatus, error){
			    	alert('CallBack error');
			    }
		   	});
		}
	});
	
	$("#create").on('click',function(){
		if($("#templateFormCreate").valid()){
			var title = "Create Template";
			var detail = "Do You Want To Create The Template?";
			var btn = "btn-primary";
			showModal(title,detail,btn);			
			$("#btnActive").off().on("click",function(){
				var data = {
						'name':$("#templateName").val(),
						'template':CKEDITOR.instances.template.getData()
				}
				$.ajax({
				 	data:JSON.stringify(data),
				    url: contextPath+'/email/create',
				    type :'POST',
				    contentType : 'application/json',
				    success : function(data){	
				    	cleanModal();
				    	if(data == "success"){
				    		CKEDITOR.instances.template.setData("");
				    		$("#templateName").val(null);
				    		showNotity(createSuccess,"success");
				    	}else{
				    		new PNotify({
				    			title: createFail,
				    			text: matchingName,
				    		    type: "error",
				    		    delay: 3000
				    		});
				    	}
					},
					error:function (jqXHR, textStatus, error){
						showNotity(createFail,"error");
					}
				});
			});
		}
	});
	
	$("#update").on('click',function(){
		if($("#templateFormEdit").valid()){
			var title = "Update Template";
			var detail = "Do You Want To Update The Template?";
			var btn = "btn-success";
			showModal(title,detail,btn);			
			$("#btnActive").off().on("click",function(){
				var data = {
						'id':$id,
						'name':$name,
						'template':CKEDITOR.instances.template.getData()
				}
				$.ajax({
				 	data:JSON.stringify(data),
				    url: contextPath+'/email/edit/update',
				    type :'POST',
				    contentType : 'application/json',
				    success : function(data){	
				    	cleanModal();
				    	showNotity(updateSuccess,"success")
				    },
				    error:function (jqXHR, textStatus, error){
				    	cleanModal();
				    	showNotity(updateFail,"error");
				    }
				});
			});
		}
	});
	
	$("#delete").on('click',function(){
		
		if($("#templateFormEdit").valid()){
			var title  = "Delete Template";
			var detail = "Do You Want To Delete The Template?";
			var btn	   = "btn-danger";
			showModal(title,detail,btn);	
			$("#btnActive").off().on("click",function(){
				$.ajax({
				    url: contextPath+'/email/edit/delete/'+$id,
				    type : 'GET', 
				    success : function(data){	
				    	CKEDITOR.instances.template.setData("");
				    	$("#mailTemplate option[value="+$id+"]").remove();
				    	$('select option[value=""]').attr("selected",true);
				 		$id="";		    	
				    	cleanModal();
				    	showNotity(deleteSuccess,"success");
				    	
				    },
				    error:function (jqXHR, textStatus, error){
				    	cleanModal();
				    	showNotity(deleteFail,"error");
				    }
				});
			});
		}
	});
	
	$("#btnClose").off().on("click",function(){
		cleanModal();
	});
	
	
	 $('#templateFormEdit').each(function() { 
		 $validateEdit = $(this).validate({      
				rules : {
					selectTemplate : {
						required : true
					}
				},
				messages:{
					selectTemplate : {
						required : selectRequired
					}
				}  
		 });
	 });
	 
	 $('#templateFormCreate').each(function() { 
		$validateCreate = $(this).validate({   
			rules : {
				templateName : {
					required : true
				},
				template: {
	                required: function() 
	                {
	                	CKEDITOR.instances.template.updateElement();
	                }
	            }
			},
			messages:{
				templateName : {
					required : templateNameRequired
				},
				template:{
					required:templateRequired
				}
			},
			ignore: []
		});
	 });	
});
