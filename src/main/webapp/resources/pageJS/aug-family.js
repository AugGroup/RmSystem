$(document).ready(function() {
		
		$('#familyForm').validate({
			rules : {
				nameFamily : {required : true},
				relationFamily : {required : true},
				occupationFamily : {required : true},
				addressFamily : {required : true},
				telNo : {required : true},
				occupation : {required : true},
				positionFamily : {required : true},
				age : {required : true},
				gender : {required : true}
			},
			messages : {
				nameFamily : {required : valName},
				relationFamily : {required : valRelation},
				occupationFamily : {required : valOccupationFamily},
				addressFamily : {required : valAddress},
				telNo : {required : valTel},
				occupation : {required : valOccupation},
				positionFamily : {required : valPositionFamily},
				age : {required : valAgeFamily},
				gender : {required : valSexFamily},
			}
		});
		
		$("#telNo").mask("(999) 999-9999");
		
		var dtApplicant;
		
		if(dtApplicant) {
			dtApplicant.ajax.reload();
		}else {
			dtApplicant = $('#familyTable').DataTable({
				paging: true,
				hover:false,
				sort:false,
				ajax : {
					url : contextPath + '/findByIdFamily/'+id,
					type : 'POST',
					dataSrc : ""
				},
				columns : [ {data : "familyName"},
							{data : "masRelationTypeName"},
							{data : "occupation"},
							{data : "address"},
							{data : "mobile"},
							{data : "age"},
							{data : "gender"},
							{data : "position"},
							{data : function(data) {
					 			return '<button id="buttonEdit" data-id="'+data.id+'" data-toggle="modal" data-target="#familyModal" class="btn btn-warning btn-mini"><span class="glyphicon glyphicon-pencil"></span> '+ valEdit +'</button>';
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
			
		function saveFamily(){
			if ($('#familyForm').valid()) {
				var name = $("#nameFamily").val();
				var relationId = $('#relationFamily').val();
				var relation = $('#relationFamily option:selected').text();
				var occupation = $("#occupationFamily").val();
				var address = $("#addressFamily").val();
				var tel = $('#telNo').val();
				var age = $('#age').val();
				var gender = $('#gender').val();
				var position = $("#positionFamily").val();
				
				var json = {"applicant" : {"id" : id},
						"familyName" : name,
						"masRelationType" : {"id" : relationId},
						"occupation" : occupation,
						"address" : address,
						"mobile" : tel,
						"age" : age,
						"gender": gender,
						"position" : position,
						};
				$.ajax({
					contentType : "application/json; charset=utf-8",
					type : "POST",
					url : contextPath + '/family/'+id,
					data : JSON.stringify(json),
					success : function(data) {
						$('#familyModal').modal('hide');
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
		
		//Update 
		function findById(id){
			$.ajax({
				url : contextPath + "/findFamilyId/" + id,
				type : "POST",
				success : function(data){
					showFillData(data);
				}
			});
		}
		
		//Show data on inputField
		function showFillData(data){
			$("#familyId").val(data.id);
			$("#nameFamily").val(data.familyName);
			$("#relationFamily").val(data.masRelationTypeId);
			$("#occupationFamily").val(data.occupation);
			$("#addressFamily").val(data.address);
			$("#telNo").val(data.mobile);
			$("#age").val(data.age);
			$("#gender").val(data.gender);
			$("#positionFamily").val(data.position);
	 	}
		
		//Update function
		function updated(button){
			if ($('#familyForm').valid()) {
			var id = $(button).data("id");
			var applicantId = $("#applicant").val();
			var name = $("#nameFamily").val();
			var relationId = $('#relationFamily').val();
			var relation = $('#relationFamily option:selected').text();
			var occupation = $("#occupationFamily").val();
			var address = $("#addressFamily").val();
			var tel = $('#telNo').val();
			var age = $('#age').val();
			var gender = $('#gender').val();
			var positionFamily = $("#positionFamily").val();
			
			var json = {
					applicant : {"id" : applicantId},
					"id" : id,
					"familyName" : name,
					"masRelationTypeId" : relationId,
					"masRelationTypeName" : $('#relationFamily option:selected').text(),
					"occupation" : occupation,
					"address" : address,
					"mobile" : tel,
					"age" : age,
					"gender": gender,
					"position" : positionFamily,
					};
			
			$.ajax({
				url : contextPath + "/updateFamily/"+id,
				type : "POST",
				contentType :"application/json; charset=utf-8",
				data : JSON.stringify(json),
				success : function(data){
					$('#familyModal').modal('hide');
					
					var table = $('#familyTable').DataTable();	
				 	var rowData = table.row(button.closest('tr')).index(); 
				 	var d = table.row(rowData).data();
				 	
					d.familyName = data.familyName,
					d.masRelationTypeName = data.masRelationTypeName,
					d.occupation = data.occupation,
					d.address = data.address,
					d.mobile = data.mobile,
					d.age = data.age,
					d.gender = data.gender,
					d.position = data.position,
				 	
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
	        var dtApplicant = $('#familyTable').DataTable();
	        var id = $(button).data("id");
	        var index = dtApplicant.row(button.closest("tr")).index();
	        $.ajax({
	            url: contextPath + "/deleteFamily/" + id,
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
		
	    $('#familyModal').on('shown.bs.modal', function (e) {
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
					$('#familyForm')[0].reset();
					$('#btn_save').off('click').on('click', function(){
						saveFamily();
					});
				}

			}
	   });

	});