  $(document).ready(function () {
        var $inputRequesterName = $('#inputRequesterName');
        var $inputRequestDate = $('#inputRequestDate');
        var $inputApprovalName = $('#inputApprovalName');
        var $inputApproveDate = $('#inputApproveDate');
        var $inputNumberApplicant = $('#inputNumberApplicant');
        var $inputSpecificSkill = $('#inputSpecificSkill');
        var $inputYearExperience = $('#inputYearExperience');
        var $inputPosition = $('#inputPosition');
        var $inputStatus = $('#inputStatus');
        
    	/* ------------------ Date picker format ------------------ */
    	$('.input-group.date').datepicker({
    		format: "dd/mm/yyyy",
			startView: 2,
			autoclose: true 
			}); 
    	/* ------------------ajax setup ------------------ */
    	$.ajaxSetup({
    		/* statusCode: */
    		 statusCode : {
        		400: function() {
        			window.location="/AugRmSystem/exception/400"
        		},
        		404: function() {
        			window.location="/AugRmSystem/exception/404"
          		},
          		415: function() {
            		window.location="/AugRmSystem/exception/415"
          		},
          		500: function() {
            		window.location="/AugRmSystem/exception/500"
          		},
        		
   			 }, 
    		 error: function(jqXHR, textStatus, errorThrown){
    			 window.location="/AugRmSystem/exception/custom"
	          /*    var exceptionVO = jQuery.parseJSON(jqXHR.responseText);
	            console.log(jqXHR.status);
	            $('#exceptionModal')
	            .find('.modal-header h3').html(jqXHR.status+' error').end()
	            .find('.modal-body p>strong').html(exceptionVO.clazz).end()
	            .find('.modal-body p>em').html(exceptionVO.method).end()
	            .find('.modal-body p>span').html(exceptionVO.message).end()
	            .modal('show');  */ 
	            
	        }  
    	});
    	
		
			 
		/*-------------------- Validate Request Form--------------------*/
		$('#requestForm').validate({
			rules:{
				inputRequesterName:{required: true},
				inputRequestDate:{required: true},
				inputPosition:{required: true},
			  	inputApprovalName:{required: true},
				inputApproveDate:{required: true},
				inputNumberApplicant:{required: true,digits: true},
				inputSpecificSkill:{required: true},
				inputYearExperience:{required: true,digits: true},
				inputStatus:{required: true}
				},
			messages:{
				inputRequesterName:{required: reqName },
			  	inputRequestDate:{required: reqDate},
			  	inputPosition:{required: reqPosition },
			  	inputApprovalName:{required: reqApproval},
				inputApproveDate:{required: approveDate},
				inputNumberApplicant:{required: reqApplicant ,
									digits: infoTelNumber },
				inputSpecificSkill:{required: reqSkill },
				inputYearExperience:{required: reqYear ,
									digits: infoTelNumber },
				inputStatus:{required: reqStatus }
				}
			  });
			 
		/*-------------------- DataTable--------------------*/	 
        var dtRequest;
        if(dtRequest){ // if have dataTable
        	dtRequest.ajax.reload(); // clear and call ajax, draw table?
		}else{
         dtRequest = $('#requestTable').DataTable({
        	 searching : true,
        	 paging: 10,
        	 sort : false,
        	 columnDefs : [
        	                { "width": "5%", "targets": 0 },
        	                { "width": "10%", "targets": 1 },
        	                { "width": "17%", "targets": 2 },
        	                { "width": "7%", "targets": 4 },
        	                
				             ],
        	 /* order: [[ 2, 'asc' ]], */
        	 ajax: {
        		 type: "GET",
        		 url: 'request/search'
        		 },
        	columns: [
        	          {"data": "id"},
        	          {"data": "requestDate"},
        	          {"data": "requesterName"},
        	          {"data": "positionStr"},
        	          {"data": "numberApplicant"},
        	          {"data": "status"},
        	          {data: function (data) {
        	        	  return '<button id="btn_preview" class="btn btn-primary" data-id="' + data.id + '" data-toggle="modal" data-target="#previewModal">'+preview_tx + ' <span class="glyphicon glyphicon-search"></span></button>';
        	        	  }
        	          },
        	          {data: function (data) {
        	        	  if(data.status!="Approve"){
                        	return '<button id="btn_edit" class="btn btn-warning" data-id="' + data.id + '" data-toggle="modal" data-target="#addRequestModal">'+edit_tx + ' <span class="glyphicon glyphicon-edit"></span></button>';
        	        	  }else{
        	        		return '<button id="btn_edit" class="btn btn-warning" data-id="' + data.id + '" data-toggle="modal" data-target="#addRequestModal" disabled>'+edit_tx + ' <span class="glyphicon glyphicon-edit"></span></button>';
            	          }
        	        	}
        	          },
        	          {data: function (data) {
        	        	  if(data.status!="Approve"){
        	        	 	  return '<button id="btn_delete" class="btn btn-danger" data-id="' + data.id + '" data-toggle="modal" data-target="#deleteModal">'+delete_tx + ' <span class="glyphicon glyphicon-remove-sign"></span></button>';
        	        	  }else{
        	        		  return '<button id="btn_delete" class="btn btn-danger" data-id="' + data.id + '" data-toggle="modal" data-target="#deleteModal" disabled >'+delete_tx + ' <span class="glyphicon glyphicon-remove-sign"></span></button>'}
        	         	  }
        	          }
        	          ]
        		 });
         }
        
        /*-------------------- Delete Modal Function--------------------*/
        $('#deleteModal').off("click").on('shown.bs.modal', function (e) {
        	var button = e.relatedTarget;
            var id = $(button).data("id");
            if (id !== null) {
            	$('#btn_delete_submit').on('click', function () {
            		deleted(button);
            		});
            	}
            });
        /*-------------------- Delete Function--------------------*/
        function deleted(button) {
        	var dtRequest = $('#requestTable').DataTable();
            var id = $(button).data("id");
            var index = dtRequest.row(button.closest("tr")).index();
            $.ajax({
                url: 'request/delete/' + id,
                type: 'POST',
                success: function () {
                    dtRequest.row(index).remove().draw();
                }
            });
        }

        /*-------------------- Save and Edit Request Modal Function--------------------*/
        $('#addRequestModal').off("click").on('shown.bs.modal', function (e) {
        	var button = e.relatedTarget;
        	if (button != null) {
        		var id = $(button).data("id");
                if (id != null) {
                	editSearch(id);
                	$('#btn_save_req').off('click').on('click', function () {
                		edit(button);
                		});
                } else {
                	$('#requestForm')[0].reset();
                	$('#btn_save_req').off('click').on('click', function () {
                		save();
                		});
                	}
                }
        	});

        /*-------------------- Save Function--------------------*/
        function save(button) {
        	var request = {
        			requesterName: $inputRequesterName.val(),
        			requestDate: $inputRequestDate.val(),
        			approvalName: $inputApprovalName.val(),
        			approveDate: $inputApproveDate.val(),
        			numberApplicant : $inputNumberApplicant.val(),
        			specificSkill: $inputSpecificSkill.val(),
        			yearExperience : $inputYearExperience.val(),
        			positionRequest : $inputPosition.val(),
        			status: $inputStatus.val()
        			};
        	//console.log(request);
        	var isValid = $("#requestForm").valid();
            //debugger;
            if(isValid){
            	$.ajax({
            		contentType: "application/json",
            		type: "POST",
            		url: 'request/save',
            		data: JSON.stringify(request),
            		success: function (data) {
            			$('#addRequestModal').modal('hide');
            			dtRequest.ajax.reload();
            			//console.log(data.requesterName);
            			new PNotify({
    				    	title: 'Edit request is successful.',
    				    	text: '',
    				    	type: 'success',
    				    	delay: 3000,
    				    	buttons: {
    				    			closer_hover: false,
    				    	        sticker: false
    				    	    }
    					});
            		},
            		 
            	});
            };
           }
        
        /*-------------------- Edit Function (Search id)--------------------*/
        function editSearch(id) {
        	$.ajax({
        		url: 'request/search/' + id,
        		type: 'POST',
        		success: function (data) {
        			editShowData(data);
        		}
        		
        	});
        }
        
        /*-------------------- Edit Function (Fill Data)--------------------*/
        function editShowData(data) {
        	$('#inputRequesterName').val(data.requesterName);
            $('#inputRequestDate').val(data.requestDate);
            $('#inputApprovalName').val(data.approvalName);
            $('#inputApproveDate').val(data.approveDate);
            $('#inputNumberApplicant').val(data.numberApplicant);
            $('#inputSpecificSkill').val(data.specificSkill);
            $('#inputYearExperience').val(data.yearExperience);
            $('#inputPosition').val(data.positionRequest);
            $('#inputStatus').val(data.status);
        }
       
        /*-------------------- Edit Function --------------------*/
        function edit(button){
            var id = $(button).data("id");
            var requesterName = $inputRequesterName.val();
            var requestDate = $inputRequestDate.val();
            var approvalName = $inputApprovalName.val();
            var approveDate = $inputApproveDate.val();
            var numberApplicant = $inputNumberApplicant.val();
            var specificSkill = $inputSpecificSkill.val();
            var yearExperience = $inputYearExperience.val();
            var positionRequest = $inputPosition.val();
            var status = $inputStatus.val();
            
            var index = dtRequest.row(button.closest("tr")).index();
            
            var request = {
                'id': id,
                'requesterName': requesterName,
                'requestDate' : requestDate,
                'approvalName' : approvalName,
                'approveDate' : approveDate,
                'numberApplicant': numberApplicant,
                'specificSkill': specificSkill,
                'yearExperience': yearExperience, 
                'positionRequest':positionRequest,
                'status': status
            };
            if($("#requestForm").valid()){
            $.ajax({
                contentType: "application/json",
                type: "POST",
                url: 'request/edit/' + id,
                data: JSON.stringify(request),
                success: function (data) {
                	//console.log(data.positionStr);
                    var dt = dtRequest.data();
                    dt.id = data.id;
                    dt.requesterName = data.requesterName;
                    dt.requestDate = data.requestDate;
                    dt.approvalName = data.approvalName;
                    dt.approveDate = data.approveDate;
                    dt.numberApplicant = data.numberApplicant;
                    dt.specificSkill = data.specificSkill;
                    dt.yearExperience = data.yearExperience;
                    dt.status = data.status;
                    dt.positionStr = data.positionStr;
                    dtRequest.row(index).data(dt).draw();  
                   
                    $("#addRequestModal").modal('hide');
                    /*dtRequest.ajax.reload();*/ //change to use draw table 
                    
                    new PNotify({
				    	title: 'Edit request is successful.',
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
            };
        }

        /*-------------------- Preview Modal Function --------------------*/
        $('#previewModal').off("click").on('shown.bs.modal', function (e) {
            var button = e.relatedTarget;
            var id = $(button).data("id");
            if (id !== null) {
            	$.ajax({
            		url : 'request/search/' + id,
					type : 'POST',
					success : function(data){
						previewShowData(data);
					}
            	});
            }
        });
      
        /*-------------------- Preview Function --------------------*/
        
        function previewShowData(data){
        	//console.log(data.requesterName);
        	$('#tx_requester').text(data.requesterName);
            $('#tx_requestDate').text(data.requestDate);
            $('#tx_approvalName').text(data.approvalName);
            $('#tx_approveDate').text(data.approveDate);
            $('#tx_noOfApplicant').text(data.numberApplicant);
            $('#tx_specificSkill').text(data.specificSkill);
            $('#tx_yearExperience').text(data.yearExperience);
            $('#tx_position').text(data.positionRequest);
            $('#tx_status').text(data.status);
            }
        });
