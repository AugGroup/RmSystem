<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
	
	$(document).ready(function() {
		
		var id;
		var eventdata;
		var insTitle;
		var insStart;
		var insEnd;
		var type;
		
		
		/* if (!document.getElementById('appointmentType3').checked) {
			document.getElementById("remarkOther").disabled = true;
		}
		
		$('input[type=radio][name=appointmentType]').change(function() {
	        if (this.value == 'other') {
	        	document.getElementById("remarkOther").disabled = false;
	        }
	        else {
	        	document.getElementById("remarkOther").disabled = true;
	        }
	    }); */
		//var calendar = $('#calendar').fullCalendar('getCalendar');
		
		

		var calendar = $('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			defaultDate: '2015-10-01',
			selectable: true,
			selectHelper: true,
			select: function(start, end) {
				setApplicant("all"); 
				$('#insModal').modal('show');
				insStart = start;
				insEnd = end;
				$('#calendar').fullCalendar('unselect');
			},
			editable: true,
			eventLimit: true, 
			events : [],//"findAllAppointment",
			eventClick: function(event, element) {

		        $("#myModal").modal("show");
		        $("#detail_app_name").text(event.title);
				$("#detail_datetime").text(event.start);
				id = event.id;
				$.ajax({
					url : "calendar/getAppointment/"+id,
					type : "GET",
					success : function(data){
					    $("#detail_topic").text(data.topic);
						$("#detail_desciption").text(data.detail); 
						//alert(data.detail);
					}
				});//end ajax

				$("#detail_topic").text(event.title);
				$("#detail_title").text(event.title);
				$("#detail_datetime").text(event.start);
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
			insTitle = $("#applicantName option:selected").val();
			var appointmentType;
			
			if (document.getElementById('appointmentType1').checked) {
				appointmentType = $("#appointmentType1").val();
			}else if (document.getElementById('appointmentType2').checked) {
				appointmentType = $("#appointmentType2").val();
			}else if (document.getElementById('appointmentType3').checked) {
				appointmentType = $("#remarkOther").val();
			}
			var appointment = { 
					topic : $("#appointmentTopic").val(),
					detail : $("#appoint_detail").val(),
					start: insStart,
					end : insEnd,
					/* applicant : $("#applicantName option:selected").text() */ 
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
							title: data.applicant,
							start: insStart,
							end: insEnd
						};
						
						$('#calendar').fullCalendar('renderEvent', insData, true); // stick? = true
						$('#insModal').modal('hide');	
						$('#formInsert').trigger('reset');
						//alert(data);
						//alert(data.id);
					}
				});//end ajax
			}//end if
		})//endonclick 'insBtn'
		
/* 		
		$('#applicantFilter').on('click',function(){
			var trackingStatus = $(this).data("trackingStatus");
			$.ajax({
				url : "findByTrackingStatus/" + trackingStatus,
				type : "GET",
				contentType :"application/json; charset=utf-8", 
				data : JSON.stringify(appointment),
				success : function(data){
					
				}
			});//end ajax
		}); */
		
		
		function setApplicant(trackingStatus){
			$.ajax({
				url : "/RmSystem/findByTrackingStatus/" + trackingStatus,
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
								<option value="All">All</option>
								<option value="Pending Test">Pending Test/Interview</option>
								<option value="Approve">Pending Approve</option>
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
	        			<td><h4>Date</h4></td>
	        			<td colspan="2"><h4 id="detail_datetime"></h4></td>
	        		</tr>
	        		<tr>
	        			<td><h4>Topic</h4></td>
	        			<td colspan="2"><h4 id="detail_topic"></h4></td>
	        		</tr>
	        		<tr>
	        			<td colspan="1"><h4 >Detail</h4></td>
	        			<td colspan="2"><h4 id="detail_desciption"></h4></td>
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
