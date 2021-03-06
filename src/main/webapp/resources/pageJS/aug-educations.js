$(document).ready(function() {
	
		$('#startDate').datepicker({
			startView : 2,
			todayBtn : "linked",
			format : "dd-mm-yyyy",
			autoclose: true
		});
		
		$('#graduate').datepicker({
				startView : 2,
				todayBtn : "linked",
				format : "dd-mm-yyyy",
				autoclose: true
		});
	
		$(document).on("focusin", ".datepicker_readonly", function(event) {
			$(this).prop('readonly', true);
		});

		$(document).on("focusout", ".datepicker_readonly", function(event) {
		    $(this).prop('readonly', false);
		});
		
		
		var $validateEdu = $('#educationsForm').validate({
			rules : {
				university : {required : true},
				masdegreetype : {required : true},
				faculty : {required : true},
				major : {required : true},
				gpa : {required : true},
				startDate : {required : true},
				graduate : {required : true}
			},
			messages : {
				university : {required : valUniversity},
				masdegreetype : {required : valDegree},
				faculty : {required : valFaculty},
				major : {required : valMajor},
				gpa : {required : valGPA},
				startDate : {required : valStart},
				graduate : {required : valYear}
			},
			errorPlacement: function(error, element) {
		        error.appendTo( element.parent("div").closest('.form-group'));
		    }
		});

		var dtApplicant;
		
		if(dtApplicant){
			dtApplicant.ajax.reload();
		}else{
			dtApplicant = $('#educationTable').DataTable({
				paging: true,
				hover:false,
				sort:false,
				ajax : {
					url : contextPath + '/findByIdEducation/'+ id,
					type : 'POST'
				},

				columns : [ {data : "university"},
				            {data : "masdegreetype"}, 
				            {data : "faculty"}, 
				            {data : "major"},
				            {data : "gpa"},
				            {data : "start_date"},
				            {data : "graduated_date"},
				            {data : function(data) {
								return '<button id="buttonEdit" data-id="'+data.id+'" data-toggle="modal" data-target="#educationModal" class="btn btn-warning btn-mini"><span class="glyphicon glyphicon-pencil"></span> '+ valEdit +'</button>';
							}},
							{data : function(data) {
								return '<button id="buttonDelete" data-id="'+data.id+'" data-toggle="modal" data-target="#deleteModal" class="btn btn-danger btn-mini"><span class="glyphicon glyphicon-remove-sign"></span> '+ valDelete +'</button>';
							}}],
				language:{

							    url: datatablei18n

							  },
				searching : false

			});
		}

		$("#gpa").inputmask('Regex', {regex: "[0-3]\\.[0-9][0-9]?$|4\\.00$"});
		
		function saveEducation(){
				if ($('#educationsForm').valid()) {
				var university = $("#university").val();
				var degreeTypeId = $("#masdegreetype").val();
				var masdegreetype = $("#masdegreetype option:selected").text();
				var faculty = $("#faculty").val();
				var major = $("#major").val();
				var start_date = $('#startDate').val();
				var graduated_date = $("#graduate").val();
				var gpa = $("#gpa").val();
				console.log(id);
				console.log(start_date);
				console.log(graduated_date);
				
				var json = {
						"applicant" : {"id" : id},
						"university" : university,
						"masdegreetype" : {"id" : degreeTypeId, "name" : $("#masdegreetype option:selected").text()},
						"faculty" : faculty,
						"major" : major,
						"start_date" : start_date,
						"graduated_date" : graduated_date,
						"gpa" : gpa,
						};
				
	 			$.ajax({
					contentType : "application/json",
					type : "POST",
					url : contextPath + '/educations/' + id,
					data : JSON.stringify(json),
					success : function(data) {
						$('#educationModal').modal('hide');
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
			console.log(id);
			$.ajax({
				url : contextPath + "/findEducationId/" + id,
				type : "POST",
				success : function(data){
					console.log(data.schoolName);
					showFillData(data);
				}
			});
		}
		
 		//Show data on inputField
		function showFillData(data){
			$("#university").val(data.university);
			$("#masdegreetype").val(data.masdegreetypeId);
			$("#faculty").val(data.faculty);
			$("#major").val(data.major);
			$("#startDate").val(data.start_date);
			$("#graduate").val(data.graduated_date);
			$("#gpa").val(data.gpa);
		}
		
		//Update function
		function updated(button){
			if ($('#educationsForm').valid()) {
			var id = $(button).data("id");
			var university = $("#university").val();
			var degreeTypeId = $("#masdegreetype").val();
			var masdegreetype = $("#masdegreetype option:selected").text();
			var faculty = $("#faculty").val();
			var major = $("#major").val();
			var start_date = $("#startDate").val();
			var graduated_date = $("#graduate").val();
			var gpa = $("#gpa").val();
			console.log(id);
			console.log(start_date);
			console.log(graduated_date);
			
			var json = {
					"id" : id,
					"university" : university,
					"masdegreetypeId" : degreeTypeId,
					"masdegreetype" : $("#masdegreetype option:selected").text(),
					"faculty" : faculty,
					"major" : major,
					"start_date" : start_date,
					"graduated_date" : graduated_date,
					"gpa" : gpa,
					};
			
			$.ajax({
				url : contextPath + "/updateEducations/"+id,
				type : "POST",
				contentType :"application/json; charset=utf-8",
				data : JSON.stringify(json),
				success : function(data){
					$('#educationModal').modal('hide');
					
					var table = $('#educationTable').DataTable();	
				 	var rowData = table.row(button.closest('tr')).index(); 
				 	var d = table.row(rowData).data();
				 		console.log(data.houseNo);

				 		d.university = data.university;
				 		d.masdegreetype = data.masdegreetype;
						d.faculty = data.faculty;
				 		d.major = data.major;
				 		d.start_date = data.start_date;
				 		d.graduated_date = data.graduated_date;
				 		d.gpa = data.gpa;
				 		
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
	    
        //delete function 
        function deleted(button) {
            var dtApplicant = $('#educationTable').DataTable();
            var id = $(button).data("id");
            var index = dtApplicant.row(button.closest("tr")).index();
            $.ajax({
                url: contextPath + "/deleteEducation/" + id,
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
        
        $('#educationModal').on('hide.bs.modal', function (e) {
        	$validateEdu.resetForm();
        });
        
        
        $('#educationModal').on('shown.bs.modal', function (e) {
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
					$('#educationsForm')[0].reset();
					$('#btn_save').off('click').on('click', function(id){
						saveEducation();
					});
				}

			}
       });
});