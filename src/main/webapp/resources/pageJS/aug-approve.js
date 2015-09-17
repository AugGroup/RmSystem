$(document).ready(function () {
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
		/* ------------------- DataTable------------------- */
		var dtRequest;
		var dtRequest =$('#requestTable').DataTable({
			"columnDefs": [
       	                { "width": "7%", "targets": 0 },
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
					$("#positionName").val(d.positionName);
					$("#numberApplicant").val(d.numberApplicant);
					$("#status").val(d.status);
					}
				},
				columns : [
				           {"data": "id"},
				           {"data": "requestDate"},
				           {"data": "requesterName"},
				           {"data": "positionStr"},
				           {"data": "numberApplicant"},
				           {"data": "status"},
				           {data: function (data) {
				        	   		return '<button id="btn_approve" class="btn btn-primary" data-id="' + data.id + '" data-toggle="modal" data-target="#approveModal">'+approve_tx+' <span class="glyphicon glyphicon-edit"></span></button>';				        
				        	   
				        	}}
				           ]
				});
		
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
			var status = $('#inputStatus').val();
			var index = dtRequest.row(button.closest("tr")).index();
			var request = {
					'id': id,
					'status': status
					};
			
			$.ajax({
				contentType: "application/json",
				type: "POST",
				url: 'approve/update/' + id,
				data: JSON.stringify(request),
				success: function (data) {
					//console.log(data.status);
					var dt = dtRequest.data();
					dt.id = data.id;
					dt.requesterName = data.requesterName;
					dt.requestDate = data.requestDate;
					dt.positionStr = data.positionStr;
					dt.numberApplicant = data.numberApplicant;
					dt.status = data.status;
					dtRequest.row(index).data(dt).draw();
					$("#approveModal").modal('hide');
					
					new PNotify({
				    	title: 'Edit Approve status is successful.',
				    	text: '',
				    	type: 'success',
				    	delay: 3000,
				    	buttons: {
				    			closer_hover: false,
				    	        sticker: false
				    	    }
					});
					}
				});
			}
		
	});