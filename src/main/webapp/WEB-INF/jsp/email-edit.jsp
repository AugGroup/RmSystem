<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title><spring:message code="request.email.header.edit" /></title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/resources/pageCss/email-create.css" />

<script type="text/javascript">
$(document).ready(function(){
	$("#emailPage").addClass('active-menu'); 
	$("#emailEditPage").addClass('active-menu-sub'); 
});
</script>

<div class="container-fluid">
	<div class="col-sm-1"></div>
	<div class="col-sm-12 col-md-10" id="email-section">
		
		<div class="row">
			
			<div class="col-sm-12">
				<div class="page-header">
					<div><spring:message code="request.email.header.edit" /></div>
				</div>
			</div>
			
		</div>	
		
		<div class="row">
			<div class="col-sm-7">
				<div id="email-template">
					<form id="templateFormEdit">
						<div class="form-group">
							<label for="name"><spring:message code="request.email.form.template.name" /> :</label>
							<select class="form-control" id="mailTemplate" name="selectTemplate">
								<option value=""><spring:message code="request.email.form.select.init.template" /></option>
								<c:forEach items="${mailTemplate}" var="mailTemplate">
									<option value="${mailTemplate.id}">${mailTemplate.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="template"><spring:message code="request.email.form.template" /> :</label>
							<textarea id="template" name="template"></textarea>
						</div><br>
						<button type="button" class="btn btn-warning" id="update" ><span class="glyphicon glyphicon-pencil"></span><spring:message code="button.edit" /></button>
						<button type="button" class="btn btn-danger" id="delete"><span class="glyphicon glyphicon-remove-sign"></span><spring:message code="request.email.form.delete" /></button>
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
        <button type="button" class="btn" id="btnActive" data-dismiss="modal"><span class="glyphicon glyphicon-pencil"></span><spring:message code="button.edit" /></button>
        <button type="button" class="btn btn-default" id="btnClose" data-dismiss="modal"><spring:message code="button.cancel" /></button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
	var languageNow = "${pageContext.response.locale}";
	var selectRequired = "<spring:message code="request.email.validate.select.template" />"
	var updateSuccess= "<spring:message code="request.email.pnotify.update.success" />";
	var deleteSuccess= "<spring:message code="request.email.pnotify.delete.success" />";
	var updateFail= "<spring:message code="request.email.pnotify.update.fail" />";
	var deleteFail= "<spring:message code="request.email.pnotify.delete.fail" />";
	var editTitle= "<spring:message code="request.email.edit.templete.title" />";
	var editAsk= "<spring:message code="request.email.edit.templete.ask" />";
	var deleteTitle= "<spring:message code="request.email.delete.templete.title" />";
	var deleteAsk= "<spring:message code="request.email.delete.templete.ask" />";
	var delBtn= "<spring:message code="button.delete" />";
	var editBtn= "<spring:message code="button.edit" />";
	var pnotifyAdd="<spring:message code="pnotify.add"/>";
	var pnotifyEdit="<spring:message code="pnotify.edit"/>";
	var pnotifyDel="<spring:message code="pnotify.delete"/>";
	var pnotifySuccess="<spring:message code="pnotify.success"/>";
	var pnotifyError="<spring:message code="pnotify.error"/>";
	
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/email-create.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/resources/pageJS/email-active.js"></script>