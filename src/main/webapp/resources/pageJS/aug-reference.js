$(document).ready(function() {
		
		var $validateRef = $('#referenceForm').validate({
			rules : {
				name : {required : true},
				address : {required : true,},
				telNo : {required : true,},
				occupationRef : {required : true,}
			},
			messages : {
				name : {required : valName},
				address : {required : valAddress},
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
					url : contextPath + '/findByIdReference/'+id,
					type : 'POST'
				},
				columns : [ 
				    {data : "name"}, 
					{data : "tel"}, 
					{data : "occupation"},
					{data : "address"},
					{data : function(data) {
						return '<button id="buttonEdit" data-type="edit" data-id="'+data.id+'" data-toggle="modal" data-target="#referenceModal" class="btn btn-warning btn-mini"><span class="glyphicon glyphicon-pencil"></span>'+ valEdit +'</button>';
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
		
		$("#telNo").mask("(999) 999-9999");

		function saveReference(){
			if ($('#referenceForm').valid()) {
			var name = $("#name").val();
			var address = $("#address").val();
			var tel= $("#telNo").val();
			var occupation = $("#occupationRef").val();
			
			var json = {
					"applicant" : {"id" : id},
					"name" : name,
					"address" : address,
					"tel" : tel,
					"occupation" : occupation,
					};
	
	 		$.ajax({
				contentType : "application/json",
				type : "POST",
				url : contextPath + '/references/'+id,
				data : JSON.stringify(json),
				success : function(data) {
					$('#referenceModal').modal('hide');
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
				url : contextPath + "/findReferenceId/" + id,
				type : "POST",
				success : function(data){
					showFillData(data);
				}
			});
		}
		
		//Show data on inputField
		function showFillData(data){
			$("#referenceId").val(data.id);
			$("#name").val(data.name);
			$("#address").val(data.address);
			$("#telNo").val(data.tel);
			$("#occupationRef").val(data.occupation);
	 	}
		
		//Update function
		function updated(button){
			if ($('#referenceForm').valid()) {
			var id = $(button).data("id");
			var referenceId = $("#referenceId").val();
			var name = $("#name").val();
			var address = $("#address").val();
			var tel= $("#telNo").val();
			var occupation = $("#occupationRef").val();
			
			var json = {
//					"applicant" : {"id" : id},
					"id" : id,
					"name" : name,
					"address" : address,
					"tel" : tel,
					"occupation" : occupation,
					};
			
			$.ajax({
				url : contextPath + "/updateReferences/"+id,
				type : "POST",
				contentType :"application/json; charset=utf-8",
				data : JSON.stringify(json),
				success : function(data){
					$('#referenceModal').modal('hide');
					
					var table = $('#referenceTable').DataTable();	
				 	var rowData = table.row(button.closest('tr')).index(); 
				 	var d = table.row(rowData).data();
			 		d.name = data.name;
			 		d.address = data.address;
			 		d.tel = data.tel;
			 		d.occupation = data.occupation;
			 		
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
	        var dtApplicant = $('#referenceTable').DataTable();
	        var id = $(button).data("id");
	        var index = dtApplicant.row(button.closest("tr")).index();
	        $.ajax({
	            url: contextPath + "/deleteReference/" + id,
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
	    
	    $('#referenceModal').on('hide.bs.modal', function (e) {
	    	$validateRef.resetForm();
	    })
	    
		
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