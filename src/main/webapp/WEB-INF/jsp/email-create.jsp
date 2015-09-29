<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/resources/pageCss/email-create.css" />

<title>Create Template</title>

<div class="container">
	
	<div class="col-sm-12" id="email-section">
		
		<div class="row">
			
			<div class="col-sm-12">
				<div class="page-header">
					<h1>Create Email</h1>
				</div>
			</div>
			
		</div>	
		
		<div class="row">
			<div class="col-sm-7">
				<c:choose>
					<c:when test="${sendStatus == true}">
			       		<div class="alert alert-success alert-dismissible" role="alert">
				       		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
	  							<span aria-hidden="true">&times;</span>
							</button>Save template success.
						</div>
			    	</c:when>
			    	<c:when test="${sendStatus == false}">
			       		<div class="alert alert-danger alert-dismissible" role="alert">
				       		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
	  							<span aria-hidden="true">&times;</span>
							</button>Save template fail.
						</div>
			    	</c:when>
			    	<c:when test="${empty sendStatus}">
			    		
			    	</c:when>
				</c:choose>
				<div id="email-template">
					<form action="${ pageContext.request.contextPath }/email/setTemplate" method="POST">
						<div class="form-group">
							<label for="name">Template Name :</label>
							<input type="text" name="name" class="form-control" placeholder="Template Name">
						</div>
						<div class="form-group">
							<label for="template">Template :</label>
							<textarea id="editor1" name="template"></textarea>
						</div>
						<input type="submit" class="btn btn-info" value="Submit" />
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

<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/email-create.js"></script>
