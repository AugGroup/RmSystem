<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title><spring:message code="request.email.header.write" /></title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/resources/pageCss/email-write.css" />

<div class="container">
	<div class="col-sm-12" id="email-section">
	
		<div class="row">
			<div class="col-sm-12">
				<div class="page-header">
					<h1><spring:message code="request.email.header.write" /></h1>
				</div>
			</div>
		</div>	
	
		<div class="row">
			<div class="col-sm-12">
				<div class="col-sm-6">
		  				<div class="form-group">
		    				<label for="receiver">To:</label>
		    				<input type="text" id="receiver" name="receiver" class="form-control" value="${myVar}" />
		  				</div>
						<div class="form-group">
							<label for="cc">Cc:</label>
							<input type="text" value="" data-role="tagsinput" id="cc" name="cc"> 
						</div>
						<div class="form-group">
							<label for="subject">Subject:</label>
							<input type="text" id="subject" name="subject" class="form-control"/> 
						</div>
		  				<button class="btn btn-info" id="send">Send</button>
				</div>
				<div class="col-sm-6">
					<textarea id="preview" name="preview"></textarea>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
	var languageNow = "${pageContext.response.locale}";
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/resources/bootstrap-tagsinput/bootstrap-tagsinput.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/bootstrap-tagsinput/bootstrap-tagsinput.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/email-write.js"></script>
