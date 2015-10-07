<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/pageCss/calendar.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/datetime_picker/bootstrap-datetimepicker.min.css" />

<style type="text/css">


</style>

<div id="calendar-container" class="container-fluid">
	<div class="row">
		<div class="col-xs-offset-6 col-xs-6 col-sm-offset-6 col-sm-6 visible-xs visible-sm">
			<div id="mailStatusPropSm">
				<div><h4>Email status</h4></div>
				<div id="noEmailSending" class="media">
					<div class="media-left">
						<span class="label label-danger media-object">Appointment</span>
					</div>
					<div class="media-body">
						<h6 class="media-heading">No E-mail sending</h6>
					</div>
				</div>
				<div id="NoEmailUpdating" class="media">
					<div class="media-left">
						<span class="label label-warning media-object">Appointment</span>
					</div>
					<div class="media-body">
						<h6 class="media-heading">No E-mail Updating</h6>
					</div>
				</div>
				<div id="EmailSent" class="media">
					<div class="media-left">
						<span class="label label-success media-object">Appointment</span>
					</div>
					<div class="media-body">
						<h6 class="media-heading">Email sent</h6>
					</div>
				</div>
			</div>
		</div>
		<div id="calendarDiv" class="col-xs-11 col-sm-11 col-md-9 col-lg-9">
			<div id='calendar'></div>
		</div>
		<div class="col-md-2 col-lg-2 visible-md visible-lg">
			<div id="mailStatusPropMd">
				<div class="text-center"><h3>Email status</h3></div>
				<div id="noEmailSending" class="media">
					<div class="media-left">
						<span class="label label-danger media-object">Appointment</span>
					</div>
					<div class="media-body">
						<h6 class="media-heading">No E-mail sending</h6>
					</div>
				</div>
				<div id="NoEmailUpdating" class="media">
					<div class="media-left">
						<span class="label label-warning media-object">Appointment</span>
					</div>
					<div class="media-body">
						<h6 class="media-heading">No E-mail Updating</h6>
					</div>
				</div>
				<div id="EmailSent" class="media">
					<div class="media-left">
						<span class="label label-success media-object">Appointment</span>
					</div>
					<div class="media-body">
						<h6 class="media-heading">Email sent</h6>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Insert Modal -->
	<div class="modal fade" id="insModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title"><spring:message code="appointment.insert" /></h4>
	      </div>
	      
	      <div class="modal-body">
	        	<div class="container-fluid"><form id="formInsert">
	        		<div class="row">
	        			<div class="col-md-12">
	        			<label for="insStartDate"><spring:message code="appointment.start" /></label>
	        			<h4 id="insStartDate"></h4>
	        			</div>
	        		</div>
	        		<div class="row">
	        			<div class="col-md-12">
	        			<label for="insEndDate"><spring:message code="appointment.end" /></label>
	        			<h4 id="insEndDate"></h4>
	        			</div>
	        		</div>
	        		<hr>
	        		<div class="row">
						<div class="col-md-6">
							<label for="applicantFilter"><spring:message code="appointment.filter.status" /></label> 
							<select name="applicantfilter" id="applicantFilter" class="form-control">
								<option value="all"><spring:message code="appointment.status.all" /></option>
								<option value="test"><spring:message code="appointment.status.pending.test" /></option>
								<option value="pendingapprove"><spring:message code="appointment.status.pending.approve" /></option>
							</select>
						</div>
						
						<div class="col-md-6">
								<label for="applicantName"><spring:message code="appointment.applicant.name" /></label> 
								<select id="applicantName" class="form-control" name = "applicantName">
									<option value=""><spring:message code="appointment.select.applicant" /></option>
									<c:forEach items="${applicants}" var="applicant">
										<option value="${applicant.id}">${applicant.firstNameEN}  ${applicant.lastNameEN} ( ${applicant.technology.name} ${applicant.joblevel.name} )</option>
									</c:forEach>
								</select>
						</div>
					</div>
						
        			<hr>
        			<div class="row">
	        			<div class="col-md-6">
	        				<label for="appointmentTopic"><spring:message code="appointment.topic" /></label>
	        				<input id="appointmentTopic" class="form-control" placeholder="<spring:message code="appointment.topic" />" name="appointmentTopic"  ></input>
	        			</div>
	        		
					</div>
					<br>
					<div class="row">	
	        			<div class="col-md-12">
	        				<label for="appoint_detail"><spring:message code="appointment.detail" /></label>
	        				<textarea id="appoint_detail" name ="appoint_detail" class="form-control" rows="4" placeholder="<spring:message code="appointment.detail" />"></textarea>
	        			</div>
        			</div></form>
	        		</div>
	      </div><!-- /.modal-body -->
	      
	      <div class="modal-footer">
	        <button id="insBtn" type="button" class="btn btn-warning"><span class="glyphicon glyphicon-plus"></span><spring:message code="button.insert" /></button>
	        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="button.cancel" /></button>
	      </div>
	      
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<!-- Detail Modal -->
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel"><spring:message code="appointment.detail.label" /></h4>
	      </div>
	      <div class="modal-body">
	        	<table class="table">
	        		<tr>
	        			<td><h4><spring:message code="appointment.applicant.name" /></h4></td>
	        			<td><h4 id="detail_app_name"></h4></td>
	        		</tr>
	        		<tr>
	        			<td><h4><spring:message code="appointment.start" /></h4></td>
	        			<td colspan="2"><h4 id="start_date"></h4></td>
	        		</tr>
	        		<tr>
	        			<td><h4><spring:message code="appointment.end" /></h4></td>
	        			<td colspan="2"><h4 id="end_date"></h4></td>
	        		</tr>
	        		<tr>
	        			<td><h4><spring:message code="appointment.topic" /></h4></td>
	        			<td colspan="2"><h4 id="detail_topic"></h4></td>
	        		</tr>
	        		<tr>
	        			<td colspan="1"><h4 ><spring:message code="appointment.detail" /></h4></td>
	        			<td colspan="2"><h4 id="detail_desciption"></h4></td>
	        		</tr>
	        		<tr>
	        			<td colspan="1"><h4 ><spring:message code="appointment.appointBy" /></h4></td>
	        			<td colspan="2"><h4 id="appoint_by"></h4></td>
	        		</tr>
	        	</table>
	        
	        <div class="text-right">
		        <button id=editBtn type="button" class="btn btn-warning" data-dissmiss="modal"><span class="glyphicon glyphicon-pencil"></span><spring:message code="button.edit" /></button>
		        <button id="deleteBtn" type="button" class="btn btn-danger" data-dissmiss="modal"><span class="glyphicon glyphicon-remove-sign"></span><spring:message code="button.delete" /></button><br><br>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="button.cancel" /></button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Edit Modal -->
	<div class="modal fade" id="editModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title"><spring:message code="appointment.edit.label" /></h4>
	      </div>
	     
	      <div class="modal-body">
	        	<div class="container-fluid"><form id="formEdit">
	        	 <input type="hidden" id="appointmentId" value="">
					<div class="row">
						<div class="col-md-6">
								<label for="applicantNameEdt"><spring:message code="appointment.applicant.name" /></label> 
								<input id="applicantNameEdt" class="form-control" placeholder="Applicant Name" readonly></input>

						</div>
						<div class="col-md-6">
							<label for="applicantStatus"><spring:message code="appointment.applicant.status" /></label> 
							<input id="applicantStatus" class="form-control" placeholder="Applicant Status" readonly></input>
						</div>
						
					</div>
					<div class="row">
						 <div class='col-md-6'>
				            <div class="form-group">
				            <label for="appointment_show_start"><spring:message code="appointment.start" /></label>
				                <div id="startPicker" class='input-group' >
			                    	<input type='text' class="form-control" id='appointment_show_start' readonly/>
			                     	<span class="input-group-addon glyphicon glyphicon-calendar"></span>
				                </div>
				            </div>
       					 </div>
       					  <div class='col-md-6'>
				            <div class="form-group">
				             <label for="appointment_show_end"><spring:message code="appointment.end" /></label>
				                <div id="endPicker" class='input-group' >
				                    <input type='text' class="form-control" id='appointment_show_end' readonly/>
				                    <span class="input-group-addon glyphicon glyphicon-calendar"></span>
				                </div>
				            </div>
       					 </div>
					</div>
					<hr/>
        			<div class="row">
	        			<div class="col-md-6">
	        				<label for="appointmentTopicEdt"><spring:message code="appointment.topic" /></label>
	        				<input id="appointmentTopicEdt" class="form-control" placeholder="<spring:message code="appointment.topic" />" name="appointmentTopicEdt"></input>
	        			</div>
					</div>
					<br>
					<div class="row">	
	        			<div class="col-md-12">
	        				<label for="appoint_detailEdt"><spring:message code="appointment.detail" /></label>
	        				<textarea id="appoint_detailEdt" class="form-control" rows="4" placeholder="<spring:message code="appointment.detail" />" name ="appoint_detailEdt"></textarea>
	        			</div>
        			</div></form>
	        		</div>
	      </div><!-- /.modal-body -->
	      
	      <div class="modal-footer">
	        <button id="confirmEditBtn" type="button" class="btn btn-warning"><span class="glyphicon glyphicon-pencil"></span><spring:message code="button.save" /></button>
	        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="button.cancel" /></button>
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
	        <h4><spring:message code="appointment.confirm.delete.title" /></h4>
	      </div>
	      <div class="modal-body">
	        <p><spring:message code="appointment.confirm.delete" /></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" id="confirmDel" class="btn btn-danger" ><span class="glyphicon glyphicon-remove-sign"></span> <spring:message code="button.delete" /></button>
            <button type="button" class="btn btn-default" data-dismiss="modal"><span class=""></span> <spring:message code="button.cancel" /></button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<!-- Edit confirm Modal -->
	<div class="modal fade" id="confirmEditModal">
	  <div class="modal-dialog modal-sm">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4><spring:message code="appointment.confirm.edit.title" /></h4>
	      </div>
	      <div class="modal-body">
	        <p><spring:message code="appointment.confirm.edit" /></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" id="confirmEditModal" class="btn btn-warning" ><span class="glyphicon glyphicon-pencil"></span><spring:message code="button.edit" /></button>
	        <button type="button" class="btn btn-default" data-dismiss="modal"><span class=""></span> <spring:message code="button.cancel" /></button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
</div>

<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
	var languageNow = "${pageContext.response.locale}";

	var yes = "<spring:message code="appointment.yes" />";
	var no = "<spring:message code="appointment.no" />";
	var confirmEditAppointmentDate = "<spring:message code="appointment.confirm.event.move" />";
	var selectApplicant = "<spring:message code="appointment.select.applicant" />";
	var validateApplicant = "<spring:message code="appointment.validate.select.applicant" />";
	var validateTopic = "<spring:message code="appointment.validate.required.topic" />";
	var validateTopicLenght = "<spring:message code="appointment.validate.required.topic.lenght" />";
	var validateDatail = "<spring:message code="appointment.validate.required.detail" />";
	var pnotifyInsert = "<spring:message code="appointment.pnotify.insert" />";
	var pnotifyEdit = "<spring:message code="appointment.pnotify.edit" />";
	var pnotifyDelete = "<spring:message code="appointment.pnotify.delete" />";

</script>

<!-- Validate -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/js/jquery.validate.min.js"></script>

<!-- pageJS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/calendar.js"></script>

<!-- jQueryValidate -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/js/jquery.validate.min.js"></script>

<!-- Datetime picker -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/datetime_picker/bootstrap-datetimepicker.min.js"></script>

