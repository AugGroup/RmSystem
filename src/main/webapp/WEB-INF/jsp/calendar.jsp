<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/pageCss/calendar.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/datetime_picker/bootstrap-datetimepicker.min.css" />

<style type="text/css">


</style>

<div class="container-fluid">
	<div id='calendar'></div>
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
	        <button id="insBtn" type="button" class="btn btn-primary"><spring:message code="button.insert" /></button>
	        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="button.close" /></button>
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
		        <button id=editBtn type="button" class="btn btn-warning" data-dissmiss="modal"><spring:message code="button.edit" /></button>
		        <button id="deleteBtn" type="button" class="btn btn-danger" data-dissmiss="modal"><spring:message code="button.delete" /></button><br><br>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="button.close" /></button>
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
						 <div class='col-md-6'>
				            <div class="form-group">
				            <label for="start"><spring:message code="appointment.start" /></label>
				                <div id="startPicker" class='input-group date dt_picker' >
				                    <input type='text' class="form-control" id='datetimepicker_start' readonly/>
				                    <span class="input-group-addon">
				                     	<span class="glyphicon glyphicon-calendar"></span>
				                    </span>
				                </div>
				            </div>
       					 </div>
       					  <div class='col-md-6'>
				            <div class="form-group">
				             <label for="end"><spring:message code="appointment.end" /></label>
				                <div id="endPicker" class='input-group date dt_picker' >
				                    <input type='text' class="form-control" id='datetimepicker_end' readonly/>
				                    <span class="input-group-addon">
				                     	<span class="glyphicon glyphicon-calendar"></span>
				                    </span>
				                </div>
				            </div>
       					 </div>
					</div>
					<div class="row">
						<div class="col-md-6">
								<label for="applicantNameEdt"><spring:message code="appointment.applicant.name" /></label> 
								<input id="applicantNameEdt" class="form-control" placeholder="Applicant Name" disabled></input>

						</div>
						<div class="col-md-6">
							<label for="applicantStatus"><spring:message code="appointment.applicant.status" /></label> 
							<input id="applicantStatus" class="form-control" placeholder="Applicant Status" disabled></input>
						</div>
						
					</div>
					<br>
        			<div class="row">
	        			<div class="col-md-6">
	        				<label for="appointmentTopicEdt"><spring:message code="appointment.topic" /></label>
	        				<input id="appointmentTopicEdt" class="form-control" placeholder="<spring:message code="appointment.topic" />"></input>
	        			</div>
					</div>
					<br>
					<div class="row">	
	        			<div class="col-md-12">
	        				<label for="appoint_detailEdt"><spring:message code="appointment.detail" /></label>
	        				<textarea id="appoint_detailEdt" class="form-control" rows="4" placeholder="<spring:message code="appointment.detail" />" name ="appoint_detail"></textarea>
	        			</div>
        			</div></form>
	        		</div>
	      </div><!-- /.modal-body -->
	      
	      <div class="modal-footer">
	        <button id="confirmEditBtn" type="button" class="btn btn-primary"><spring:message code="button.save" /></button>
	        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="button.close" /></button>
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
		        <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> <spring:message code="button.close" /></button>
		        <button type="button" id="confirmDel" class="btn btn-danger" ><span class=""></span> <spring:message code="button.delete" /></button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	
</div>

<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
	var languageNow = "${pageContext.response.locale}";
	var selectApplicant = "<spring:message code="appointment.select.applicant" />"
	var validateApplicant = "<spring:message code="appointment.validate.select.applicant" />"
	var validateTopic = "<spring:message code="appointment.validat.required.topic" />"
	var validateTopicLenght = "<spring:message code="appointment.validat.required.topic.lenght" />"
	var validateDatail = "<spring:message code="appointment.validat.required.detail" />"
</script>

<!-- Validate -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/js/jquery.validate.min.js"></script>

<!-- pageJS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/calendar.js"></script>

<!-- jQueryValidate -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/js/jquery.validate.min.js"></script>

<!-- Datetime picker -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/datetime_picker/bootstrap-datetimepicker.min.js"></script>

