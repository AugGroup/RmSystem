$(document).ready(function() {
	
	$('#skillForm').validate({
		rules : {
			skill : {required : true},
			rank : {required: true}
		},
		messages : {
			skill : {required : valSkill},
			rank : {required: valRank}
		}
	});
	
	if(dtApplicant) {
		dtApplicant.ajax.reload();
	}
	else {
		dtApplicant = $('#skillTable').DataTable({
			paging: true,
			hover:false,
			sort:false,
			ajax : {
				url : 'findByIdSkill/'+id,
				type : 'POST'
			},
			columns : [ {data : "masspecialty"},
			            {data: "rank"},
			{ data : function(data) {
				 return '<button id="buttonEdit" data-id="'+data.id+'" data-toggle="modal" data-target="#skillModal" class="btn btn-warning btn-mini"><span class="glyphicon glyphicon-pencil"></span> '+ valEdit +'</button>';
			}
			},{ data : function(data) {
				 return '<button id="buttonDelete" data-id="'+data.id+'" data-toggle="modal" data-target="#deleteModal" class="btn btn-danger btn-mini"><span class="glyphicon glyphicon-remove-sign"></span> '+ valDelete +'</button>';
			}
		}],
			searching : false

		});
	}
	
	var dtApplicant;
	
	function saveSkill(){
		if ($('#skillForm').valid()) {
			var masspecialty = $("#masspecialty").val();
			var masspecialtyId = $("#masspecialty").val();
			
			var rank = $('input:radio[name=rank]:checked').val();
			var json = {
				applicant : {"id" : id},
				masspecialty : {"id": masspecialtyId, "name": $("#masspecialty option:selected").text()},
				rank : rank
			};
			
			$.ajax({
				url : "skills/"+id,
				type : "POST",
				contentType :"application/json; charset=utf-8",
				data : JSON.stringify(json),
				success : function(data){
					
					if(data == "success") {
						$("#special-error").empty();
						$('#skillModal').modal('hide');
						dtApplicant.ajax.reload();
						
						new PNotify({
						    title: 'Add Skill Success!!',
						    text: 'You can edit data',
						    type: 'success',
					        delay: 7000,
					        buttons:{
					        	closer_hover: false,
					        	sticker: false
					        }		
						});
						//alert("can't save");
						
					} else {
						$("#special-error").empty().append("duplicate special");
					}
				}
			});
		console.log(json);
		};
	}

	//Update 
	function findById(id){
		$.ajax({
			url : "findSkillId/" + id,
			type : "POST",
			success : function(data){
				console.log(id);
				showFillData(data);
			}
		});
	}
	
	//Show data on inputField
	function showFillData(data){
        $('#applicant').val(data.applicantId);
		$("#skillsId").val(data.id);
		$("#masspecialty").val(data.masspecialtyId);
		$("input[name=rank]:radio[value=" + data.rank +"]").prop('checked', true);
	}
	
	//Update function
	function updated(button){
		if ($('#skillForm').valid()) {
			var id = $(button).data("id");
			var applicantId = $("#applicant").val();
			var masspecialty = $("#masspecialty").val();
			var rank = $('input:radio[name=rank]:checked').val();
			var json = {
					applicant : {"id" : applicantId},
					id : id,
					masspecialtyId : $("#masspecialty").val(), 
					masspecialty : $("#masspecialty option:selected").text(),
					rank : rank
					};
			
			$.ajax({
				url : "updateSkills/"+id,
				type : "POST",
				contentType :"application/json; charset=utf-8",
				data : JSON.stringify(json),
				success : function(data){
					$('#skillModal').modal('hide');
					
					var table = $('#skillTable').DataTable();	
				 	var rowData = table.row(button.closest('tr')).index(); 
				 	var d = table.row(rowData).data();
				 	d.masspecialtyId = data.masspecialtyId;
			 		d.masspecialty = data.masspecialty;
			 		d.rank = data.rank;
			 		table.row(rowData).data(d).draw();
			 		
					new PNotify({
					    title: 'Edit Skill Success!!',
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
        var dtApplicant = $('#skillTable').DataTable();
        var id = $(button).data("id");
        var index = dtApplicant.row(button.closest("tr")).index();
        $.ajax({
            url: "deleteSkill/" + id,
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
	
    $('#skillModal').on('shown.bs.modal', function (e) {
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
				$('#skillForm')[0].reset();
				$('#btn_save').off('click').on('click', function(id){
					saveSkill();
				});
			}

		}
   });
	
});