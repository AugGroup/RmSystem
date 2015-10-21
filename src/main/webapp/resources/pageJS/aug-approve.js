 $(document).ready(function () {
//		$.ajaxSetup({
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
		/* ------------------- DataTable------------------- */
		var dtRequest;
    	if(dtRequest){ // if have dataTable
    		dtRequest.ajax.reload(); // clear and call ajax, draw table?
    	}else{
    		dtRequest = $('#requestTable').DataTable({
    				"columnDefs": [{ "width": "7%", "targets": 0 },
    				               { "width": "10%", "targets": 1 },
    				               { "width": "17%", "targets": 2 },
    				               { "width": "7%", "targets": 4 },
				             ],
			sort : false,
			ajax: {
				type: "GET",
				url: 'request/search',
				data: function (d) {
					$("#id").val(d.id);
					$("#requestDate").val(d.requestDate);
					$("#joblevel").val(d.masJobLevelName);
					$("#technology").val(d.masTechnologyName);
					$("#numberApplicant").val(d.numberApplicant);
					$("#status").val(d.status);
					}
				},
				columns : [
				           {"data": "id"},
				           {"data": "requestDate"},
				           {"data": "requesterName"},
				           {"data": "masJobLevelName"},
				           {"data": "masTechnologyName"},
				           {"data": "numberApplicant"},
				           {"data": "status"},
				           {data: function (data) {
				        	   if(data.status == "Approve"){
				        		   return '<button " class="btn btn-primary disabled btn_approve" data-id="' + data.id + '" data-toggle="modal" data-target="#approveModal"><span class="glyphicon glyphicon-edit"></span> '+approve_tx+' </button>';
				        	   } else {
				        		   return '<button " class="btn btn-primary" data-id="' + data.id + '" data-toggle="modal" data-target="#approveModal"><span class="glyphicon glyphicon-edit"></span> '+approve_tx+' </button>';
				        	   }
				        	}}
				           ],
				language:{
				    url: datatablei18n
				},
				initComplete:function(data){
					setNotAllowed();
				}
				        	  
				});
    	}
		
		/*------------------- Approve Modal Function------------------- */
		$('#approveModal').on('shown.bs.modal', function (e) {
			var button = e.relatedTarget;
			var id = $(button).data("id");
			if (id !== null) {
				editSearch(id);
				$('#btn_approve_submit').off('click').on('click', function () {
					approve(button);
					});
				}
			});
		/*------------------- Edit Function (Search id and fill)------------------- */
		function editSearch(id) {
        	$.ajax({
        		url: 'request/search/' + id,
        		type: 'POST',
        		success: function (data) {
        			 $('#inputStatus').val(data.status);
        			 /* console.log(data.status); */
        		}
        	});
        }
/*------------------- Approve Function------------------- */
		function approve(button) {
			var id = $(button).data("id");
			var status = $('#inputStatus option:selected').val();
			var index = dtRequest.row(button.closest("tr")).index();
			var approveId = $('#approveId').val();
			var json = {
					'id': id,
					'status': status,
					'approverId': approveId,
					'approveDate': moment(new Date()).format('DD-MM-YYYY')
					};
			
			$.ajax({
				contentType: "application/json",
				type: "POST",
				url: 'approve/update/' + id,
				data: JSON.stringify(json),
				success: function (data) {
					
					var dt = dtRequest.data();
					dt.id = data.id;
					dt.requesterName = data.requesterName;
					dt.requestDate = data.requestDate;
					dt.masJobLevelName = data.masJobLevelName;
					dt.masTechnologyName = data.masTechnologyName;
					dt.numberApplicant = data.numberApplicant;
					dt.status = data.status;
					
					$("#approveModal").modal('hide');
					
					setNotAllowed();
					
					dtRequest.ajax.reload();
					
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
			}
		
        //set default date
        $("#addRequestModal").on('shown.bs.modal', function() {
        	$("#inputApproveDate").val(moment(new Date()).format('DD-MM-YYYY'));
        });
        
		function setNotAllowed(data){
			$(".btn_approve").each(function(i,j){
				
				if( $(this).hasClass("disabled")){
					$(this).closest("td").hover(function(){
						$(this).css("cursor","not-allowed");
					});
				}
				
			});
		}
		
	});