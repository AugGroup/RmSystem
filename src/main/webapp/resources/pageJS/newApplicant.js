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
		   		
			 $('#informationApplicant').validate({
				
				rules : {
					firstNameEN : {required : true,lettersonly: true},
					lastNameEN : {required : true,lettersonly: true},
					email : {required : true, email : true},
 					applyDate : {required : true},
 					"joblevel.id" : {required : true},
 					"technology.id" : {required : true}//,
				},
				messages : {
					firstNameEN : {required : firstNameEN,lettersonly: lettersOnly},
					lastNameEN : {required : lastNameEN,lettersonly: lettersOnly},
					email :{required: email,
					      email: emailFormat},
					applyDate : {required : applyDate},
					"joblevel.id" : {required : joblevelVal},
					"technology.id" : {required : technologyVal}//,
				}
//				},
//				errorReplacement : function (error,element){
//					//error.insertAfter(closest("div.form-group"));
//					if(element.attr("name") === resumeMultipartFile){
//						error.appendTo($("label.resume"))
//					}
//					
//				}

			});

			 //---------------------check tech---------------------
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