$(document).ready(function () {
        var $inputRequesterName = $('#inputRequesterName');
        var $inputRequestDate = $('#inputRequestDate');
        var $inputApprovalName = $('#inputApprovalName');
        var $inputApproveDate = $('#inputApproveDate');
        var $inputNumberApplicant = $('#inputNumberApplicant');
        var $inputSpecificSkill = $('#inputSpecificSkill');
        var $inputYearExperience = $('#inputYearExperience');
        var $inputJoblevel = $('#inputJoblevel');
        var $inputTechnology = $('#inputTechnology');
        var $inputStatus = $('#inputStatus');
        
    	/* ------------------ Date picker format ------------------ */
    	$('.input-group.date').datepicker({
    		format: "dd-mm-yyyy",
    		todayBtn : "linked",
			startView: 2,
			autoclose: true 
			}); 
    	
    	$(document).on("focusin", ".datepicker_readonly", function(event) {

		  $(this).prop('readonly', true);

		});

		$(document).on("focusout", ".datepicker_readonly", function(event) {

		  $(this).prop('readonly', false);

		});
		
		
//    	/* ------------------ajax setup ------------------ */
//    	$.ajaxSetup({
//    		/* statusCode: */
//    		 statusCode : {
//        		400: function() {
//        			window.location="/AugRmSystem/exception/400"
//        		},
//        		404: function() {
//        			window.location="/AugRmSystem/exception/404"
//          		},
//          		415: function() {
//            		window.location="/AugRmSystem/exception/415"
//          		},
//          		500: function() {
//            		window.location="/AugRmSystem/exception/500"
//          		},
//        		
//   			 }, 
//    		 error: function(jqXHR, textStatus, errorThrown){
//    			 window.location="/AugRmSystem/exception/custom"
//	          /*    var exceptionVO = jQuery.parseJSON(jqXHR.responseText);
//	            console.log(jqXHR.status);
//	            $('#exceptionModal')
//	            .find('.modal-header h3').html(jqXHR.status+' error').end()
//	            .find('.modal-body p>strong').html(exceptionVO.clazz).end()
//	            .find('.modal-body p>em').html(exceptionVO.method).end()
//	            .find('.modal-body p>span').html(exceptionVO.message).end()
//	            .modal('show');  */ 
//	            
//	        }  
//    	});
//    	
//		
			 
		/*-------------------- Validate Request Form--------------------*/
		var $requestForm = $('#requestForm').validate({
			rules:{
				inputRequesterName:{required: true},
				inputRequestDate:{required: true},
				inputJoblevel:{required: true},
				inputTechnology:{required: true},
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
			  	inputJoblevel:{required: reqJoblevel },
			  	inputTechnology:{required: reqTechnology },
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
        		 url: contextPath + '/request/search',
        	 },
        	columns: [
        	          {data: "id"},
        	          {data: "requestDate"},
        	          {data: "requesterName"},
        	          {data: "masJobLevelName"},
        	          {data: "masTechnologyName"},
        	          {data: "numberApplicant"},
        	          {data: "status"},
        	          {data: function (data) {
        	        	  return '<button id="btn_preview" class="btn btn-primary" data-id="' + data.id + '" data-toggle="modal" data-target="#previewModal"><span class="glyphicon glyphicon-search"></span> '+preview_tx +'</button>';
        	        	  }
        	          },
        	          {data: function (data) {
        	        	  if(data.status!="Approve"){
                        	return '<button class="btn btn-warning btn_edit" data-id="' + data.id + '" data-toggle="modal" data-target="#addRequestModal"><span class="glyphicon glyphicon-edit"></span> '+edit_tx + '</button>';
        	        	  }else{
        	        		return '<button class="btn btn-warning disabled btn_edit" data-id="' + data.id + '" data-toggle="modal" data-target="#addRequestModal"><span class="glyphicon glyphicon-edit"></span> '+edit_tx + '</button>';
            	          }
        	        	}
        	          },
        	          {data: function (data) {
        	        	 	return '<button class="btn btn-danger btn_delete" data-id="' + data.id + '" data-toggle="modal" data-target="#deleteModal"><span class="glyphicon glyphicon-remove-sign"></span> '+delete_tx + '</button>';
        	        	}
        	          }
        	          ],
        	          language:{
        	        	  url: datatablei18n
        	          },
        	          initComplete:function(data){
        	        	  setNotAllowed();
        	          }  
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

        $('#addRequestModal').on('hide.bs.modal', function (e) {
        	$requestForm.resetForm();
        })
        
        
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
        	var requestDate = $inputRequestDate.val();
        	var numberApplicant = $inputNumberApplicant.val();
        	var specificSkill = $inputSpecificSkill.val();
        	var yearExperience = $inputYearExperience.val();
        	var status = $inputStatus.val();
        	var requestTechnologyId = $inputTechnology.val();
        	var requestJoblevelId = $inputJoblevel.val();
        	var requestId = $("#requestId").val();
        	
        	var json = {
        			"requestDate": requestDate,
        			"numberApplicant" : numberApplicant,
        			"specificSkill": specificSkill,
        			"yearExperience" : yearExperience,
        			"technology" : {"id" : requestTechnologyId },
        			"joblevel" : {"id" : requestJoblevelId },
        			"status": status,
        			"requester": {"id" : requestId}
        			};
        	console.log(json);
        	var isValid = $("#requestForm").valid();
            //debugger;
            if(isValid){
            	$.ajax({
            		contentType: "application/json",
            		type: "POST",
            		url: 'request/save',
            		data: JSON.stringify(json),
            		success: function (data) {
            			console.log(data);
            			$('#addRequestModal').modal('hide');
            			dtRequest.ajax.reload();
            			//console.log(data.requesterName);
            			
            			setNotAllowed();
            			
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
        	$inputRequesterName.val(data.requesterName);
        	$inputRequestDate.val(data.requestDate);
        	$inputNumberApplicant.val(data.numberApplicant);
        	$inputSpecificSkill.val(data.specificSkill);
        	$inputYearExperience.val(data.yearExperience);
        	$inputJoblevel.val(data.joblevelId);
        	$inputTechnology.val(data.technologyId);
        	$inputStatus.val(data.status);
        }
       
        /*-------------------- Edit Function --------------------*/
        function edit(button){
            var id = $(button).data("id");
        	var requestName = $inputRequesterName.val();
        	var requestDate = $inputRequestDate.val();
        	var approvalName = $inputApprovalName.val();
        	var approvalDate = $inputApproveDate.val();
        	var numberApplicant = $inputNumberApplicant.val();
        	var specificSkill = $inputSpecificSkill.val();
        	var yearExperience = $inputYearExperience.val();
        	var status = $inputStatus.val();
        	var requestTechnologyId = $inputTechnology.val();
        	var requestTechnology = $("#inputTechnology option:selected").text();
        	var requestJoblevelId = $inputJoblevel.val();
        	var requestJoblevel = $("#inputJoblevel option:selected").text();
            
            var index = dtRequest.row(button.closest("tr")).index();
            console.log(id);
            
            var request = {
                'id': id,
                'requesterName': requestName,
                'requestDate' : requestDate,
                'approvalName' : approvalName,
                'approveDate' : approvalDate,
                'numberApplicant': numberApplicant,
                'specificSkill': specificSkill,
                'yearExperience': yearExperience, 
                'technologyId':requestTechnologyId,
                'masTechnologyName':$("#inputTechnology option:selected").text(),
                'joblevelId':requestJoblevelId,
                'masJobLevelName':$("#inputJoblevel option:selected").text(),
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
                    dt.masJobLevelName = data.masJobLevelName;
                    dt.masTechnologyName = data.masTechnologyName;
                    dtRequest.row(index).data(dt).draw();  
                   
                    $("#addRequestModal").modal('hide');
                    /*dtRequest.ajax.reload();*/ //change to use draw table 
                    
                    setNotAllowed();
                    
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
            
            if(!data.approvalName ){
            	$('#tx_approvalName').text("-");
            }else {
            	$('#tx_approvalName').text(data.approvalName);
            }
            
            if(!data.approveDate){
            	$('#tx_approveDate').text("-");
            }else {
            	$('#tx_approveDate').text(data.approveDate);
            }
            
            $('#tx_noOfApplicant').text(data.numberApplicant);
            $('#tx_specificSkill').text(data.specificSkill);
            $('#tx_yearExperience').text(data.yearExperience);
            $('#tx_jobLevel').text(data.masJobLevelName);
            $('#tx_technology').text(data.masTechnologyName);
            $('#tx_status').text(data.status);
        }
        
        //set default date
        $("#addRequestModal").on('shown.bs.modal', function() {
        	$("#inputRequestDate").val(moment(new Date()).format('DD-MM-YYYY'));
        });
        
        
        function setNotAllowed() {
        	$(".btn_edit").each(function(k,v){
        		
        		//alert("setNotAllowed");
        		
        		if ( $(this).hasClass("disabled") ) {
        			$(this).closest("td").hover(function(){ $(this).css("cursor","not-allowed"); }); 
        		}
        		
        		
        	});
        }
        
        $("#inputJoblevel").on("change", function(){
//			 alert( $("#jobLevel option:selected").val() );
			 if ( $("#inputJoblevel option:selected").val() == 4 || $("#inputJoblevel option:selected").val() == 11 ) {
				 $("#tech").show();
				 //alert( $("#joblevel option:selected").val() );
			 } else {
				 $("#inputTechnology option:selected").val("6");
				 $("#tech").hide();
				 //alert($("#technology option:selected").val());
			 }
        });
});
