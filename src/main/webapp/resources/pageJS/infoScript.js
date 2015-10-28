//<script>
 	$(document).ready(function() {
 		new jQueryCollapse($("#collapse-show-hide-info"), {
		      open: function() {
		        this.slideDown(300);
		      
		       $("#infomation-arrow").removeClass("glyphicon glyphicon-menu-down");
		       $("#infomation-arrow").addClass("glyphicon glyphicon-menu-up"); 
		      },
		      close: function() {
		        this.slideUp(300);
		        
		        $("#infomation-arrow").removeClass("glyphicon glyphicon-menu-up"); 
		        $("#infomation-arrow").addClass("glyphicon glyphicon-menu-down");
		      }
		    });
		    
		    new jQueryCollapse($("#collapse-show-hide-general"), {
		        open: function() {
		          this.slideDown(300);
		          $("#general-arrow").removeClass("glyphicon glyphicon-menu-down");
		          $("#general-arrow").addClass("glyphicon glyphicon-menu-up"); 
		        },
		        close: function() {
		          this.slideUp(300);
		          $("#general-arrow").removeClass("glyphicon glyphicon-menu-up"); 
		          $("#general-arrow").addClass("glyphicon glyphicon-menu-down");
		        }
		      });
		    
		    new jQueryCollapse($("#collapse-show-hide-official"), {
		        open: function() {
		          this.slideDown(300);
		          $("#official-arrow").removeClass("glyphicon glyphicon-menu-down");
		          $("#official-arrow").addClass("glyphicon glyphicon-menu-up"); 
		        },
		        close: function() {
		          this.slideUp(300);
		          $("#official-arrow").removeClass("glyphicon glyphicon-menu-up"); 
		          $("#official-arrow").addClass("glyphicon glyphicon-menu-down");
		        }
		      });
		    
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
//			 ----------------------------------------------------
			 
			 
			 	$(document).on("focusin", ".datepicker_readonly", function(event) {

				  $(this).prop('readonly', true);

				});

				$(document).on("focusout", ".datepicker_readonly", function(event) {

				  $(this).prop('readonly', false);

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

// 					------------------------------------------- (sex&&militaryStatus)
			var $drafted = $("#drafted");
		    var $militaryNo = $("#militaryNo");	
			var $militaryYes = $("#militaryYes");
			$militaryYes.hide();
			$militaryNo.hide();

			
 			    $("input:radio[name='sex']").change(function(){  
			        if(this.value === 'Female'){
			        	if ($("#militaryStatusYes").prop("checked")) {
			        		$drafted.hide();
 					    	$militaryYes.show();
 					    	$militaryNo.hide();
			    		}else{
			    			$drafted.hide();
 					    	$militaryYes.show();
 					    	$militaryNo.hide();
			    		}
			   	 	 	
			        }else{
			        	if ($("#militaryStatusNo").prop("checked")) {
			        		$drafted.show();
 					    	$militaryYes.hide();
 					    	$militaryNo.show();
			    		}else{
			    			$drafted.show();
 					    	$militaryYes.show();
 					    	$militaryNo.hide();
			    		}
			        }
			    });
 			   $("#sexFemale").attr("checked");
 			   $("#militaryStatusNo").attr("checked");
 			   $("input:radio[name='militaryStatus']").change(function () {
 			    	if(this.value === 'Yes'){
 			    		if ($("#sexFemale").prop("checked")) {
 			    			$drafted.hide();
 					    	$militaryYes.show();
 					    	$militaryNo.hide();
 					    }else
 					    	{
 					    	$drafted.show();
 					    	$militaryYes.show();
 					    	$militaryNo.hide();
 					    	}
 			        }else{
 			        	if ($("#sexFemale").prop("checked")) {
 			        		$drafted.hide();
 	 			        	$militaryYes.hide();
 					    	$militaryNo.hide();
 					    }else
 					    	{
 					    	$drafted.show();
 					    	$militaryYes.hide();
 					    	$militaryNo.show();
 					    	}
 			        
 	
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
		   		
//		   	----------------------------------	
		   		jQuery.validator.addMethod("onlyThai", function(value, element) {
			   		  // allow any non-whitespace characters as the host part
			   		  return this.optional( element ) || /^[ก-๙]+$/.test( value );
			   		}, thaiOnly);
			   		
			   		
				 $('#informationApplicant').validate({
				rules : {firstNameTH : {required : true,onlyThai : true},
					lastNameTH : {required : true,onlyThai: true},
					nickNameTH : {required : true,onlyThai: true},
					firstNameEN : {required : true,lettersonly: true},
					lastNameEN : {required : true,lettersonly: true},
					nickNameEN : {required : true,lettersonly: true},
					tel : {required : true},
					email : {required : true, email : true},
					birthDate : {required : true},
					placeBirth : {required : true,lettersonly: true},
					age : {required : true, digits: true, minlength : 2, maxlength:3},
					religion : {required : true,lettersonly: true},
					nationality : {required : true,lettersonly: true},
					cardId : {required : true},
					cardIssuedOffice : {required : true},
					cardExpiryDate : {required : true},
					height : {required : true, digits : true, minlength : 2, maxlength:3 },
					weight : {required : true, digits : true, minlength : 2, maxlength:3 }, 
					sex : {required : true},
					applicantStatus : {required : true},
					numberOfChildren : {required : true, digits : true},
					spouseName : {required : true},
					marriageCertificateNo : {required : true},
					issueOficeMarriage : {required : true},
					marriageAddress : {required : true},
					occupationMarriage : {required : true},
					militaryStatus : {required : true},
					militaryFromYear : {required : true, digits : true},
					militarytoYear : {required : true, digits : true},
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
 					"joblevel.id" : {required : true},
 					"technology.id" : {required : true},
 					expectedSalary : {required : true, digits: true},
 					nowEmployed : {required : true},
 					employedName : {required : true,lettersonly: true},
 					employedPosition : {required : true,lettersonly: true},
 					employedRelation : {required : true,lettersonly: true},
 					resumeMultipartFile : {required : true},
 					imageMultipartFile : {required : true}
				},
				messages : {firstNameTH : {required : firstNameTH},
					lastNameTH : {required : lastNameTH},
					nickNameTH : {required : nickNameTH},
					firstNameEN : {required : firstNameEN,lettersonly: lettersOnly},
					lastNameEN : {required : lastNameEN,lettersonly: lettersOnly},
					nickNameEN : {required : nickNameEN,lettersonly: lettersOnly},
					tel : {required : tel},
					email :{required: email,
					      email: emailFormat},
					birthDate : {required : birthDate},
					placeBirth : {required : placeBirth},
					age : {required : age, digits : digitOnly, minlength:minDigitTwo, maxlength : maxDigitThree},
					religion : {required : religion},
					nationality : {required : nationality},
					cardId : {required : cardId},
					cardIssuedOffice : {required : cardIssuedOffice},
					cardExpiryDate : {required : cardExpiryDate},
					height : {required : height, digits : digitOnly, minlength:minDigitTwo, maxlength : maxDigitThree},
					weight : {required : weight, digits : digitOnly, minlength:minDigitTwo, maxlength : maxDigitThree},
					sex : {required : sex},
					applicantStatus : {required : applicantStatus},
					numberOfChildren : {required : numberOfChildren, digits : digitOnly},
					spouseName : {required : spouseName},
					marriageCertificateNo : {required : marriageCertificateNo},
					issueOficeMarriage : {required : issueOficeMarriage},
					marriageAddress : {required : marriageAddress},
					occupationMarriage : {required : occupationMarriage},
					militaryStatus : {required : militaryStatus},
					militaryFromYear : {required : militaryFromYear, digits : digitOnly},
					militarytoYear : {required : militarytoYear, digits : digitOnly},
					branchService : {required : branchService},
					militaryPlace : {required : militaryPlace},
					militaryServiceNo : {required : militaryServiceNo},
					militaryReason : {required : militaryReason},
					dateToBeDrafted : {required : dateToBeDrafted},
					emergencyName : {required : emergencyName},
					emergencyTel : {required : emergencyTel},
					emergencyAddress : {required : emergencyAddress},
					applyDate : {required : applyDate},
					"joblevel.id" : {required : joblevelVal},
					"technology.id" : {required : technologyVal},
					expectedSalary : {required : expectedSalary, digits : digitOnly},
					nowEmployed : {required : nowEmployed},
					employedName : {required : employedName},
					employedPosition : {required : employedPosition},
					employedRelation : {required : employedRelation},
					previousEmployers : {required :  previousEmployers},
 					previousEmployersReason : {required : previousEmployersReason},
 					resumeMultipartFile : {required : resumeMultipartFile},
					imageMultipartFile :{required : imageMultipartFile}
				}
			});
				
				 $("#tech").hide();
				 
				 $("#joblevel").on("change", function(){
					 
					 var jobSelect = $("#joblevel option:selected").text();
					 var find = false;
					 $(".tags").each(function(){
						 if( $(this).val() == jobSelect){
							 find = true;
							 $("#tech").show();
						 }else{
							 $("#technology option:selected").val("6");
							 $("#tech").hide();
						 }
						 
						 if (find == true) {
							 return false;
						 }
					 })
				 })
				 

});

//</script>