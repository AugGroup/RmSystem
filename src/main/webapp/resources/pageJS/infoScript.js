//<script>
 	$(document).ready(function() {
 			$('.input-group.date').datepicker({
 							startView : 2,
 							todayBtn : "linked",
 							format : "dd/mm/yyyy",
 							autoclose: true
 						});
			
			 $("#tel").mask("(999) 999-9999");
			 $("#emergencyTel").mask("(999) 999-9999");
			 $("#cardId").mask("9999-9999-9999-9");
			 $("#imageMultipartFile").on("change", function(){
					        var files = !!this.files ? this.files : [];
					        if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support
					        if (/^image/.test( files[0].type)){ // only image file
					            var reader = new FileReader(); // instance of the FileReader
					            reader.readAsDataURL(files[0]); // read the local file
					            reader.onloadend = function(){ // set image data as background of div
					            	
					                $("#imagePreview").css("background-image", "url("+this.result+")");
			   	              }
					        }
					        
					    });
	//-------------------------------------------
				var $previousNo = $("#previousNo");
			
				if ($("#previousEmployersYes").prop("checked")) {
					$previousNo.hide();
	    		}
	   	 	 	if ($("#previousEmployersNo").prop("checked")) {
	   	 	 		$previousNo.show();
 				}
	   	 	
		    $("input:radio[name='previousEmployers']").click(function () {
		    	if(this.value === 'No' && this.checked){
		    		$previousNo.show();
		        }else{
		        	$previousNo.hide();
		        }
	        });
			
// 		    -----------------------------------------------
			 
			
			
			 $("#noticeNewspaper").click(function () {
				 var $newspaper = $("#newspaper");
			            if ($(this).is(":checked")) {
			            	$newspaper.show();
			            }else{
			            	$newspaper.hide();
			            }
			            	
			        });

				 $("#noticeMagazine").click(function () {
					 var $magazine = $("#magazine");  
					 if ($(this).is(":checked")) {
			            	$magazine.show();
			            }else{
			            	$magazine.hide();
			            }
			        });
			    
			    $("#noticeWebSite").click(function () {
					 var $webSite = $("#webSite");

			    	if ($(this).is(":checked")) {
		            	$webSite.show();
		            }else{
		            	$webSite.hide();
		            }
		        });
			    
			    $("#noticeFriend").click(function () {
					 var $friend = $("#friend");

			    	if ($(this).is(":checked")) {
		            	$friend.show();
		            }else{
		            	$friend.hide();
		            }
		        });
			    
			    $("#noticeOther").click(function () {
					 var $other = $("#other");

			    	if ($(this).is(":checked")) {
		            	$other.show();
		            }else{
		            	$other.hide();
		            }
		        });

// 			    ---------------------------------------
			var $nowEmployedKnow = $("#nowEmployedKnow");

				if ($("#nowEmployedYes").prop("checked")) {
					$nowEmployedKnow.show();
		    		}
		   	 	if ($("#nowEmployedNo").prop("checked")) {
		   	 		$nowEmployedKnow.hide();
	    			}
		   	 	
			    $("input:radio[name='nowEmployed']").click(function () {
			    	if(this.value === 'Yes' && this.checked){
			    		$nowEmployedKnow.show();
			        }else{
			        	$nowEmployedKnow.hide();
			        }
		        });
// 			    ---------------------------------------------
			    var $militaryNo = $("#militaryNo");		
				var $militaryYes = $("#militaryYes");
				
				if ($("#militaryStatusYes").prop("checked")) {
					$militaryYes.show();
					$militaryNo.hide();
	    		}
	   	 	 	if ($("#militaryStatusNo").prop("checked")) {
	   	 	 		$militaryYes.hide();
	   	 		$militaryNo.show();
 				}
	   	 	
		    $("input:radio[name='militaryStatus']").click(function () {
		    	if(this.value === 'Yes' && this.checked){
		    		$militaryYes.show();
		    		$militaryNo.hide();
		        }else{
		        	$militaryYes.hide();
					$militaryNo.show();

		        }
	        });

// 					-------------------------------------------
			var $drafted = $("#drafted");
			
			    if ($("#sexFemale").prop("checked")) {
			    	$drafted.hide();
			    }
			    if ($("#sexMale").prop("checked")) {
			    	$drafted.show();
		    	}
 			    $("input:radio[name='sex']").click(function(){  
			        if(this.value === 'Female' && this.checked){
			        	$drafted.hide();
			        }else{
			        	$drafted.show();
			        }
			    });

// 			---------------------------------
			var $married = $("#married");
 				if ($("#applicantStatusSingle").prop("checked")) {
 					$married.hide();
		    	}
		    	if ($("#applicantStatusMarried").prop("checked")) {
		    		$married.show();
	    		}
		   		if ($("#applicantStatusDivorced").prop("checked")) {
		   			$married.show();
	    		}
			 
		   		$("input:radio[name='applicantStatus']").click(function(){
		            if(this.value === 'Single' && this.checked){
		            	$married.hide();
			        } else {
			            $married.show();
			        }
				});
		   		
//		   	----------------------------------------
//		   		$(function() {       
//		   		    $("input:file[id=resume]").change(function() {
//		   		        $("#resumeFile").html( $(this).val() );
//		   		    });
//		   		});

//			if($("#resumeMultipartFile") != null){
//		   		function alert(){
//		   			new PNotify({
//				        title: 'Success',
//				        text: 'Successful Add User In Table!!!',
//				        type: 'success',
//				        nonblock: {
//				            nonblock: true,
//				            nonblock_opacity: .2
//				        }
//				    });		   		}
//		   	}
//		   	----------------------------------		   		
			 $('#informationApplicant').validate({
				
				rules : {firstNameTH : {required : true},
					lastNameTH : {required : true},
					nickNameTH : {required : true},
					firstNameEN : {required : true},
					lastNameEN : {required : true},
					nickNameEN : {required : true},
					tel : {required : true,},
					email : {required : true,email : true},
					birthDate : {required : true},
					placeBirth : {required : true},
					age : {required : true},
					religion : {required : true},
					nationality : {required : true},
					cardId : {required : true},
					cardIssuedOffice : {required : true},
					cardExpiryDate : {required : true},
					height : {required : true},
					weight : {required : true}, 
					sex : {required : true},
					applicantStatus : {required : true},
					numberOfChildren : {required : true},
					spouseName : {required : true},
					marriageCertificateNo : {required : true},
					issueOficeMarriage : {required : true},
					marriageAddress : {required : true},
					occupationMarriage : {required : true},
					militaryStatus : {required : true},
					militaryFromYear : {required : true},
					militarytoYear : {required : true},
					branchService : {required : true},
					militaryPlace : {required : true},
					militaryServiceNo : {required : true},
					militaryReason : {required : true},
					dateToBeDrafted : {required : true},
					previousEmployers : {required : true},
 					previousEmployersReason : {required : true},
 					emergencyName : {required : true},
 					emergencyTel : {required : true},
 					emergencyAddress : {required : true},
 					applyDate : {required : true}, 
 					department : {required : true},
 					positionFirstName : {required : true},
 					position2 : {required : true},
 					position3 : {required : true}, 
 					expectedSalary : {required : true},
 					nowEmployed : {required : true},
 					employedName : {required : true},
 					employedPosition : {required : true},
 					employedRelation : {required : true}
				},
				messages : {firstNameTH : {required : firstNameTH},
					lastNameTH : {required : lastNameTH},
					nickNameTH : {required : nickNameTH},
					firstNameEN : {required : firstNameEN},
					lastNameEN : {required : lastNameEN},
					nickNameEN : {required : nickNameEN},
					tel : {required : tel},
					email :{required: email,
					      email: emailFormat},
					birthDate : {required : birthDate},
					placeBirth : {required : placeBirth},
					age : {required : age},
					religion : {required : religion},
					nationality : {required : nationality},
					cardId : {required : cardId},
					cardIssuedOffice : {required : cardIssuedOffice},
					cardExpiryDate : {required : cardExpiryDate},
					height : {required : height},
					weight : {required : weight},
					sex : {required : sex},
					applicantStatus : {required : applicantStatus},
					numberOfChildren : {required : numberOfChildren},
					spouseName : {required : spouseName},
					marriageCertificateNo : {required : marriageCertificateNo},
					issueOficeMarriage : {required : issueOficeMarriage},
					marriageAddress : {required : marriageAddress},
					occupationMarriage : {required : occupationMarriage},
					militaryStatus : {required : militaryStatus},
					militaryFromYear : {required : militaryFromYear},
					militarytoYear : {required : militarytoYear},
					branchService : {required : branchService},
					militaryPlace : {required : militaryPlace},
					militaryServiceNo : {required : militaryServiceNo},
					militaryReason : {required : militaryReason},
					dateToBeDrafted : {required : dateToBeDrafted},
					emergencyName : {required : emergencyName},
					emergencyTel : {required : emergencyTel},
					emergencyAddress : {required : emergencyAddress},
					applyDate : {required : applyDate},
					department : {required : department},
					position1 : {required : position1},
					position2 : {required : position2},
					position3 : {required : position3},
					expectedSalary : {required : expectedSalary},
					nowEmployed : {required : nowEmployed},
					employedName : {required : employedName},
					employedPosition : {required : employedPosition},
					employedRelation : {required : employedRelation},
					previousEmployers : {required :  previousEmployers},
 					previousEmployersReason : {required :  previousEmployersReason}
				}

			});

});

//</script>