<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/resources/pageCss/email-create.css" />

<div class="container">
	<div class="col-sm-12" id="email-section">
		
		<div class="row">
			
			<div class="col-sm-12">
				<div class="page-header">
					<h1>Edit Email</h1>
				</div>
			</div>
			
		</div>	
		
		<div class="row">
			<div class="col-sm-7">
				<div id="email-template">
					<form>
						<div class="form-group">
							<label for="name">Template Name :</label>
							<select class="form-control" id="mailTemplate">
								<option value="-1" label="--- Select Template ---" />
								<c:forEach items="${mailTemplate}" var="mailTemplate">
									<option value="${mailTemplate.id}">${mailTemplate.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="template">Template :</label>
							<textarea id="template" name="template"></textarea>
						</div>
						<button type="button" class="btn btn-success" id="update" >Update</button>
						<button type="button" class="btn btn-danger" id="delete">Delete</button>
					</form>
				</div>
			</div>
			<div class="col-sm-5">
				<div id="email-hints">
					<p class="text-center"><strong id="email-hints-header">Hints</strong></p>
					<p><b>$FIRST_NAME</b> : Applicant's first name.</p>
					<p><b>$LAST_NAME</b> : Applicant's last name.</p>
					<p><b>$TECHNOLOGY</b> : Applicant's technology.</p>
					<p><b>$DATE</b> : Appointment date.</p>
					<p><b>$TIME</b> : Appointment time.</p>
					<p><b>$RECRUIT_FIRST_NAME</b> : Recruiter's first name.</p>
					<p><b>$RECRUIT_LAST_NAME</b> : Recruiter's last name.</p>
					<p><b>$RECRUIT_POSITION</b> : Recruiter's position</p>
					<p><b>$RECRUIT_PHONE</b> : Recruiter's phone number</p>
				</div>
			</div>
		</div>
			
	</div>
</div>

<div class="modal fade" id="showModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <div class="modal-header">
        <h4 class="modal-title" id="title-detail">
        	<span class="glyphicon glyphicon-remove-sign"></span> Delete Template
        </h4>
      </div>
      
      <div class="modal-body" id="body-detail">
        <p>Do You Want To Delete The Template?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" id="btnClose" data-dismiss="modal">Close</button>
        <button type="button" class="btn" id="btnActive" data-dismiss="modal">Ok</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/email-create.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/email-edit.js"></script>