$(document).ready(function () {
	
	var $inputAddress = $('#inputAddress');
	var $houseNo = $("#houseNo");
	var $road = $("#road");
	var $district = $("#district");
	var $subDistrict = $("#subDistrict")
	var $zipcode = $("#zipcode");
	var $province = $('#province')
		
	$('#addressForm').validate({
		rules : {
			inputAddress : {required : true},
			houseNo : {required : true},
			road : {required : true},
			district : {required : true},
			subDistrict : {required : true},
			zipcode : {required : true},
			province : {required : true}
		},
		messages : {
			inputAddress : {required : valAddress},
			houseNo : {required : valHouseNo},
			road : {required : valRoad},
			district : {required : valDistrict},
			subDistrict : {required : valSubDistrict},
			province : {required : valProvince}
		}
	});
	
	$('.input-group.date').datepicker({
			startView : 2,
			todayBtn : "linked",
			format : "dd/mm/yyyy"

		});
		
		var dtApplicant;
		
		if(dtApplicant) {
			dtApplicant.ajax.reload();
		}
		else {
			dtApplicant = $('#addressTable').DataTable({
				paging: true,
				hover:false,
				sort:false,
				ajax : {
					url : 'findByIdAddress/'+id,
					type : 'POST'
				},
				columns : [ {data : "addressType"},
							{data : "houseNo"},
							{data : "road"},
							{data : "district"},
							{data : "subDistrict"},
							{data : "zipcode"},
							{data : "province"},
							{data : function(data) {
						 		return '<button id="buttonEdit" data-id="'+data.id+'" data-toggle="modal" data-target="#addressModal" class="btn btn-warning btn-mini"><span class="glyphicon glyphicon-pencil"></span> '+ valEdit +'</button>';
							}},
							{ data : function(data) {
						 		return '<button id="buttonDelete" data-id="'+data.id+'" data-toggle="modal" data-target="#deleteModal" class="btn btn-danger btn-mini"><span class="glyphicon glyphicon-remove-sign"></span> '+ valDelete +'</button>';
							}}],
				searching : false

			});
		}
		
		function saveAddress(){
			if($('#addressForm').valid()){
				var addressType = $inputAddress.val();
				var houseNo = $houseNo.val();
				var district = $district.val();
				var subDistrict = $subDistrict.val();
				var road = $road.val();
				var province = $province.val();
				var zipcode = $zipcode.val();
				var json = {"applicant" : {"id" : id},
							"addressType" : addressType,
							"houseNo" : houseNo,
							"district" : district,
							"subDistrict" : subDistrict,
							"road" : road,
							"province":province,
							"zipcode":zipcode};
			
				$.ajax({
					url : 'address/'+id,
					contentType : "application/json",
					type : "POST",
					data : JSON.stringify(json),
					success : function(data) {
						$('#addressModal').modal('hide');
						dtApplicant.ajax.reload();
						
						new PNotify({
					        title: 'Success',
					        text: 'Successful Add Education!!!',
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
				url : "findAddressId/" + id,
				type : "POST",
				success : function(data){
					showFillData(data);
				}
			});
		}
		
		//Show data on inputField
		function showFillData(data){
			$('#inputAddress').val(data.addressType);
			$("#houseNo").val(data.houseNo);
			$("#road").val(data.road);
			$("#district").val(data.district);
			$("#subDistrict").val(data.subDistrict);
			$("#zipcode").val(data.zipcode);
			console.log(data.houseNo);
			
			$("#province").val(data.province);
		}
		
		//Update function
		function updateAddress(button){
			if ($('#addressForm').valid()) {
			var id = $(button).data("id");
			var addressType = $('#inputAddress').val();
			var houseNo = $("#houseNo").val();
			var road = $('#road').val();
			var district = $("#district").val();
			var subDistrict = $("#subDistrict").val();
			var zipcode = $("#zipcode").val();
			var province = $("#province").val();
			console.log(id);
			
			var json = {
					"id" : id,
					"addressType" : addressType,
					"houseNo" : houseNo,
					"road" : road,
					"district" : district,
					"subDistrict" : subDistrict,
					"zipcode" : zipcode,
					"province" : province,
					};
			
			$.ajax({
				url : "updateAddress/"+id,
				type : "POST",
				contentType :"application/json; charset=utf-8",
				data : JSON.stringify(json),
				success : function(data){
					$('#addressModal').modal('hide');
					
					var table = $('#addressTable').DataTable();	
				 	var rowData = table.row(button.closest('tr')).index(); 
				 	var d = table.row(rowData).data();
				 		console.log(data.houseNo);

				 		d.addressType = data.addressType;
				 		d.houseNo = data.houseNo;
						d.road = data.road;
				 		d.district = data.district;
				 		d.subDistrict = data.subDistrict;
				 		d.zipcode = data.zipcode;
				 		d.province = data.province;
				 		
				 		table.row(rowData).data(d).draw();
				 		
						new PNotify({
						    title: 'Edit Success',
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
            if (id != null) {
                $('#btn_delete_submit').off('click').on('click', function () {
                    deleted(button);
                });
            }
        });
        
        //delete function 
        function deleted(button) {
            var dtApplicant = $('#addressTable').DataTable();
            var id = $(button).data("id");
            var index = dtApplicant.row(button.closest("tr")).index();
            $.ajax({
                url: "deleteAddress/" + id,
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
		
        $('#addressModal').off("click").on('shown.bs.modal', function (e) {
        	var button = e.relatedTarget;
			if(button != null){
				var id = $(button).data("id");
				if(id != null){
					console.log(id);
					findById(id);
					$('#btn_save').off('click').on('click', function(id){
						updateAddress(button);
					});
				}else{
					$('#addressForm')[0].reset();
					$('#btn_save').off('click').on('click', function(){
						saveAddress();
					});
				}

			}
       });
});