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

function updateAppointmentDate(eventToUpdate, revertParam){
	var updatedata = {id : eventToUpdate.id, start : eventToUpdate.start, end : eventToUpdate.end};
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
	    			    title: 'Appointment has been modified.',
	    			    type: 'success'
	    			});
	    			var view = $('#calendar').fullCalendar('getView');//get view object
    				$('#calendar').fullCalendar( 'destroy' );
	    			renderCalendar();
    				$('#calendar').fullCalendar('changeView', view.name);
    				$('#calendar').fullCalendar( 'gotoDate', eventToUpdate.start );
	    			
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
			$applicantName.empty().append('<option value="">-- Select Applicant --</option>');
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
	
function setApplicant(trackingStatus){
	$.ajax({
		url : "/RmSystem/calendar/findByTrackingStatus/" + trackingStatus,
		type : "GET",
		dataType : "json",
		success : function(data){
			$('#applicantName').empty().append('<option value="-1">-- Select Applicant --</option>');
			
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

function renderCalendar(){
	$('#calendar').fullCalendar({
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
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
				$("#insStartDate").text(moment(start).format("HH:mm on MMMM D, YYYY"));
				$("#insEndDate").text(moment(end).format("HH:mm on MMMM D, YYYY"));
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
		events: {
			url: 'calendar/findAppointment',
			success: function(data) {
				/*console.log("load: ");
				console.log(data);*/
			},
			error: function() {
				//$('#script-warning').show();
				//alert("render error.");
			},
			color : "#8723D9",textColor :'white'
		},
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
	    eventRender: function(event, el) {
			//console.log("eventRender:");
			//console.log(event.start.hasZone());
		}
	}); // end full calendar
}

$( function(){
		$(".dt_picker").datetimepicker({
		    format: "dd/mm/yyyy hh:ii",
		    autoclose: true,
		    minuteStep: 30,
		});
		
		
		renderCalendar();
		
		$('#calendar').fullCalendar('gotoDate', currentDate());//go to date after fullcalendar redered 
		
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
					    title: 'Appointment has been deleted.',
					    icon: false
					});
				},
				error : function (error) {
					new PNotify({
					    title: "Can't Delete!",
					    text: error,
					    type: 'error'
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
					applicant : { id :$("#applicantName option:selected").val() }
					/* login : login_id who insert this appointment will insert in controller :) */
			};
			var insData;
			if (insTitle) {
				console.log(JSON.stringify(appointment));
				
				$.ajax({
					url : "calendar/insertAppointment",
					type : "POST",
					contentType :"application/json; charset=utf-8", 
					data : JSON.stringify(appointment),
					success : function(data){
						insData = {
							id : data.id,
							title: data.title,
							start: new Date(data.start),
							end: new Date(data.end),color: '#FF528E'
						};
						//console.log(data);
						$('#calendar').fullCalendar('renderEvent', insData, true); // stick? = true
						$('#insModal').modal('hide');	
						$('#formInsert').trigger('reset');
						new PNotify({
						    title: 'Appointment insertion is successful !',
						    type: 'success'
						});
					}
				});//end ajax
			}
			}//end if
		})//endonclick 'insBtn'
		
		$("#detailModal").on("click","#editBtn", function () {	

			$.ajax({
				url : "calendar/getAppointment/"+id,
				type : "GET",
				success : function(data){
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
					    title: 'Appointment has been modified.',
					    type: 'success'
					});
				},
				error:function (jqXHR, textStatus, error){
			        alert('Update error'); 
			    }  
			
			 });
		 })
		 
		 
		$("#editModal").on("click", "#confirmEditBtn", function(){
			$('#confirmEditModal').modal("show");
		});//end edit modal
});//end doc ready

