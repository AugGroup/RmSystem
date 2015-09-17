$(document).ready(function() {
	
	$('#languagesForm').validate({
		rules : {
			languages : {required : true},
			speaking : {required : true},
			understanding : {required : true},
			reading : {required : true},
			writing : {required : true}},
			
		messages : {
			languages : {required : valName},
			speaking : {required : valSpeak},
			understanding : {required : valUnderstand},
			reading : {required : valRead},
			writing : {required : valWrite}
			}
	});
	
	var dtApplicant;

	if(dtApplicant) {
		dtApplicant.ajax.reload();
	}
	else {
		dtApplicant = $('#languagesTable').DataTable({
			paging: true,
			hover:false,
			sort:false,
			ajax : {
				url : 'findByIdLanguages/' +id,
				type : 'POST'
			},
			columns : [ {data : "languagesName"},
			            {data : "speaking"},
			            {data : "reading"},
			            {data : "understanding"},
			            {data : "writing"},
			            {data : function(data) {
				 			return '<button id="buttonEdit" data-id="'+data.id+'" data-toggle="modal" data-target="#languagesModal" class="btn btn-warning btn-mini"><span class="glyphicon glyphicon-pencil"></span> '+ valEdit +' </button>';
						}},
						{data : function(data) {
							return '<button id="buttonDelete" data-id="'+data.id+'" data-toggle="modal" data-target="#deleteModal" class="btn btn-danger btn-mini"><span class="glyphicon glyphicon-remove-sign"></span>'+ valDelete +' </button>';
						}}],
			searching : false

		});

	}
	
	function saveLanguages(){
		if ($('#languagesForm').valid()) {
		var languagesName = $("#languages").val();
		var speaking = $('input[name="speaking"]:checked').val();
		var reading = $('input[name="reading"]:checked').val();
		var understanding = $('input[name="understanding"]:checked').val();
		var writing = $('input[name="writing"]:checked').val();
		
		var json = {
				"applicant" : {"id" : id},
				"languagesName" : languagesName,
				"speaking" : speaking,
				"reading" : reading,
				"understanding" : understanding,
				"writing" : writing
				};

 		$.ajax({
			contentType : "application/json",
			type : "POST",
			url : 'languages/'+id,
			data : JSON.stringify(json),
			success : function(data) {
				$('#languagesModal').modal('hide');
				dtApplicant.ajax.reload();
				
				new PNotify({
			        title: 'Success',
			        text: 'Successful Add Languages!!!',
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
	
	//Update 
	function findById(id){
		$.ajax({
			url : "findLanguagesId/" + id,
			type : "POST",
			success : function(data){
				showFillData(data);
			}
		});
	}
	
	//Show data on inputField
	function showFillData(data){
		$("#languages").val(data.languagesName);
		$("input[name=speaking]:radio[value=" + data.speaking +"]").prop('checked', true);
		$("input[name=reading]:radio[value=" + data.reading +"]").prop('checked', true);
		$("input[name=understanding]:radio[value=" + data.understanding +"]").prop('checked', true);
		$("input[name=writing]:radio[value=" + data.writing +"]").prop('checked', true);
 	}
	
	//Update function
	function updated(button){
		if ($('#languagesForm').valid()) {
		var id = $(button).data("id");
		var languagesName = $("#languages").val();
		var speaking = $('input[name="speaking"]:checked').val();
		var reading = $('input[name="reading"]:checked').val();
		var understanding = $('input[name="understanding"]:checked').val();
		var writing = $('input[name="writing"]:checked').val();
		
		var json = {
				"id" : id,
				"languagesName" : languagesName,
				"speaking" : speaking,
				"reading" : reading,
				"understanding" : understanding,
				"writing" : writing
				};
		
		$.ajax({
			url : "updateLanguages/"+id,
			type : "POST",
			contentType :"application/json; charset=utf-8",
			data : JSON.stringify(json),
			success : function(data){
				$('#languagesModal').modal('hide');
				
				var table = $('#languagesTable').DataTable();	
			 	var rowData = table.row(button.closest('tr')).index(); 
			 	var d = table.row(rowData).data();
			 	
			 		d.languagesName = data.languagesName;
			 		d.speaking = data.speaking;
			 		d.reading = data.reading;
			 		d.understanding = data.understanding;
			 		d.writing = data.writing;
			 		
			 		table.row(rowData).data(d).draw();
			 		
					new PNotify({
					    title: 'Edit Languages Success!!',
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
        var dtApplicant = $('#languagesTable').DataTable();
        var id = $(button).data("id");
        var index = dtApplicant.row(button.closest("tr")).index();
        $.ajax({
            url: "deleteLanguages/" + id,
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
    
    $('#languagesModal').on('shown.bs.modal', function (e) {
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
				$('#languagesForm')[0].reset();
				$('#btn_save').off('click').on('click', function(id){
					saveLanguages();
				});
			}

		}
   });

	
});