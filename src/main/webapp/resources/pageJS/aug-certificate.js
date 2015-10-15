$(document).ready(function() {
	
	$('#certificateForm').validate({
		rules : {
			certificationForm : {required : true},
			description : {required : true},
			name : {required : true},
			year : {required : true}
		},
		messages : {
			certificationForm : {required : valFrom},
			description : {required : valDesc},
			name : {required : valCer},
			year : {required : valYear}
		}
	});
//	
//	$.ajaxSetup({
//		/* statusCode: */
//			statusCode : {
//       			400: function() { window.location="/AugRmSystem/exception/400"
//       			},
//       			404: function() { window.location="/AugRmSystem/exception/404"
//         		},
//         		415: function() { window.location="/AugRmSystem/exception/415"
//         		},
//         		500: function() { window.location="/AugRmSystem/exception/500"
//         		},
//       		
//  			 }, 
//    		error: function(jqXHR, textStatus, errorThrown){
//	            var exceptionVO = jQuery.parseJSON(jqXHR.responseText);
//	            console.log(jqXHR.status);
//	            $('#exceptionModal')
//	            .find('.modal-header h3').html(jqXHR.status+' error').end()
//	            .find('.modal-body p>strong').html(exceptionVO.clazz).end()
//	            .find('.modal-body p>em').html(exceptionVO.method).end()
//	            .find('.modal-body p>span').html(exceptionVO.message).end()
//	            .modal('show');
//	            
//	        } 
//    	});
	
	var dtApplicant;
	
	if(dtApplicant) {
		dtApplicant.ajax.reload();
	}
	else {
		dtApplicant = $('#certificateTable').DataTable({
			paging: true,
			hover:false,
			sort:false,
			ajax : {
				url : contextPath + '/findByIdCertificate/'+id,
				type : 'POST'
			},
			columns : [ {data : "name"},
			            {data: "certificationForm"},
			            {data: "description"},
			            {data: "year"},
			            { data : function(data) {
				 			return '<button id="buttonEdit" data-id="'+data.id+'" data-toggle="modal" data-target="#certificateModal" class="btn btn-warning btn-mini"><span class="glyphicon glyphicon-pencil"></span> '+ valEdit +'</button>';
						}},
						{ data : function(data) {
							 return '<button id="buttonDelete" data-id="'+data.id+'" data-toggle="modal" data-target="#deleteModal" class="btn btn-danger btn-mini"><span class="glyphicon glyphicon-remove-sign"></span> '+ valDelete +'</button>';
						}}],
		   language:{

						    url: datatablei18n

						  },		
			searching : false

		});
	
	}

	function saveCertificate(){
		if ($('#certificateForm').valid()) {
		var name = $("#name").val();
		var certificationForm = $("#certificationForm").val();
		var description = $("#description").val();
		var year = $("#year").val();
		var json = {
				"applicant" : {"id" : id},
				"name" : name,
				"certificationForm" : certificationForm,
				"description" : description,
				"year" : year,
				};
		
		$.ajax({
			url : contextPath + "/certificates/"+id,
			type : "POST",
			contentType :"application/json; charset=utf-8",
			data : JSON.stringify(json),
			success : function(data){
				$('#certificateModal').modal('hide');
				dtApplicant.ajax.reload();
				
				new PNotify({
			        title: pnotifySuccess,
			        text: pnotifyAdd,
			        type: 'success',
			        delay: 1000,
			        buttons:{
			        	closer_hover: false,
			        	sticker: false
			        }		
			    });
			},
			error : function() {
				alert("error");
			 }
		});
		};
	}

	
	//Update 
	function findById(id){
		$.ajax({
			url : contextPath + "/findCertificateId/" + id,
			type : "POST",
			success : function(data){
				showFillData(data);
			}
		});
	}
	
	//Show data on inputField
	function showFillData(data){
		$("#certificationId").val(data.id);
		$("#name").val(data.name);
		$("#certificationForm").val(data.certificationForm);
		$("#description").val(data.description);
		$("#year").val(data.year);
 	}
	
	//Update function
	function updated(button){
		if ($('#certificateForm').valid()) {
		var id = $(button).data("id");
		var certificationId = $("#certificationId").val();
		var name = $("#name").val();
		var certificationForm = $("#certificationForm").val();
		var description = $("#description").val();
		var year = $("#year").val();
		
		var json = {
				"applicant" : {"id" : id},
				"id" : certificationId,
				"name" : name,
				"certificationForm" : certificationForm,
				"description" : description,
				"year" : year,
				};
		
		$.ajax({
			url : contextPath + "/updateCertificates/"+id,
			type : "POST",
			contentType :"application/json; charset=utf-8",
			data : JSON.stringify(json),
			success : function(data){
				$('#certificateModal').modal('hide');
				
				var table = $('#certificateTable').DataTable();	
			 	var rowData = table.row(button.closest('tr')).index(); 
			 	var d = table.row(rowData).data();
			 	
				d.name = data.name;
				d.certificationForm = data.certificationForm;
				d.description = data.description;
				d.year = data.year;
			 	
		 		table.row(rowData).data(d).draw();
		 		
		 		new PNotify({
			        title: pnotifySuccess,
			        text: pnotifyEdit,
			        type: 'success',
			        delay: 1000,
			        buttons:{
			        	closer_hover: false,
			        	sticker: false
			        }		
			    });
			},
			error : function() {
				alert("error");
			 }
		});
		};
	}
	
	  //delete Modal
    $('#deleteModal').on('shown.bs.modal', function (e) {
        var button = e.relatedTarget;
        var id = $(button).data("id");
        if (id !== null) {
            $('#btn_delete_submit').off('click').on('click', function () {
                deleted(button);
            });
        }
    });
	  
    function deleted(button) {
        var dtApplicant = $('#certificateTable').DataTable();
        var id = $(button).data("id");
        var index = dtApplicant.row(button.closest("tr")).index();
        $.ajax({
            url: contextPath + "/deleteCertificate/" + id,
            type: "POST",
            success: function () {
            	dtApplicant.row(index).remove().draw();
            	new PNotify({
			        title: pnotifySuccess,
			        text: pnotifyDel,
			        type: 'success',
			        delay: 1000,
			        buttons:{
			        	closer_hover: false,
			        	sticker: false
			        }		
			    });
			},
			error : function() {
				alert("error");
            }
        });
    }
	
    $('#certificateModal').on('shown.bs.modal', function (e) {
    	var button = e.relatedTarget;
		if(button != null){
			var id = $(button).data("id");
			if(id != null){
				console.log(id);
				findById(id);
				$('#btn_save').off('click').on('click', function(id){
					updated(button);
				});
			}else{
				$('#certificateForm')[0].reset();
				$('#btn_save').off('click').on('click', function(id){
					saveCertificate();
				});
			}

		}
   });


});
