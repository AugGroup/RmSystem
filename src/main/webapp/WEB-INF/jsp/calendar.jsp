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
	
	textarea {
    overflow-y: scroll;
    resize: none; 
    } 


</style>

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
	        			<div class="col-md-12">
	        			<label for="insStartDate">เพิ่มการนัดหมายสำหรับวันที่</label>
	        			<h4 id="insStartDate"></h4>
	        			</div>
	        		</div>
	        		<div class="row">
	        			<div class="col-md-12">
	        			<label for="insEndDate">ถึงวันที่</label>
	        			<h4 id="insEndDate"></h4>
	        			</div>
	        		</div>
	        		<hr>
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
								<select id="applicantName" class="form-control" name = "applicantName">
									<option value="">-- Select Applicant --</option>
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
	        				<input id="appointmentTopic" class="form-control" placeholder="Topic" name="appointmentTopic"  ></input>
	        			</div>
	        		
					</div>
					<div class="row">	
	        			<div class="col-md-12">
	        				<label for="appoint_detail">Detail</label>
	        				<textarea id="appoint_detail" name ="appoint_detail" class="form-control" rows="4" placeholder="Insert detail here..."></textarea>
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
	        				<textarea id="appoint_detail" class="form-control" rows="4" placeholder="Insert detail here..." name ="appoint_detail"></textarea>
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

<!-- Validate -->
<script type="text/javascript" src="static/resources/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/calendar.js"></script>

