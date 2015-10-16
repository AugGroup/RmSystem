$(document).ready(function() {
		var dtApplicant;
		
	    $('input[name="applyDateStr"]').daterangepicker({
	        format: 'DD-MM-YYYY',
	        opens : "left",
	        showDropdowns : true,
	    });
		
		$('.input-group.date').datepicker({
			startView : 2,
			todayBtn : "linked",
			format : "dd-mm-yyyy",
			autoclose: true 
	});
		
	$(document).on("focusin", "#applyDateStr", function(event) {
		  $(this).prop('readonly', true);
	});
	$(document).on("focusout", "#applyDateStr", function(event) {
		  $(this).prop('readonly', false);
	});
		
 	var $validateExp = $('#experiencesForm').validate({
		rules : {
			workBackground : {required : true,},
			applyDateStr : {required : true},
			companyName : {required : true,},
			address : {required : true,},
			typeOfBusiness : {required : true,},
			position : {required : true,},
			reference : {required : true,},
			salary : {required : true, digits:true},
//			reference : {required : true},
			responsibility : {required : true,},
			reason : {required : true,}
		},
		messages : {
			workBackground : {required : valWorkBackground},
			applyDateStr : {required : valFromYear},
			companyName : {required : valEmp},
			address : {required : valAddress},
			typeOfBusiness : {required : valType},
			position : {required : valPosition},
			reference : {required : valSupervisor},
			salary : {required : valSalary, digits:digitOnly},
//			reference : {required : valReference},
			responsibility : {required : valDescription},
			reason : {required : valReason}
		},
		errorPlacement: function(error, element) {
	        error.appendTo( element.parent("div").closest('.form-group'));
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
				url : contextPath + '/findByIdExperience/' + id,
				type : 'POST'
			},
			columns : [ {data : "position"},
			            {data : "companyName"},
			            {data : "address"},
			            {data : "typeOfBusiness"},
			            {data : "reference"},
			            {data : "salary"},
			            {data : "dateFrom"},
			            {data : "dateTo"},
			            {data : function(data) {
				 			return '<button id="buttonEdit" data-id="'+data.id+'" data-toggle="modal" data-target="#experiencesModal" class="btn btn-warning btn-mini"><span class="glyphicon glyphicon-pencil"></span> '+ valEdit +'</button>';
						}},
						{data : function(data) {
				 			return '<button id="buttonDelete" data-id="'+data.id+'" data-toggle="modal" data-target="#deleteModal" class="btn btn-danger btn-mini"><span class="glyphicon glyphicon-remove-sign"></span> '+ valDelete +'</button>';
						}}],
			searching : false,
			language:{

				    url: datatablei18n

				  },	

		});
	
	}
		
	function saveExperience(){
		var temp = $("#applyDateStr").val().toString();
//		alert(temp);
		var dateSplit =  temp.split("-");
//		var dateSplit =  $('input[name="applyDateStr"]').split("-");
		if ($('#experiencesForm').valid()) {
		var position = $("#position").val();
		var companyName = $("#companyName").val();
		var address = $("#address").val();
		var typeOfBusiness = $("#typeOfBusiness").val();
		var reference = $("#reference").val();
		var reason = $("#reason").val();
		var salary = $("#salary").val();
		var responsibility = $("#responsibility").val();
//		var dateFrom = dateSplit[0];
//		var dateTo = dateSplit[1];
		var dateFrom = dateSplit[0]+"-"+dateSplit[1]+"-"+dateSplit[2];
		var dateTo = dateSplit[3]+"-"+dateSplit[4]+"-"+dateSplit[5];
		
		var json = {
				"applicant" : {"id" : id},
				"position" : position,
				"companyName" : companyName,
				"address" : address,
				"typeOfBusiness" : typeOfBusiness,
				"reference" : reference,
				"reason" : reason,
				"salary" : salary,
				"responsibility" : responsibility,
				"dateFrom" : dateFrom,
				"dateTo" : dateTo
				};
		
		$.ajax({
			contentType : "application/json",
			type : "POST",
			url : contextPath + '/experiences/' +id,
			data : JSON.stringify(json),
			success : function(data) {
				$('#experiencesModal').modal('hide');
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
		
		//Find by Id
		function findById(id){
			$.ajax({
				url : contextPath + "/findExperienceId/" + id,
				type : "POST",
				success : function(data){
					showFillData(data);
				}
			});
		}
		
		//Show data on inputField
		function showFillData(data){
			$("#position").val(data.position);
			$("#companyName").val(data.companyName);
			$("#address").val(data.address);
			$("#typeOfBusiness").val(data.typeOfBusiness);
			$("#reference").val(data.reference);
			$("#salary").val(data.salary);
			$("#responsibility").val(data.responsibility);
			$("#reason").val(data.reason);
			$("#applyDateStr").val(data.dateFrom+" - "+data.dateTo);
		}
		
		//Update function
		function updated(button){
			if ($('#experiencesForm').valid()) {
//				alert($("#applyDateStr"));
				var temp = $("#applyDateStr").val().toString();
//				alert(temp);
				var dateSplit =  temp.split("-");
				var id = $(button).data("id");
				var applicantId = $("#applicant").val();
				var position = $("#position").val();
				var companyName = $("#companyName").val();
				var address = $("#address").val();
				var typeOfBusiness = $("#typeOfBusiness").val();
				var reference = $("#reference").val();
				var salary = $("#salary").val();
				var responsibility = $("#responsibility").val();
				var reason = $("#reason").val();
				var dateFrom = dateSplit[0]+"-"+dateSplit[1]+"-"+dateSplit[2];
				var dateTo = dateSplit[3]+"-"+dateSplit[4]+"-"+dateSplit[5];
				
				var json = {
						applicant : {"id" : applicantId},
						"id" : id,
						"position" : position,
						"companyName" : companyName,
						"address" : address,
						"typeOfBusiness" : typeOfBusiness,
						"reference" : reference,
						"salary" : salary,
						"responsibility" : responsibility,
						"reason" : reason,
						"dateFrom" : dateFrom,
						"dateTo" : dateTo
						};
				
				$.ajax({
					url : contextPath + "/updateExperience/"+id,
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
						d.companyName = data.companyName;
						d.address = data.address;
//						d.fromDate = data.fromDate;
						d.typeOfBusiness = data.typeOfBusiness;
						d.reference = data.reference;
						d.salary = data.salary;
						d.responsibility = data.responsibility;
						d.reason = data.reason;
						d.dateFrom = data.dateFrom;
						d.dateTo = data.dateTo;
					 	
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
	        var dtApplicant = $('#experiencesTable').DataTable();
	        var id = $(button).data("id");
	        var index = dtApplicant.row(button.closest("tr")).index();
	        $.ajax({
	            url: contextPath + "/deleteExperience/" + id,
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

	    $('#experiencesModal').on('hide.bs.modal', function (e) {
	    	$validateExp.resetForm();
	    })
	    
	    
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