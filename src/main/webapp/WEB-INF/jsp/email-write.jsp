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
					<form>
		  				<div class="form-group">
		    				<label for="receiver">To:</label>
		    				<select class="form-control" id="receiver" name="receiver">
								<option value=""><spring:message code="request.email.form.select.init.applicant" /></option>
								<c:forEach items="${applicants}" var="applicant">
									<option value="${applicant.id}">${applicant.firstNameEN}&nbsp${applicant.lastNameEN}&nbsp(${applicant.technology.name}&nbsp${applicant.joblevel.name})</option>
								</c:forEach>
							</select>
		  				</div>
		  				<div class="form-group">
							<label for="name"><spring:message code="request.email.form.template.name" /> :</label>
							<select class="form-control" id="mailTemplate" name="selectTemplate">
								<option value=""/><spring:message code="request.email.form.select.init.template" /></option>
								<c:forEach items="${mailTemplate}" var="mailTemplate">
									<option value="${mailTemplate.id}">${mailTemplate.name}</option>
								</c:forEach>
							</select>
						</div>
		  				<button type="submit" class="btn btn-default">Submit</button>
					</form>
				</div>
				<div class="col-sm-6">
					
				</div>
			</div>
		</div>
	</div>
</div>