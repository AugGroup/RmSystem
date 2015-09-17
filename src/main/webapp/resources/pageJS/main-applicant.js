$(document).ready(function(){
	var dtApplicant
	/* $('#EditStatusForm').validate({
			rules:{
				inputRequesterName:{required: true},
				inputScore:{required: true},
				inputTechScore:{required: true},
			  	inputAttitudeHome:{required: true},
			  	inputAttitudeOffice:{required: true},
			  	inputStatus:{required: true}
			  	},
			messages: {
				inputRequesterName:{required: "Requester name is required"},
			  	inputScore:{required: "Score is required"},
			  	inputTechScore:{required: "Technical score is required"},
			  	inputAttitudeHome:{required: "Attitude at home is required"},
			  	inputAttitudeOffice:{required: "Attitude at office is required"},
			  	inputStatus:{required: "Request status is required"}
			  	}
		}); */
		
	//Search By Position and Show function
	$('#btn_search').on('click', function(){
		if(dtApplicant){
			dtApplicant.ajax.reload();
		}else{
			dtApplicant = $('#dataTable').DataTable({
			/*	language: { //ยังไม่ได้แก้!!!
			       "lengthMenu": "Display _MENU_ records per page",
			       "zeroRecords": "Nothing found - sorry",
			       "info": "Showing page _PAGE_ of _PAGES_",
			       "infoEmpty": "No records available",
			       "infoFiltered": "(filtered from _MAX_ total records)"
			        },*/
				searching : true,
				paging: true,
				hover:false,
				sort:false,
				ajax : {
					url : 'applicant/search',
					type : 'POST',
					data : function(d){
						d.position = $('#inputSearch').val();
						/* console.log(d.position) */
					},
				 },
				 columns:[{'data': "code"},
				          {'data': "applyDate"},
					      {'data' : "firstNameEN"},
					      {'data' : "position1Str"},
					      {'data' : "position2Str"},
					      {'data' : "position3Str"},
					      {'data' : "trackingStatus"},
					      { data : function(data){
					    	  return '<a href="#EditStatusModal" id="btn_edit_score" data-id="'+data.id+'" data-toggle="modal" class="btn btn-sm btn-warning"><span class="glyphicon glyphicon-pencil"></span> '+editScore_text+'</b>'
					       }},
					       { data : function(data){
					    	  return '<a href="info/' + data.id + '" id="btn_edit_info"  data-id="'+data.id+'" data-toggle="modal" class="btn btn-sm btn-warning"><span class="glyphicon glyphicon-pencil"></span> '+editInfo_text+'</b>'
						   }},
						   { data: function (data) {
						      return '<a href="#deleteModal" id="btn_delete" data-id="' + data.id + '" data-toggle="modal" class="btn btn-sm btn-danger"><span class="glyphicon glyphicon-remove-sign"></span> '+delete_text+'</b>'
				           }}
				   ]
				 });
			}
		});
	
	//EditStatusModal
	$('#EditStatusModal').on('show.bs.modal',function(e){
		var button = e.relatedTarget;
		if (button != null){
			var applicantId = $(button).data("id");
			if(applicantId != null){
				findById(applicantId);
				/* console.log(applicantId); */
				$("#btn_submit").off("click").on("click", function(){
					updateUser(button);
				});
			}
		}
	});
		
		//Find by Id
		function findById(id){
			/* console.log(id); */
			$.ajax({
				url : "applicant/search/" + id,
				type : "POST",
				success : function(data){
				showFillData(data);
				}
			});
		}
		
		//Show data on inputField
		function showFillData(data){
			$('#EditStatusForm')[0].reset();
			$('#inputScore').val(data.score);
			$('input[name="inputTechScore"][value='+data.techScore+']').prop('checked', true);
			$('#inputAttitudeHome').val(data.attitudeHome);
			$('#inputAttitudeOffice').val(data.attitudeOffice);
			$('#inputStatus').val(data.trackingStatus);
		}
		
		//Update Score Fuction
		function updateUser(button){
			var id = $(button).data("id");
			var score = $("#inputScore").val();
			var techScore = $('input[name="inputTechScore"]:checked').val();
			var attitudeHome = $("#inputAttitudeHome").val();
			var attitudeOffice = $("#inputAttitudeOffice").val();
			var trackingStatus = $("#inputStatus").val(); 
			var json = {
					"id" : id,
					"score" : score,
					"techScore" : techScore,
					"attitudeHome" : attitudeHome,
					"attitudeOffice" : attitudeOffice,
					"trackingStatus" : trackingStatus
					};
			if($("#EditStatusForm").valid()){
				$.ajax({
					url : "update/score/"+id,
					type : "POST",
					contentType :"application/json; charset=utf-8", 
					data : JSON.stringify(json),
					success : function(data){
						$('#EditStatusModal').modal('hide');
						var table = $('#dataTable').DataTable();	
					 	var rowData = table.row(button.closest('tr')).index(); 
					 	var d = table.row(rowData).data();
					 	d.score = data.score;
					 	d.techScore = data.techScore;
					 	d.attitudeHome = data.attitudeHome;
					 	d.attitudeOffice = data.attitudeOffice;
					 	d.trackingStatus = data.trackingStatus;
					 	table.row(rowData).data(d).draw();
					 	
					 	new PNotify({
					    	title: 'Edit score is successful',
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
		
		//delete function
		function deleted(button) {
			var dtApplicant = $('#dataTable').DataTable();
			var id = $(button).data("id");
			var index = dtApplicant.row(button.closest("tr")).index();
			$.ajax({
				url: "delete/" + id,
	            type: "POST",
	            success: function () {
	            	dtApplicant.row(index).remove().draw();
	            	new PNotify({
	            		title: 'Delete Success',
						text: 'You can delete data',
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
		
		$('#btn_search').trigger("click");
		
	});