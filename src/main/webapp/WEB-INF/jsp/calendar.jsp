<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style type="text/css">

	div.fc-row>table>thead > tr:first-child {
	background-color: orange;
	}
	td.fc-day{
	background-color: #F5EE90;
	}

	body {
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}

</style>


<script>

	function currentDate(){
		var date = new Date();
		var month = date.getMonth()+1;
		var day = date.getDate();
	
		var output = date.getFullYear() + '-' +
		    (month<10 ? '0' : '') + month + '-' +
		    (day<10 ? '0' : '') + day;
		return output;
	}
	
	function setApplicant(trackingStatus){
		$.ajax({
			url : "calendar/findByTrackingStatus/" + trackingStatus,
			type : "GET",
			dataType : "json",
			success : function(data){
				$('#applicantName').empty().append('<option value="-1">-- Select Applicant --</option>');
				
				if(trackingStatus==="all"){
					$.each(data, function(i, item) {
					    //alert(data[i].firstNameEN);
					    var name = "<option value='" + data[i].id +  "'> " + data[i].firstNameEN +" " + data[i].lastNameEN +" ( " + data[i].technologyStr + " " + data[i].joblevelStr + "  )</option>"
					    $('#applicantName').append(name);
					})
				}else{
					$.each(data, function(i, item) {
					    //alert(data[i].firstNameEN);
					    var name = "<option value='" + data[i].id +  "'> " + data[i].firstNameEN +" " + data[i].lastNameEN +" ( " + data[i].masTechnologyName + " " + data[i].masJobLevelName + "  )</option>"
					    $('#applicantName').append(name);
					})
				}
				
				
				console.log(data);
			},
			error : function(error){
				alert("error");
				console.log(error);
			}
				
		});//end ajax
	}
	
	
	function toTimeZone(time) {
	    var format = 'MM/DD/YYYY HH:mm:ss z';
	    var zone = "Asia/Bangkok"
	    var expect = moment(time, format).tz(zone).format(format);
	    
	    var date = new Date(time);
	    console.log(date);
	    return expect;
	}
	
	$(document).ready(function() {
		
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
		
		
		var startDate , endDate;
	    function getMonthDateRange(year, month) {
	        //var moment = require('moment');

	        // month in moment is 0 based, so 9 is actually october, subtract 1 to compensate
	        // array is 'year', 'month', 'day', etc
	        startDate = moment([year, month - 1]);
			startDate = moment(startDate).format("YYYY-MM-DD");
	        // Clone the value before .endOf()
	        endDate = moment(startDate).endOf('month');
	        endDate = moment(endDate).format("YYYY-MM-DD");
	        // just for demonstration:
	        console.log(startDate.toString());
	        console.log(endDate.toString());
			
	        // make sure to call toDate() for plain JavaScript date type
	        //return { start: startDate, end: endDate };
	    }
		
	    //var currentDate = moment().format("YYYY-MM-DD");
	    //getMonthDateRange("2015", "09");
	    var calendar = $('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			defaultDate: currentDate(),
			timezone: 'Asia/Bangkok',
			selectable: true,
			selectHelper: true,
			select: function(start, end) {
				var view = $('#calendar').fullCalendar('getView');//get view object
				//console.log(viewname.name)
				if(view.name == "month"){ //if event that selected is month then show agendaDay view 
					$('#calendar').fullCalendar('changeView', 'agendaDay');
					$('#calendar').fullCalendar( 'gotoDate', start );
				}else{
					//if current view is date(and choose time range) when click on it insert modal should show
					setApplicant("all"); 
					$('#insModal').modal('show');
					insStart = start;
					insEnd = end;
					$('#calendar').fullCalendar('unselect');
				}
			},
			editable: false,//can't drage to move event to editing
			eventLimit: true, 
		//	events : "calendar/findAppointment" , //findAllAppointment
			eventSources: [

        // your event source
        {
            url: 'calendar/findAppointment',
            type: 'GET',
            error: function() {
                alert('there was an error while fetching events!');
            },
            color: '#4C48BD',   // a non-ajax option
            textColor: 'white' // a non-ajax option
        }

        // any other sources...

    ],


			eventClick: function(event, element) {
				console.log(event.id)
		        $("#myModal").modal("show");
				id = event.id;
				console.log(id);
				$.ajax({
					url : "calendar/getAppointment/"+id,
					type : "GET",
					success : function(data){
						console.log(data)
						$("#detail_app_name").text(data.applicantName+" ( "+data.applicantPosition+" )");
					    $("#detail_topic").text(data.topic);
					    $("#start_date").text(new Date(data.start));
					    $("#end_date").text(new Date(data.end));
						$("#detail_desciption").text(data.detail); 
						$("#appoint_by").text(data.loginName);
						//alert(data.detail);
					},
					error : function (error) {
						console.log(error)
					}
				});//end ajax

				//$("#detail_topic").text(event.title);
		        $("#myModal").modal("show");
				eventdata = event;
		    }
		}); // end full calendar

		$('#calendar').fullCalendar('gotoDate', currentDate());
		
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
			insTitle = $("#applicantName option:selected").text();
			var appointment = { 
					topic : $("#appointmentTopic").val(),
					detail : $("#appoint_detail").val(),
					start: insStart,
					end : insEnd,
					applicant : { id :$("#applicantName option:selected").val() }
					/* login : $("#applicantName").val() */
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
							start: insStart,
							end: insEnd
						};
						console.log(data);
						$('#calendar').fullCalendar('renderEvent', insData, true); // stick? = true
						$('#insModal').modal('hide');	
						$('#formInsert').trigger('reset');
						//alert(data);
						//alert(data.id);
					}
				});//end ajax
			}//end if
		})//endonclick 'insBtn'
		
		function setApplicant(trackingStatus){
			$.ajax({
				url : "/RmSystem/calendar/findByTrackingStatus/" + trackingStatus,
				type : "GET",
				dataType : "json",
				success : function(data){
					$('#applicantName').empty().append('<option value="-1">-- Select Applicant --</option>');
					
						$.each(data, function(i, item) {
						    //alert(data[i].firstNameEN);
						    var name = "<option value='" + data[i].id +  "'> " + data[i].firstNameEN +" " + data[i].lastNameEN +" ( " + data[i].technologyStr + " " + data[i].joblevelStr + "  )</option>"
						    $('#applicantName').append(name);
						})
					console.log(data);
				},
				error : function(){
					alert("error");
				}
					
			});//end ajax
		}
	});

</script>


<div class="container-fluid">
	<div id='calendar'></div>
	
	
	
	<!-- Insert Modal -->
	<div class="modal fade" id="insModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">Insert Appointment</h4>
	      </div>
	      
	      <div class="modal-body">
	        	<div class="container-fluid"><form id="formInsert">
	        		<div class="row">
						<div class="col-md-6">
							<label for="applicantFilter">Applicant Filter</label> 
							<select name="applicantfilter" id="applicantFilter" class="form-control">
								<option value="all">All</option>
								<option value="test">Pending Test/Interview</option>
								<option value="pendingapprove">Pending Approve</option>
							</select>
						</div>
						
						<div class="col-md-6">
								<label for="applicantName">Applicant Name</label> 
								<select name="applicantname" id="applicantName" class="form-control">
									<option value="-1">-- Select Applicant --</option>
									<c:forEach items="${applicants}" var="applicant">
										<option value="${applicant.id}">${applicant.firstNameEN}  ${applicant.lastNameEN} ( ${applicant.technology.name} ${applicant.joblevel.name} )</option>
									</c:forEach>
								</select>
						</div>
					</div>
						
        			<hr>
        			<div class="row">
	        			<div class="col-md-6">
	        				<label for="appointmentTopic">Appointment Topic</label>
	        				<input id="appointmentTopic" class="form-control" placeholder="Topic"></input>
	        			</div>
	        		
					</div>
					<div class="row">	
	        			<div class="col-md-12">
	        				<label for="appoint_detail">Detail</label>
	        				<textarea id="appoint_detail" class="form-control" rows="4" placeholder="Insert detail here..."></textarea>
	        			</div>
	        			<!-- <div class="col-md-12"><br>
	        				<label >Appoint for</label>
								<div class="radio">
								  <label>
								    <input type="radio" name="appointmentType" id="appointmentType1" value="testAndInterview" checked>
								    Test and Interview
								  </label>
								</div>
								<div class="radio">
								  <label>
								    <input type="radio" name="appointmentType" id="appointmentType2" value="signContract">
								    Sign Contract
								  </label>
								</div>
								<div class="radio">
								  <label>
								    <input type="radio" name="appointmentType" id="appointmentType3" value="other">
								    Other
								  </label>
								  <input id="remarkOther" class="form-control" placeholder="Remark"></input>
								</div>
						</div> -->
        			</div></form>
	        		</div>
	      </div><!-- /.modal-body -->
	      
	      <div class="modal-footer">
	        <button id="insBtn" type="button" class="btn btn-primary">Insert</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	      
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<!-- Detail Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Appointment Detail</h4>
	      </div>
	      <div class="modal-body">
	        	<table class="table">
	        		<tr>
	        			<td><h4>Name</h4></td>
	        			<td><h4 id="detail_app_name"></h4></td>
	        		</tr>
	        		<tr>
	        			<td><h4>Start </h4></td>
	        			<td colspan="2"><h4 id="start_date"></h4></td>
	        		</tr>
	        		<tr>
	        			<td><h4>End </h4></td>
	        			<td colspan="2"><h4 id="end_date"></h4></td>
	        		</tr>
	        		<tr>
	        			<td><h4>Topic</h4></td>
	        			<td colspan="2"><h4 id="detail_topic"></h4></td>
	        		</tr>
	        		<tr>
	        			<td colspan="1"><h4 >Detail</h4></td>
	        			<td colspan="2"><h4 id="detail_desciption"></h4></td>
	        		</tr>
	        		<tr>
	        			<td colspan="1"><h5 >Appoint By</h5></td>
	        			<td colspan="2"><h4 id="appoint_by"></h4></td>
	        		</tr>
	        	</table>
	        
	        <div class="text-right">
		        <button id="editBtn" type="button" class="btn btn-warning" data-dissmiss="modal">Edit</button>
		        <button id="deleteBtn" type="button" class="btn btn-danger" data-dissmiss="modal">Delete</button><br><br>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Insert Modal -->
	<div class="modal fade" id="editModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">Edit Appointment</h4>
	      </div>
	      
	      <div class="modal-body">
	        	<div class="container-fluid"><form id="formInsert">
	        		<div class="row">
						<div class="col-md-6">
							
						</div>
					</div>
						
        			<hr>
        			<div class="row">
	        			<div class="col-md-6">
	        				<label for="appointmentTopic">Appointment Topic</label>
	        				<input id="appointmentTopic" class="form-control" placeholder="Topic"></input>
	        			</div>
	        		
					</div>
					<div class="row">	
	        			<div class="col-md-12">
	        				<label for="appoint_detail">Detail</label>
	        				<textarea id="appoint_detail" class="form-control" rows="4" placeholder="Insert detail here..."></textarea>
	        			</div>
        			</div></form>
	        		</div>
	      </div><!-- /.modal-body -->
	      
	      <div class="modal-footer">
	        <button id="insBtn" type="button" class="btn btn-primary">Insert</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	      
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	
	
	
	
	<!-- Delete Modal -->
		<div class="modal fade" id="delModal">
		  <div class="modal-dialog modal-sm">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4>Confirm Delete</h4>
		      </div>
		      <div class="modal-body">
		        <p>Are you sure you want to delete this ?</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Close</button>
		        <button type="button" id="confirmDel" class="btn btn-danger" ><span class=""></span> Delete</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	
</div>
