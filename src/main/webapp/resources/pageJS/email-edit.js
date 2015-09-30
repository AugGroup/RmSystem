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
	$("#btnActive").removeClass("btn-danger")
	$("#btnActive").removeClass("btn-success")
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
	
	$("#update").on('click',function(){
		
		if($id == -1){
			var title = "Select Template";
			var detail = "Please Select The Template";
			var btn = "btn-warning";
			showModal(title,detail,btn);
			$("#btnActive").off().on("click",function(){
				cleanModal();
			});
		}else{
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
				    	alert('CallBack error');
				    }
				});
			});
		}
	});
	
	$("#delete").on('click',function(){
		
		if($id == -1){
			var title = "Select Template";
			var detail = "Please Select The Template";
			var btn = "btn-warning";
			showModal(title,detail,btn);
			$("#btnActive").off().on("click",function(){
				cleanModal(btn);
			});
		}else{
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
				    	cleanModal();
				    	$('select option[value="-1"]').attr("selected",true);
				    	$id = -1;
				    	showNotity("Delete Template Success","success","glyphicon glyphicon-remove");
				    	
				    },
				    error:function (jqXHR, textStatus, error){
				    	alert('CallBack error');
				    }
				});
			});
		}
	});
	
	$("#btnClose").off().on("click",function(){
		cleanModal();
	});
});
