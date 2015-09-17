$(document).ready(function() {
	
	$('#skillForm').validate({
		rules : {
			skill : {required : true}
		},
		messages : {
			skill : {required : valSkill}
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
			columns : [ {
				data : "skillDetail"
			},{ data : function(data) {
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
		var skillDetail = $("#skill").val();
		var json = {
				"applicant" : {"id" : id},
				"skillDetail" : skillDetail,
				};
		
		$.ajax({
			url : "skills/"+id,
			type : "POST",
			contentType :"application/json; charset=utf-8",
			data : JSON.stringify(json),
			success : function(data){
				$('#skillModal').modal('hide');
				dtApplicant.ajax.reload();
				
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
		$("#skill").val(data.skillDetail);
 	}
	
	//Update function
	function updated(button){
		if ($('#skillForm').valid()) {
			var id = $(button).data("id");
			var skillDetail = $("#skill").val();
			var json = {
					"id" : id,
					"skillDetail" : skillDetail,
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
				 	
			 		d.skillDetail = data.skillDetail;
			 		
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