<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<title><spring:message code="request.calendar" /></title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/pageCss/calendar.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/datetime_picker/bootstrap-datetimepicker.min.css" />


<script type="text/javascript">
	var approve_tx = '<spring:message code="edit.approve"/>';

	$(document).ready(function(){
		$("#calendarPage").addClass('active-menu'); 
	});
</script>

<div id="calendar-container" class="container-fluid">
	<div><h1 align="center"><spring:message code="request.calendar"/></h1></div>
	<div class="row">
		<div id="calendarDiv" class="col-xs-11 col-sm-11 col-md-9 col-lg-9">
			<div id='calendar'></div>
		</div>
		<div class="col-xs-12 col-sm-12 visible-xs visible-sm">
			<div id="mailStatusPropSm">
				<div class="text-center"><h3><spring:message code="appointment.email.status"/></h3></div>
				<ul class="list-group" >
				  <li class="list-group-item noSendEmail" >
				  </li>
				  <li class="list-group-item noEmailUpdate" >
				  </li>
				  <li class="list-group-item emailSent" >
				  </li>
				</ul>
			</div>
		</div>
		<div id="trackingStatusPanelSm" class="col-xs-12 col-sm-12 visible-xs visible-sm ">
		<div class="text-center"><h3><spring:message code="appointment.applicant.status"/></h3></div>
		<div class="panel-group" id="applicantStatusListSm" role="tablist" aria-multiselectable="true">
		  <div class="panel panel-default">
		    <div class="panel-heading" role="tab" id="pendingTestHead">
		      <h4 class="panel-title">
		        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#applicantStatusListSm" href="#pendingTestListSm" aria-expanded="true" aria-controls="pendingTestListSm">
		          <spring:message code="appointment.status.pending.test"/>
		        </a>
		      </h4>
		    </div>
		    <div id="pendingTestListSm" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="pendingTestHead">
		      <div  class="list-group">
		      	<!-- jQueryRender -->
		      </div>
		    </div>
		  </div>
		  <div class="panel panel-default">
		    <div class="panel-heading" role="tab" id="pendingApproveHead">
		      <h4 class="panel-title">
		        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#applicantStatusListSm" href="#pendingApproveListSm" aria-expanded="false" aria-controls="pendingApproveListSm">
		          <spring:message code="appointment.status.pending.approve"/>
		        </a>
		      </h4>
		    </div>
		    <div id="pendingApproveListSm" class="panel-collapse collapse" role="tabpanel" aria-labelledby="pendingApproveHead">
		      <div  class="list-group">
		      	<!-- jQueryRender -->
		      </div>
		    </div>
		  </div>
		</div>
		</div>
		
		<div class="col-md-2 col-lg-2 visible-md visible-lg">
			<div class="row">
				<div class="col-md-12">
				<div id="mailStatusPropMd">
					<div class="text-center"><h3><spring:message code="appointment.email.status"/></h3></div>
					<ul class="list-group" >
					  <li class="list-group-item noSendEmail" >
					  </li>
					  <li class="list-group-item noEmailUpdate" >
					  </li>
					  <li class="list-group-item emailSent" >
					  </li>
					</ul>
				</div>
				</div>
			<div class="row">
				<div class="col-md-12">
				<div id="trackingStatusPanelMd" class="col-md-12">
				<div class="text-center"><h3><spring:message code="appointment.applicant.status"/></h3></div>
				<div class="panel-group" id="applicantStatusListMd" role="tablist" aria-multiselectable="true">
				  <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="pendingTestHead">
				      <h4 class="panel-title">
				        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#applicantStatusListMd" href="#pendingTestListMd" aria-expanded="true" aria-controls="pendingTestListMd">
				          <spring:message code="appointment.status.pending.test"/>
				        </a>
				      </h4>
				    </div>
				    <div id="pendingTestListMd" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
				      <div  class="list-group">
				      	<!-- jQueryRender -->
				      </div>
				    </div>
				  </div>
				  <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="pendingApproveHead">
				      <h4 class="panel-title">
				        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#applicantStatusListMd" href="#pendingApproveListMd" aria-expanded="false" aria-controls="pendingApproveListMd">
				          <spring:message code="appointment.status.pending.approve"/>
				        </a>
				      </h4>
				    </div>
				    <div id="pendingApproveListMd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
				      <div  class="list-group">
				      	<!-- jQueryRender -->
				      </div>
				    </div>
				  </div>
				</div>
				</div>
				</div>
			</div>
		</div>
		
		
	</div><!-- end row -->
	
	
	
	
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
	
	
	<!-- Modal -->
	<div class="modal fade" id="appointmentListModal" tabindex="-1" role="dialog" aria-labelledby="modal_appointmentList">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="modalHeader_appointmentList"></h4>
	      </div>
	      <div id="modalBody_appointmentList" class="modal-body">
	      	<div class="table-responsive" style=" width:100%;">
	      		<table id="appointmentListTable" >
	      		<caption title="" class="tableHeader"><spring:message code="appointment.description"/></caption>
	      			<thead>
	      				<tr>
	      					<th><spring:message code="appointment.id"/></th>
	      					<th><spring:message code="appointment.topic"/></th>
	      					<th><spring:message code="appointment.detail"/></th>
	      					<th><spring:message code="appointment.start"/></th>
	      					<th><spring:message code="appointment.end"/></th>
<!-- 	      					<th>MAIL STATUS</th> -->
	      				</tr>
	      			</thead>
	      		</table>
	      	</div>
	      </div>
	    </div>
	  </div>
	</div>
	</div>
</div>

<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
	var languageNow = "${pageContext.response.locale}";

	var yes = "<spring:message code='appointment.yes' />";
	var no = "<spring:message code='appointment.no' />";
	var confirmEditAppointmentDate = "<spring:message code='appointment.confirm.event.move' />";
	var selectApplicant = "<spring:message code='appointment.select.applicant' />";
	var validateApplicant = "<spring:message code='appointment.validate.select.applicant' />";
	var validateTopic = "<spring:message code='appointment.validate.required.topic' />";
	var validateTopicLenght = "<spring:message code='appointment.validate.required.topic.lenght' />";
	var validateDatail = "<spring:message code='appointment.validate.required.detail' />";
	var pnotifyInsert = "<spring:message code='appointment.pnotify.insert' />";
	var pnotifyEdit = "<spring:message code='appointment.pnotify.edit' />";
	var pnotifyDelete = "<spring:message code='appointment.pnotify.delete' />";
	var appointmentEmailNosent = "<spring:message code='appointment.email.status.nosend' />";
	var appointmentEmailSuccess = "<spring:message code='appointment.email.status.success' />";
	var appointmentEmailNoUpdate = "<spring:message code='appointment.email.status.noupdate' />";
	
</script>

<!-- Validate -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/js/jquery.validate.min.js"></script>

<!-- pageJS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/calendar.js"></script>

<!-- jQueryValidate -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/js/jquery.validate.min.js"></script>

<!-- Datetime picker -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/datetime_picker/bootstrap-datetimepicker.min.js"></script>

