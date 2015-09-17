$(document).ready(function() {
		
		$('#referenceForm').validate({
			rules : {
				fullName : {required : true},
				completeAddress : {required : true,},
				telNo : {required : true,},
				occupationRef : {required : true,}
			},
			messages : {
				fullName : {required : valName},
				completeAddress : {required : valAddress},
				telNo : {required : valTel},
				occupationRef : {required : valOccupation}
			}
		});
		
		var dtApplicant;
		
		if(dtApplicant) {
			dtApplicant.ajax.reload();
		}
		else {
			dtApplicant = $('#referenceTable').DataTable({
				paging: true,
				hover:false,
				sort:false,
				ajax : {
					url : 'findByIdReference/'+id,
					type : 'POST'
				},
				columns : [ {
					data : "fullName"}, 
					{data : "tel"}, 
					{data : "occupation"},
					{data : "completeAddress"},
					{data : function(data) {
						return '<button id="buttonEdit" data-type="edit" data-id="'+data.id+'" data-toggle="modal" data-target="#referenceModal" class="btn btn-warning btn-mini"><span class="glyphicon glyphicon-pencil"></span>'+ valEdit +'</button>';
					}},
					{data : function(data) {
						return '<button id="buttonDelete" data-id="'+data.id+'" data-toggle="modal" data-target="#deleteModal" class="btn btn-danger btn-mini"><span class="glyphicon glyphicon-remove-sign"></span> '+ valDelete +'</button>';
					}}],
				searching : false

			});
		}
		
		$("#telNo").mask("(999) 999-9999");

		function saveReference(){
			if ($('#referenceForm').valid()) {
			var fullName = $("#fullName").val();
			var completeAddress = $("#completeAddress").val();
			var tel= $("#telNo").val();
			var occupation = $("#occupationRef").val();
			
			var json = {
					"applicant" : {"id" : id},
					"fullName" : fullName,
					"completeAddress" : completeAddress,
					"tel" : tel,
					"occupation" : occupation,
					};
	
	 		$.ajax({
				contentType : "application/json",
				type : "POST",
				url : 'references/'+id,
				data : JSON.stringify(json),
				success : function(data) {
					$('#referenceModal').modal('hide');
					dtApplicant.ajax.reload();
					
					new PNotify({
				        title: 'Success',
				        text: 'Successful Add References!!!',
				        type: 'success',
				        delay: 7000,
				        buttons:{
				        	closer_hover: false,
				        	sticker: false
				        }		
				    });
					
				
				}
			}); 
			};
		}
		
		//Update 
		function findById(id){
			$.ajax({
				url : "findReferenceId/" + id,
				type : "POST",
				success : function(data){
					showFillData(data);
				}
			});
		}
		
		//Show data on inputField
		function showFillData(data){
			$("#fullName").val(data.fullName);
			$("#completeAddress").val(data.completeAddress);
			$("#telNo").val(data.tel);
			$("#occupationRef").val(data.occupation);
	 	}
		
		//Update function
		function updated(button){
			if ($('#referenceForm').valid()) {
			var id = $(button).data("id");
			var fullName = $("#fullName").val();
			var completeAddress = $("#completeAddress").val();
			var tel= $("#telNo").val();
			var occupation = $("#occupationRef").val();
			
			var json = {
					"id" : id,
					"fullName" : fullName,
					"completeAddress" : completeAddress,
					"tel" : tel,
					"occupation" : occupation,
					};
			
			$.ajax({
				url : "updateReferences/"+id,
				type : "POST",
				contentType :"application/json; charset=utf-8",
				data : JSON.stringify(json),
				success : function(data){
					$('#referenceModal').modal('hide');
					
					var table = $('#referenceTable').DataTable();	
				 	var rowData = table.row(button.closest('tr')).index(); 
				 	var d = table.row(rowData).data();
			 		d.fullName = data.fullName;
			 		d.completeAddress = data.completeAddress;
			 		d.tel = data.tel;
			 		d.occupation = data.occupation;
			 		
			 		table.row(rowData).data(d).draw();
			 		
					new PNotify({
					    title: 'Edit Reference Success!!',
					    text: 'You can edit data',
					    type: 'success',
				        delay: 7000,
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
	        var dtApplicant = $('#referenceTable').DataTable();
	        var id = $(button).data("id");
	        var index = dtApplicant.row(button.closest("tr")).index();
	        $.ajax({
	            url: "deleteReference/" + id,
	            type: "POST",
	            success: function () {
	            	dtApplicant.row(index).remove().draw();
					new PNotify({
					    title: 'Delete Success',
					    text: 'You can delete data',
					    type: 'success',
				        delay: 7000,
				        buttons:{
				        	closer_hover: false,
				        	sticker: false
				        }		
					});
	            }
	        });
	    }
		
	    $('#referenceModal').on('shown.bs.modal', function (e) {
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
					$('#referenceForm')[0].reset();
					$('#btn_save').off('click').on('click', function(id){
						saveReference();
					});
				}
			}
	   });
	});