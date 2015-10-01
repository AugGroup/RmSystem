function showNotity(title,type,icon) {
	new PNotify({
		title: title,
	    type: type,
	    icon: icon,
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
	var $id = -1;
	var $name;
	$("#mailTemplate").change(function(){		
		$id = $("#mailTemplate").val();
		$name = $('#mailTemplate option:selected').text();
		if($id == -1){
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
				    	showNotity("Create Template Success","success","glyphicon glyphicon-envelope")
					},
					error:function (jqXHR, textStatus, error){
					    alert('CallBack error');
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
				    	showNotity("Update Template Success","success","glyphicon glyphicon-edit")
				    },
				    error:function (jqXHR, textStatus, error){
				    	cleanModal();
				    	showNotity("Update Template Fail","error","glyphicon glyphicon-alert");
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
				    	$('select option[value="-1"]').attr("selected",true);
				    	$id = -1;
				    	
				    	cleanModal();
				    	showNotity("Delete Template Success","success","glyphicon glyphicon-remove");
				    	
				    },
				    error:function (jqXHR, textStatus, error){
				    	cleanModal();
				    	showNotity("Delete Template Fail","error","glyphicon glyphicon-alert");
				    }
				});
			});
		}
	});
	
	var $validateCreate,$validateEdit;
	$validateEdit = $("#templateFormEdit").validate({   
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
	$validateCreate = $("#templateFormCreate").validate({   
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
	
	$("#btnClose").off().on("click",function(){
		cleanModal();
	});
	
	
});
