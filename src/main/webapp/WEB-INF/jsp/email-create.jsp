<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/resources/pageCss/email-create.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/resources/css/pnotify.custom.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/js/pnotify.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/js/jquery.validate.min.js"></script>

<title><spring:message code="request.email.header.create" /></title>

<script type="text/javascript">
$(document).ready(function(){
	$(".emailPage").addClass('active-menu'); 
	$("#emailCreatePage").addClass('active-menu-sub'); 
});
</script>

<div class="container-fluid">
	
	<div class="col-sm-1"></div>
	<div class="col-sm-12 col-md-10" id="email-section">
		
		<div class="row">
			
			<div class="col-sm-12">
				<div class="page-header">
					<div><spring:message code="request.email.header.create" /></div>
				</div>
			</div>
			
		</div>	
		
		<div class="row">
			<div class="col-sm-7">
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${sendStatus == true}"> --%>
<!-- 			       		<div class="alert alert-success alert-dismissible" role="alert"> -->
<!-- 				       		<button type="button" class="close" data-dismiss="alert" aria-label="Close"> -->
<!-- 	  							<span aria-hidden="true">&times;</span> -->
<%-- 							</button><spring:message code="request.email.status.success" /> --%>
<!-- 						</div> -->
<%-- 			    	</c:when> --%>
<%-- 			    	<c:when test="${sendStatus == false}"> --%>
<!-- 			       		<div class="alert alert-danger alert-dismissible" role="alert"> -->
<!-- 				       		<button type="button" class="close" data-dismiss="alert" aria-label="Close"> -->
<!-- 	  							<span aria-hidden="true">&times;</span> -->
<%-- 							</button><spring:message code="request.email.status.fail" /> --%>
<!-- 						</div> -->
<%-- 			    	</c:when> --%>
<%-- 			    	<c:when test="${empty sendStatus}"> --%>
			    		
<%-- 			    	</c:when> --%>
<%-- 				</c:choose> --%>
				<div id="email-template">
					<form id="templateFormCreate">
						<div class="form-group">
							<label for="name"><spring:message code="request.email.form.template.name" /> :</label>
							<input type="text" name="templateName" class="form-control" id="templateName" placeholder="<spring:message code="request.email.form.template.name" />">
						</div>
						<div class="form-group">
							<label for="template"><spring:message code="request.email.form.template" /> :</label>
							<textarea id="template" name="template"></textarea>
						</div><br>
						<button type="button" class="btn btn-warning" id="create"><span class="glyphicon glyphicon-save"></span><spring:message code="request.email.form.submit" /></button>
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

<div class="modal fade" id="showModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <div class="modal-header">
        <h4 class="modal-title" id="title-detail">
        	<span class="glyphicon glyphicon-remove-sign"></span>
        </h4>
      </div>
      
      <div class="modal-body" id="body-detail">
        <p></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning" id="btnActive" data-dismiss="modal"><span class="glyphicon glyphicon-save"></span><spring:message code="button.save" /></button>
        <button type="button" class="btn btn-default" id="btnClose" data-dismiss="modal"><spring:message code="button.cancel" /></button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
	var languageNow = "${pageContext.response.locale}";
	var templateNameRequired = "<spring:message code="request.email.validate.required.nameTemplate" />";
	var templateRequired = "<spring:message code="request.email.validate.required.template" />";
	var createSuccess= "<spring:message code="request.email.pnotify.create.success" />";
	var createFail= "<spring:message code="request.email.pnotify.create.fail" />";
	var matchingName= "<spring:message code="request.email.pnotify.name.matching" />";
	var createTitle= "<spring:message code="request.email.create.templete.title" />";
	var createAsk= "<spring:message code="request.email.create.templete.ask" />";
	var pnotifyAdd="<spring:message code="pnotify.add"/>";
	var pnotifyEdit="<spring:message code="pnotify.edit"/>";
	var pnotifyDel="<spring:message code="pnotify.delete"/>";
	var pnotifySuccess="<spring:message code="pnotify.success"/>";
	var pnotifyError="<spring:message code="pnotify.error"/>";
	
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/email-create.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/email-active.js"></script>