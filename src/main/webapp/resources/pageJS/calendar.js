var id;
var eventdata;
var insTitle;
var insStart;
var insEnd;
var type;
var dateStart;
var dateEnd;
var $applicantName = $('#applicantName');

var $validform = $("#formInsert").validate({			
	rules:{
		appointmentTopic:{
			required:true,
			minlength:10,
		},
		appoint_detail:{
			required:true
		},
		 applicantName: {
			required:true
		}
	},
	
	messages: {
		appointmentTopic:{
			required: validateTopic,
			minlength: validateTopicLenght,
		},
		appoint_detail:{
			required: validateDatail
		},
		applicantName:{
			required: validateApplicant
		}
	},
	
 	invalidHandler: function(event, validator) {
		$('#appointmentTopic').focus();
	} 
	
});


var $validform2 = $("#formEdit").validate({			
	rules:{
		appointmentTopicEdt:{
			required:true,
			minlength:10,
		},
		appoint_detailEdt:{
			required:true
		}
		
	},
	
	messages: {
		appointmentTopicEdt:{
			required: validateTopic,
			minlength: validateTopicLenght,
		},
		appoint_detailEdt:{
			required: validateDatail
		}
		
	},
	
 	invalidHandler: function(event, validator) {
		$('#appointmentTopicEdt').focus();
	} 
	
});

function updateAppointmentDate(eventToUpdate, revertParam){
	var updatedata = {id : eventToUpdate.id, start : eventToUpdate.start, end : eventToUpdate.end, mailStatus : eventToUpdate.mailStatus};
	alertify.set({ 	buttonReverse: true,
					labels: {
					    ok     : yes,
					    cancel : no
					}
	});
	alertify.confirm(confirmEditAppointmentDate+" "+eventToUpdate.title, function (e) {
	    if (e) {
	    	$.ajax({
	    		url:"calendar/update",
	    		type: "POST",
	    		contentType : "application/json",
	    		data : JSON.stringify(updatedata),
	    		dataType : "json",
	    		success: function(result){
	    			new PNotify({
	    			    title: result.title +"<br>" + pnotifyEdit,
	    			    type: 'success',
	    			    delay: 750
	    			});
	    			var view = $('#calendar').fullCalendar('getView');//get view object
    				$('#calendar').fullCalendar( 'destroy' );
	    			renderCalendar();
    				$('#calendar').fullCalendar('changeView', view.name);
    				$('#calendar').fullCalendar( 'gotoDate', eventToUpdate.start );
    				findNoEmailUpdate();
    				findEmailSent();
	    		},
	    		
	    		error:function (jqXHR, textStatus, error){
	    	        alert('Update error'); 
	    	    }  
	    	});
	        // user clicked "ok"
	    } else {
	        // user clicked "cancel"
	    	revertParam();
	    }
	});
	
}
function currentDate(){// use For getCurrentDate
	var date = new Date();
	var month = date.getMonth()+1;
	var day = date.getDate();

	var output = date.getFullYear() + '-' +
	    (month<10 ? '0' : '') + month + '-' +
	    (day<10 ? '0' : '') + day;
	return output;
}
	
	
function setApplicant(trackingStatus){//set Applicant
	$.ajax({
		url : "calendar/findByTrackingStatus/" + trackingStatus,
		type : "GET",
		dataType : "json",
		success : function(data){
			$applicantName.empty().append('<option value="">'+selectApplicant+'</option>');
				$.each(data, function(i, item) {
				    var name = "<option value='" + data[i].id +  "'> " + data[i].firstNameEN +" " + data[i].lastNameEN +" ( " + data[i].technologyStr + " " + data[i].joblevelStr + "  )</option>"
				    $applicantName.append(name);
				})
			
			console.log(data);
		},
		error : function(error){
			alert("error");
			console.log(error);
		}
			
	});//end ajax
}
	

function setApplicantNameList(){//set Applicant
	var $penndingTestNameList = $("#pendingTestList div.list-group");
	var $penndingApproveNameList = $("#pendingApproveList div.list-group");
	$.ajax({
		url : "calendar/findByTrackingStatus/test",
		type : "GET",
		dataType : "json",
		success : function(data){
			$penndingTestNameList.empty();
			$.each(data, function(i, item) {
			    var getName = data[i].firstNameEN +" "+ data[i].lastNameEN +" ( " + data[i].technologyStr + " " + data[i].joblevelStr + "  )";
			    var $div = "<div data-id='"+data[i].id+"' role='button' "+
			    			"class='list-group-item applicant-list-item' >"+getName+"</div>";
			    $penndingTestNameList.append($div);
			})
		},
		error : function(error){
			alert("error");
			console.log(error);
		}
	});//end ajax
	
	$.ajax({
		url : "calendar/findByTrackingStatus/pendingapprove",
		type : "GET",
		dataType : "json",
		success : function(data){
			$penndingApproveNameList.empty();
			$.each(data, function(i, item) {
			    var getName = data[i].firstNameEN +" "+ data[i].lastNameEN +" ( " + data[i].technologyStr + " " + data[i].joblevelStr + "  )";
			    var $div = "<div data-id='"+data[i].id+"' role='button' "+
			    			"class='list-group-item applicant-list-item' >"+getName+"</div>";
			    $penndingApproveNameList.append($div);
			})
		},
		error : function(error){
			alert("error");
			console.log(error);
		}
	});//end ajax
}


function setApplicant(trackingStatus){
	$.ajax({
		url : "/RmSystem/calendar/findByTrackingStatus/" + trackingStatus,
		type : "GET",
		dataType : "json",
		success : function(data){
			$('#applicantName').empty().append('<option value="">'+selectApplicant+'</option>');
			
				$.each(data, function(i, item) {
				    var name = "<option value='" + data[i].id +  "'> " + data[i].firstNameEN +" " + data[i].lastNameEN +" ( " + data[i].technologyStr + " " + data[i].joblevelStr + "  )</option>"
				    $('#applicantName').append(name);
				})
			//console.log(data);
		},
		error : function(){
			alert("error");
		}
			
	});//end ajax
}

function findNoEmailSending(){
	$.ajax({
		url : "calendar/countMailStatus/"+0,
		type : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(data){
			$("#noSendEmail").html("<span class='label label-danger'>   </span> <span class='badge'>"+data+"</span> &nbsp;&nbsp;No E-mail Sending");
		},
		error : function(){
			alert("Load appointment error")
		}
	})
}

function findNoEmailUpdate(){
	$.ajax({
		url : "calendar/countMailStatus/"+2,
		type : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(data){
			$("#noEmailUpdate").html("<span class='label label-warning'>   </span> <span class='badge'>"+data+"</span> &nbsp;&nbsp;No Update E-mail");
		},
		error : function(){
			alert("Load appointment error")
		}
	})
}

function goToAppointment(event){
	
	$('#calendar').fullCalendar('gotoDate', event.start);
}

function findEmailSent(){
	$.ajax({
		url : "calendar/countMailStatus/"+1,
		type : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(data){
			$("#emailSent").html("<span class='label label-success'>   </span> <span class='badge'>"+data+"</span> &nbsp;&nbsp;Email Sent");
		},
		error : function(){
			alert("Load appointment error")
		}
	})
}

function renderCalendar(){
	$('#calendar').fullCalendar({
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		allDaySlot : false,
		defaultDate: moment(),
		lang: local,
		selectable: true,
		buttonIcons: true,
		select: function(start, end) {
			//console.log(start);
			var view = $('#calendar').fullCalendar('getView');//get view object
			if(view.name == "month"){ //if event that selected is month then show agendaDay view 
				$('#calendar').fullCalendar('changeView', 'agendaDay');
				$('#calendar').fullCalendar( 'gotoDate', start );
			}else{
				//if current view is date(and choose time range) when click on it insert modal should show
				$validform.resetForm();
				$('#formInsert').trigger('reset');
				setApplicant("all"); 
				$("#insStartDate").text(moment(start).format("HH:mm MMMM D, YYYY"));
				$("#insEndDate").text(moment(end).format("HH:mm MMMM D, YYYY"));
				$('#insModal').modal('show');
				insStart = start;
				insEnd = end;
				$('#calendar').fullCalendar('unselect');
			}
		},
		editable: true,//can't drage to move event to editing
		eventDrop: function(event, delta, revertFunc) {
			updateAppointmentDate(event, revertFunc);
	    },
	    eventResize: function(event, delta, revertFunc) {
	    	updateAppointmentDate(event, revertFunc);
	    },
		eventLimit: true,
		eventSources: [
		    {
				url : 'calendar/findAppointment',
				data : { mailStatus : 0},
				success: function(data) {
					/*console.log("load: ");
					console.log(data);*/
				},
				error: function() {
					//$('#script-warning').show();
					//alert("render error.");
				},
				color : "#FF4512",
				textColor :'white'
		    },
		    {
				url : 'calendar/findAppointment',
				data : { mailStatus : 1},
				success: function(data) {
					/*console.log("load: ");
					console.log(data);*/
				},
				error: function() {
					//$('#script-warning').show();
					//alert("render error.");
				},
				color : "#91E650",
				textColor :'white'
		    },
		    {
				url : 'calendar/findAppointment',
				data : { mailStatus : 2},
				success: function(data) {
					/*console.log("load: ");
					console.log(data);*/
				},
				error: function() {
					//$('#script-warning').show();
					//alert("render error.");
				},
				color : "#EBCD26",
				textColor :'white'
		    }
		],
		dragScroll : false,
		timezone: "Asia/Bangkok",
		ignoreTimezone:false,
		eventClick: function(event, element) {
			/*console.log(event);*/
	        $("#detailModal").modal("show");
			id = event.id;
			$.ajax({
				url : "calendar/getAppointment/"+id,
				type : "GET",
				success : function(data){
					//console.log(data);
					$("#detail_app_name").text(data.applicantName+" ( "+data.applicantPosition+" )");
				    $("#detail_topic").text(data.topic);
				    $("#start_date").text(moment(data.start).format("HH:mm on MMMM D, YYYY"));
				    $("#end_date").text(moment(data.end).format("HH:mm on MMMM D, YYYY"));
					$("#detail_desciption").text(data.detail); 
					$("#appoint_by").text(data.loginName);
				},
				error : function (error) {
					console.log(error)
				}
			});//end ajax

			//$("#detail_topic").text(event.title);
	        $("#myModal").modal("show");
			eventdata = event;
	    } ,
		eventAfterRender: function (event, element) {
			element.popover({
	            title: event.topic,
	            container : 'body',
	            placement: 'auto',
	            content: event.detail
	        });
		},
		eventMouseover: function ( event, jsEvent, view ){
			$(this).popover('show');
			var title = $("h3.popover-title");
			//console.log(event.mailStatus);
			if(event.mailStatus==0){
				$("h3.popover-title").addClass("danger");
			}else if(event.mailStatus==1){
				$("h3.popover-title").addClass("success");
			}else if(event.mailStatus==2){
				$("h3.popover-title").addClass("warning");
			}
		},
		eventMouseout : function ( event, jsEvent, view ){
			$(this).popover('hide');
		}
		,viewRender : function( view, element ){
		}
	}); // end full calendar
	$('#calendar').fullCalendar('gotoDate', currentDate());//go to date after fullcalendar redered 
	$('div.fc-center').addClass('text-center');
	
}//end rendercalendar

$( function(){
		renderCalendar();
		findNoEmailSending();
		findNoEmailUpdate();
		findEmailSent();
		setApplicantNameList();
		
		

		$(".list-group").on("click", ".applicant-list-item", function(){
			$("#appointmentListModal").modal('show');
		});
		
		$('#applicantFilter').on('change',function () {
	 		var trackingString = $("#applicantFilter option:selected").val();
	 		setApplicant(trackingString);
	    });
		
		
		
		$("#deleteBtn" ).on('click',function(){
			$('#delModal').modal("show");
		})
		
		
	 	$('#confirmDel').on('click',function(){
	 		$.ajax({
	 			url : "calendar/deleteAppointment/"+id,
				type : "GET",
				success : function(data){
					$('#calendar').fullCalendar('removeEvents',eventdata.id );
					$('#detailModal').modal("hide");
					$('#delModal').modal("hide");
					new PNotify({
					    title: data + "<br>" + pnotifyDelete,
					    icon: false,
					    delay: 750
					});
					findNoEmailSending();
					findNoEmailUpdate();
					findEmailSent();
				},
				error : function (error) {
					new PNotify({
					    title: "Can't Delete!",
					    text: error,
					    type: 'error',
					    delay: 750
					});
				}
	 		})
		})
		
		$("#insBtn").on('click',function(){
			if( $('#formInsert').valid() ) {
			insTitle = $("#applicantName option:selected").text();

			var appointment = { 
					topic : $("#appointmentTopic").val(),
					detail : $("#appoint_detail").val(),
					start: insStart,
					end : insEnd,
					mailStatus : 0
					//applicant : { id : 1/*$("#applicantName option:selected").val()*/}
					/* login : login_id who insert this appointment will insert in controller :) */
			};
			var insData;
				console.log(JSON.stringify(appointment));
				
				$.ajax({
					url : "calendar/insertAppointment/"+$("#applicantName option:selected").val(),
					type : "POST",
					contentType : "application/json",
					dataType : "json",
					data : JSON.stringify(appointment),
					success : function(data){
						insData = {
							id : data.id,
							title : data.title,
							start : new Date(data.start),
							end : new Date(data.end),
							mailStatus : data.mailStatus,
							color: '#FF4512'
						};
						//console.log(data);
						$('#calendar').fullCalendar('renderEvent', insData, true); // stick? = true
						$('#insModal').modal('hide');	
						$('#formInsert').trigger('reset');
						findNoEmailSending();
						new PNotify({
						    title: data.title +"<br>"+ pnotifyInsert,
						    type: 'success',
						    delay: 750
						});
					}
				});//end ajax
			}
		})//endonclick 'insBtn'
		
		$("#detailModal").on("click","#editBtn", function () {	

			$.ajax({
				url : "calendar/getAppointment/"+id,
				type : "GET",
				success : function(data){
					$validform2.resetForm();
					$('#appointment_show_start').val(moment(data.start).format("DD/MM/YYYY HH:mm"));
					$('#appointment_show_end').val(moment(data.end).format("DD/MM/YYYY HH:mm"));
					$('#applicantNameEdt').val(data.applicantName);
					$('#applicantStatus').val(data.trackingStatus);
					$('#appointmentTopicEdt').val(data.topic);
					$('#appoint_detailEdt').val(data.detail);
					$("#editModal").modal("show");
				},
				error : function (error) {
					console.log(error)
				}
			});//end ajax */
		 }) //end onclick
		
		 $("#confirmEditModal").on("click", "#confirmEditModal", function(){
			 			 var updatedata = {id : id, topic : $("#appointmentTopicEdt").val() , detail : $("#appoint_detailEdt").val()}; 
			 $.ajax({
				url:"calendar/updateTopicAndDetail",
				type: "POST",
				contentType : "application/json",
				data : JSON.stringify(updatedata),
				dataType : "json",
				success: function(result){
					$("#detail_topic").text(result.topic);
					$("#detail_desciption").text(result.detail);
					//$("#formfield").trigger("reset");
					
					$('#confirmEditModal').modal("hide");
					$('#editModal').modal("hide");
					new PNotify({
					    title: result.title +"<br>" + pnotifyEdit,
					    type: 'success',
					    delay: 750
					});
					$('#calendar').fullCalendar( 'destroy' );
	    			renderCalendar();
				},
				error:function (jqXHR, textStatus, error){
			        alert('Update error'); 
			    }  
			
			 });
		   
		 })
		 
		 
		$("#editModal").on("click", "#confirmEditBtn", function(){
			
			if( $('#formEdit').valid() ) {
			$('#confirmEditModal').modal("show");
			}
		});//end edit modal
		
});//end doc ready

