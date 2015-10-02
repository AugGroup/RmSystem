$(function(){
	//alert( ${pageContext.response.locale});
	
	var $applicantName = $('#applicantName');
	
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
	
	var tzdetect = {
		    names: moment.tz.names(),
		    matches: function(base){
		        var results = [], now = Date.now(), makekey = function(id){
		            return [0, 4, 8, -5*12, 4-5*12, 8-5*12, 4-2*12, 8-2*12].map(function(months){
		                var m = moment(now + months*30*24*60*60*1000);
		                if (id) m.tz(id);
		                return m.format("DDHHmm");
		            }).join(' ');
		        }, lockey = makekey(base);
		        tzdetect.names.forEach(function(id){
		            if (makekey(id)===lockey) results.push(id);
		        });
		        return results;
		    }
		};
	
	$(document).ready(function() {
			var $validform = $("#formInsert").validate({			
			rules:{
				appointmentTopic:{
					required:true,
					minlength:4,
					maxlength:15	
				},
				appoint_detail:{
					required:true
				},
				 applicantName: {
					required:true
				}
			},
			
			messages: {
				applicantName:{
					required: 'Please Select Applicant.'
				}
			},
			
		 	invalidHandler: function(event, validator) {
				$('#appointmentTopic').focus();
			} 
			
		 });
		
		
		$('#applicantFilter').on('change',function () {
	 		var trackingString = $("#applicantFilter option:selected").val();
	 		setApplicant(trackingString);
	    });
		
		var id;
		var eventdata;
		var insTitle;
		var insStart;
		var insEnd;
		var type;
		
		
	    var calendar = $('#calendar').fullCalendar({
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
			editable: false,//can't drage to move event to editing
			eventLimit: true,
			events: {
				url: 'calendar/findAppointment',
				success: function(data) {
					console.log("load: ");
					console.log(data);
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
				//console.log(event.id);
		        $("#myModal").modal("show");
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
	    
	    
	    
		$('#calendar').fullCalendar('gotoDate', currentDate());//go to date after fullcalendar redered 
		
		$("#deleteBtn" ).on('click',function(){
			$('#delModal').modal("show");
		})
		
		$("#editBtn").on('click',function(){
			$("#editModal").modal("show");
		})
		
		
	 	$('#confirmDel').on('click',function(){
	 		$.ajax({
	 			url : "calendar/deleteAppointment/"+id,
				type : "GET",
				success : function(data){
					$('#calendar').fullCalendar('removeEvents',eventdata.id );
				}
	 		})
			$('#myModal').modal("hide");
			$('#delModal').modal("hide");
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
						console.log(data);
						$('#calendar').fullCalendar('renderEvent', insData, true); // stick? = true
						$('#insModal').modal('hide');	
						$('#formInsert').trigger('reset');
					}
				});//end ajax
			}
			}//end if
		})//endonclick 'insBtn'
		
	});
});