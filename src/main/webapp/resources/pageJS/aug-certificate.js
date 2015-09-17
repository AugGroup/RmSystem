$(document).ready(function() {
	
	$('#certificateForm').validate({
		rules : {
			certificate : {required : true}
		},
		messages : {
			certificate : {required : valCer}
		}
	});
	
	$.ajaxSetup({
		/* statusCode: */
			statusCode : {
       			400: function() { window.location="/AugRmSystem/exception/400"
       			},
       			404: function() { window.location="/AugRmSystem/exception/404"
         		},
         		415: function() { window.location="/AugRmSystem/exception/415"
         		},
         		500: function() { window.location="/AugRmSystem/exception/500"
         		},
       		
  			 }, 
    		error: function(jqXHR, textStatus, errorThrown){
	            var exceptionVO = jQuery.parseJSON(jqXHR.responseText);
	            console.log(jqXHR.status);
	            $('#exceptionModal')
	            .find('.modal-header h3').html(jqXHR.status+' error').end()
	            .find('.modal-body p>strong').html(exceptionVO.clazz).end()
	            .find('.modal-body p>em').html(exceptionVO.method).end()
	            .find('.modal-body p>span').html(exceptionVO.message).end()
	            .modal('show');
	            
	        } 
    	});
	
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
				url : 'findByIdCertificate/'+id,
				type : 'POST'
			},
			columns : [ {data : "certificateName"},
			            { data : function(data) {
				 			return '<button id="buttonEdit" data-id="'+data.id+'" data-toggle="modal" data-target="#certificateModal" class="btn btn-warning btn-mini"><span class="glyphicon glyphicon-pencil"></span> '+ valEdit +'</button>';
						}},
						{ data : function(data) {
							 return '<button id="buttonDelete" data-id="'+data.id+'" data-toggle="modal" data-target="#deleteModal" class="btn btn-danger btn-mini"><span class="glyphicon glyphicon-remove-sign"></span> '+ valDelete +'</button>';
						}}],
			searching : false

		});
	
	}

	function saveCertificate(){
		if ($('#certificateForm').valid()) {
		var certificateName = $("#certificate").val();
		var json = {
				"applicant" : {"id" : id},
				"certificateName" : certificateName,
				};
		
		$.ajax({
			url : "certificates/"+id,
			type : "POST",
			contentType :"application/json; charset=utf-8",
			data : JSON.stringify(json),
			success : function(data){
				$('#certificateModal').modal('hide');
				dtApplicant.ajax.reload();
				
				new PNotify({
				    title: 'Edit Family Success!!',
				    text: 'You can edit data',
				    type: 'success',
			        delay: 10000,
			        buttons:{
			        	closer_hover: false,
			        	sticker: false
			        }		
				});
			 }
		});
		};
	}

	
	//Update 
	function findById(id){
		$.ajax({
			url : "findCertificateId/" + id,
			type : "POST",
			success : function(data){
				showFillData(data);
			}
		});
	}
	
	//Show data on inputField
	function showFillData(data){
		$("#certificate").val(data.certificateName);
 	}
	
	//Update function
	function updated(button){
		if ($('#certificateForm').valid()) {
		var id = $(button).data("id");
		var certificateName = $("#certificate").val();
		
		var json = {
				"id" : id,
				"certificateName" : certificateName,
				};
		
		$.ajax({
			url : "updateCertificates/"+id,
			type : "POST",
			contentType :"application/json; charset=utf-8",
			data : JSON.stringify(json),
			success : function(data){
				$('#certificateModal').modal('hide');
				
				var table = $('#certificateTable').DataTable();	
			 	var rowData = table.row(button.closest('tr')).index(); 
			 	var d = table.row(rowData).data();
			 	
				d.certificateName = data.certificateName;
			 	
		 		table.row(rowData).data(d).draw();
		 		
				new PNotify({
				    title: 'Edit Family Success!!',
				    text: 'You can edit data',
				    type: 'success',
			        delay: 10000,
			        buttons:{
			        	closer_hover: false,
			        	sticker: false
			        }		
				});
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
            url: "deleteCertificate/" + id,
            type: "POST",
            success: function () {
            	dtApplicant.row(index).remove().draw();
				new PNotify({
				    title: 'Delete Success',
				    text: 'You can delete data',
				    type: 'success',
			        delay: 10000,
			        buttons:{
			        	closer_hover: false,
			        	sticker: false
			        }		
				});
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
