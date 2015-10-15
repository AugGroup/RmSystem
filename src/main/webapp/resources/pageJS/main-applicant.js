$(document).ready(function(){
	var dtApplicant
	$('#EditStatusForm').validate({
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
			  	inputScore:{required: valScore},
			  	inputTechScore:{required: valTech},
			  	inputAttitudeHome:{required: valAttHome},
			  	inputAttitudeOffice:{required: valAttOffice},
			  	inputStatus:{required: valStatus}
			  	}
	});
		
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
			//	responsive: true,
				searching : true,
				paging: true,
				hover:false,
				sort:false,
				ajax : {
					url : 'applicant/search',
					type : 'POST',
					data : function(d){
						d.joblevelStr = $('#inputSearch').val();
//						d.masTechnologyName = $('#inputSearch').val();
						 console.log(d.joblevelStr) 
					},
				 },
				 columns:[{data : "code"},
				          {data : "applyDate"},
					      {data : "firstNameEN"},
					      {data : "joblevelStr"},
					      {data : "technologyStr"},
					      {data : "trackingStatus"},
					      {data : function(data){
					    	  return '<a href="#EditStatusModal" id="btn_edit_score" data-id="'+data.id+'" data-toggle="modal" class="btn btn-sm btn-warning"><span class="glyphicon glyphicon-pencil"></span> '+editScore_text+'</b>'
					       }},
					       { data : function(data){
					    	  return '<a href="info/' + data.id + '" id="btn_edit_info"  data-id="'+data.id+'" data-toggle="modal" class="btn btn-sm btn-warning"><span class="glyphicon glyphicon-pencil"></span> '+editInfo_text+'</b>'
						   }},
						   { data: function (data) {
						      return '<a href="#deleteModal" id="btn_delete" data-id="' + data.id + '" data-toggle="modal" class="btn btn-sm btn-danger"><span class="glyphicon glyphicon-remove-sign"></span> '+delete_text+'</b>'
				           }}
				   ],
				   language:{
					    url: datatablei18n
					  }
				 });
			}
		});
	
	//EditStatusModal
	$('#EditStatusModal').on('show.bs.modal',function(e){
		$("#error-approve").empty();
		var button = e.relatedTarget;
		if (button != null){
			var applicantId = $(button).data("id");
			if(applicantId != null){
				findById(applicantId);
				 console.log(applicantId); 
				$("#btn_submit").off("click").on("click", function(){
					updateUser(button);
				});
			}
		}
	});
	
	$("#inputTechScore").on("change", function(){
		if( $(this).val() == "Pass" ) {
			$("#error-approve").empty();
		}
	});
		
		//Find by Id
		function findById(id){
			 console.log(id); 
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
			$("#error-approve").empty();
			
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
			
			if(trackingStatus == "Approve" && techScore != "Pass") {
				//alert("can't approve.");
				$("#error-approve").css("color","red");
				$("#error-approve").empty().append("can't approve.");
			} else if($("#EditStatusForm").valid()){
				$("#error-approve").empty();
				$.ajax({
					url : "update/score/"+id,
					type : "POST",
					contentType :"application/json; charset=utf-8", 
					data : JSON.stringify(json),
					success : function(data){
						console.log(data);
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
		
		$('#btn_search').trigger("click");
		
	});