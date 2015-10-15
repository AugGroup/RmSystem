<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title><spring:message code="request.email.header.write" /></title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/resources/pageCss/email-write.css" />

<script type="text/javascript">
$(document).ready(function(){
	$("#emailPage").addClass('active-menu'); 
	$("#emailWritePage").addClass('.active-menu-sub'); 
});
</script>

<div class="container-fluid">
	<div class="col-sm-1"></div>
	<div class="col-sm-12 col-md-10" id="email-section">
	
		<div class="row">
			<div class="col-sm-12">
				<div class="page-header">
					<h1><spring:message code="request.email.header.write" /></h1>
				</div>
			</div>
		</div>	
	
		<div class="row">
			<div class="col-sm-12">
				<div class="col-sm-6" style="margin-bottom: 10px;">
		  				<div class="form-group">
		    				<label for="receiver"><spring:message code="request.email.to" />:</label>
		    				<input type="text" id="receiver" name="receiver" class="form-control" value="${myVar}" placeholder="<spring:message code="request.email.to" />"/>
		  				</div>
						<div class="form-group">
							<label for="cc"><spring:message code="request.email.cc" />:</label>
							<input type="text" value="" data-role="tagsinput" id="cc" name="cc" placeholder="<spring:message code="request.email.cc" />"> 
						</div>
						<div class="form-group">
							<label for="subject"><spring:message code="request.email.subject" />:</label>
							<input type="text" id="subject" name="subject" class="form-control" placeholder="<spring:message code="request.email.subject" />"/> 
						</div><br>
		  				<button class="btn btn-warning" id="send"><spring:message code="request.email.send" /></button>
				</div>
				<div class="col-sm-6">
					<textarea id="preview" name="preview"></textarea>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Sending modal -->
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" style="margin-top: 20%;" id="emali-sending">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
    	<div class="text-center" style="padding: 10px;">
	    	<p>Sending...</p>
	    	<img src="${ pageContext.request.contextPath }/static/resources/mail-attachment/ajax-loader.gif" />
	    </div>
    </div>
  </div>
</div>
<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
	var languageNow = "${pageContext.response.locale}";
	var pnotifyAdd="<spring:message code="pnotify.add"/>";
	var pnotifyEdit="<spring:message code="pnotify.edit"/>";
	var pnotifyDel="<spring:message code="pnotify.delete"/>";
	var pnotifySuccess="<spring:message code="pnotify.success"/>";
	var pnotifyError="<spring:message code="pnotify.error"/>";
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/resources/bootstrap-tagsinput/bootstrap-tagsinput.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/bootstrap-tagsinput/bootstrap-tagsinput.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/email-write.js"></script>
