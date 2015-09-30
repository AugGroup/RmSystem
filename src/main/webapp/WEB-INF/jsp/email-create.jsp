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
					<h1><spring:message code="request.email.header.create" /></h1>
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
							</button><spring:message code="request.email.status.success" />
						</div>
			    	</c:when>
			    	<c:when test="${sendStatus == false}">
			       		<div class="alert alert-danger alert-dismissible" role="alert">
				       		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
	  							<span aria-hidden="true">&times;</span>
							</button><spring:message code="request.email.status.fail" />
						</div>
			    	</c:when>
			    	<c:when test="${empty sendStatus}">
			    		
			    	</c:when>
				</c:choose>
				<div id="email-template">
					<form action="${ pageContext.request.contextPath }/email/setTemplate" method="POST">
						<div class="form-group">
							<label for="name"><spring:message code="request.email.form.name" /> :</label>
							<input type="text" name="name" class="form-control" placeholder="<spring:message code="request.email.form.name" />">
						</div>
						<div class="form-group">
							<label for="template"><spring:message code="request.email.form.template" /> :</label>
							<textarea id="template" name="template"></textarea>
						</div>
						<button type="submit" class="btn btn-primary"><spring:message code="request.email.form.submit" /></button>
					</form>
				</div>
			</div>
			<div class="col-sm-5">
				<div id="email-hints">
					<p class="text-center"><strong id="email-hints-header"><spring:message code="request.email.description" /></strong></p>
					<p><b>$FIRST_NAME</b> : <spring:message code="request.email.hints.firstName" /></p>
					<p><b>$LAST_NAME</b> : <spring:message code="request.email.hints.lastName" /></p>
					<p><b>$TECHNOLOGY</b> : <spring:message code="request.email.hints.technology" /></p>
					<p><b>$DATE</b> : <spring:message code="request.email.hints.date" /></p>
					<p><b>$TIME</b> : <spring:message code="request.email.hints.time" /></p>
					<p><b>$RECRUIT_FIRST_NAME</b> : <spring:message code="request.email.hints.recruitFirstName" /></p>
					<p><b>$RECRUIT_LAST_NAME</b> : <spring:message code="request.email.hints.recruitLastName" /></p>
					<p><b>$RECRUIT_POSITION</b> : <spring:message code="request.email.hints.recruitPosition" /></p>
					<p><b>$RECRUIT_PHONE</b> : <spring:message code="request.email.hints.recruitPhone" /></p>
				</div>
			</div>
		</div>
			
	</div>
</div>
<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
	var languageNow = "${pageContext.response.locale}";
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/email-create.js"></script>
