$(document).ready(function() {
		var dtApplicant;
		
	    $('input[name="applyDateStr"]').daterangepicker({
	        format: 'DD/MM/YYYY',
	        opens : "left",
	        showDropdowns : true,
	    });
		
		$('.input-group.date').datepicker({
			startView : 2,
			todayBtn : "linked",
			format : "dd/mm/yyyy",
			autoclose: true 
	});
	
 	$('#experiencesForm').validate({
		rules : {
			workBackground : {required : true,},
			emp : {required : true,},
			addressBackground : {required : true,},
			business : {required : true,},
			positionBackground : {required : true,},
			supervisorBackground : {required : true,},
			salaryBackground : {required : true,},
			descriptionBackground : {required : true,},
			reasonLeaving : {required : true,}
		},
		messages : {
			workBackground : {required : valWorkBackground},
			fromWorkYear : {required : valFromYear},
			toWorkYear : {required : valToYear},
			emp : {required : valEmp},
			addressBackground : {required : valAddress},
			business : {required : valType},
			positionBackground : {required : valPosition},
			supervisorBackground : {required : valSupervisor},
			salaryBackground : {required : valSalary},
			descriptionBackground : {required : valDescription},
			reasonLeaving : {required : valReason}
		}
	});
		
	var dtApplicant;
		
	if(dtApplicant) {
		dtApplicant.ajax.reload();
	}
	else {
		dtApplicant = $('#experiencesTable').DataTable({
			paging: true,
			hover:false,
			sort:false,
			ajax : {
				url : 'findByIdExperience/' + id,
				type : 'POST'
			},
			columns : [ {data : "position"},
			            {data : "employerName"},
			            {data : "address"},
			            {data : "typeOfBusiness"},
			            {data : "supervisor"},
			            {data : "salary"},
			            {data : "applyDateStr"},
			            {data : function(data) {
				 			return '<button id="buttonEdit" data-id="'+data.id+'" data-toggle="modal" data-target="#experiencesModal" class="btn btn-warning btn-mini"><span class="glyphicon glyphicon-pencil"></span> '+ valEdit +'</button>';
						}},
						{data : function(data) {
				 			return '<button id="buttonDelete" data-id="'+data.id+'" data-toggle="modal" data-target="#deleteModal" class="btn btn-danger btn-mini"><span class="glyphicon glyphicon-remove-sign"></span> '+ valDelete +'</button>';
						}}],
			searching : false

		});
	
	}
		
	function saveExperience(){
		if ($('#experiencesForm').valid()) {
		var position = $("#workBackground").val();
		var employerName = $("#emp").val();
		var address = $("#addressBackground").val();

		var typeOfBusiness = $("#business").val();
		var positionOfEmployer = $("#positionBackground").val();
		var reason = $("#reasonLeaving").val();
		var supervisor = $("#supervisorBackground").val();
		var salary = $("#salaryBackground").val();
		
		var description = $("#descriptionBackground").val();
		var applyDateStr = $("#applyDateStr").val();
		
		var json = {
				"applicant" : {"id" : id},
				"position" : position,
				"employerName" : employerName,
				"address" : address,
				"typeOfBusiness" : typeOfBusiness,
				"positionOfEmployer" : positionOfEmployer,
				"supervisor" : supervisor,
				"salary" : salary,
				"description" : description,
				"reason" : reason,
				"applyDateStr" : applyDateStr
				};
		
		$.ajax({
			contentType : "application/json",
			type : "POST",
			url : 'experiences/' +id,
			data : JSON.stringify(json),
			success : function(data) {
				$('#experiencesModal').modal('hide');
				dtApplicant.ajax.reload();
				
				new PNotify({
			        title: 'Success',
			        text: 'Successful Add Experience!!!',
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
		
		//Find by Id
		function findById(id){
			$.ajax({
				url : "findExperienceId/" + id,
				type : "POST",
				success : function(data){
					showFillData(data);
				}
			});
		}
		
		//Show data on inputField
		function showFillData(data){
			$("#workBackground").val(data.position);
			$("#emp").val(data.employerName);
			$("#addressBackground").val(data.address);

			$("#business").val(data.typeOfBusiness);
			$("#positionBackground").val(data.positionOfEmployer);
			$("#reasonLeaving").val(data.reason);
			$("#supervisorBackground").val(data.supervisor);
			$("#salaryBackground").val(data.salary);
			
			$("#descriptionBackground").val(data.description);
			
			$("#applyDateStr").val(data.applyDateStr);
		}
		
		//Update function
		function updated(button){
			if ($('#experiencesForm').valid()) {
				var id = $(button).data("id");
				var toDate = $("#toWorkYear").val();
				var employerName = $("#emp").val();
				var address = $("#addressBackground").val();

				var typeOfBusiness = $("#business").val();
				var positionOfEmployer = $("#positionBackground").val();
				var reason = $("#reasonLeaving").val();
				var supervisor = $("#supervisorBackground").val();
				var salary = $("#salaryBackground").val();
				
				var description = $("#descriptionBackground").val();
				
				var applyDateStr = $("#applyDateStr").val();
				
				var json = {
						"id" : id,
						"position" : position,
						"employerName" : employerName,
						"address" : address,
						"typeOfBusiness" : typeOfBusiness,
						"positionOfEmployer" : positionOfEmployer,
						"reason" : reason,
						"supervisor" : supervisor,
						"salary" : salary,
						"description" : description,
						"applyDateStr" : applyDateStr
						};
				
				$.ajax({
					url : "updateExperience/"+id,
					type : "POST",
					contentType :"application/json; charset=utf-8",
					data : JSON.stringify(json),
					success : function(data){
						$('#experiencesModal').modal('hide');
						
						var table = $('#experiencesTable').DataTable();	
					 	var rowData = table.row(button.closest('tr')).index(); 
					 	var d = table.row(rowData).data();
					 	
						d.position = data.position;
// 						d.fromDate = data.fromDate;
// 						d.toDate = data.toDate;
						d.employerName = data.employerName;
						d.address = data.address;
						d.fromDate = data.fromDate;
						d.typeOfBusiness = data.typeOfBusiness;
						d.positionOfEmployer = data.positionOfEmployer;
						d.reason = data.reason;
						d.supervisor = data.supervisor;
						d.salary = data.salary;
						d.description = data.description;
						d.applyDateStr = data.applyDateStr;
					 	
				 		table.row(rowData).data(d).draw();
				 		
						new PNotify({
						    title: 'Edit Reference Success!!',
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
	        var dtApplicant = $('#experiencesTable').DataTable();
	        var id = $(button).data("id");
	        var index = dtApplicant.row(button.closest("tr")).index();
	        $.ajax({
	            url: "deleteExperience/" + id,
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

	    $('#experiencesModal').on('shown.bs.modal', function (e) {
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
					$('#experiencesForm')[0].reset();
					$('#btn_save').off('click').on('click', function(id){
						saveExperience();
					});
				}

			}
	   });

	});