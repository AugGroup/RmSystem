<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/resources/pageCss/email-create.css" />

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
					<ckeditor:replace replace="editor1" basePath="${ pageContext.request.contextPath }/static/resources/ckeditor/" />
					<%-- <ckeditor:replace replace="editor1" basePath="${ pageContext.request.contextPath }/static/ckeditor/" 
						config="<%= Config.createConfig() %>" events="<%= Config.createEventHandlers() %>" /> --%>
				</div>
			</div>
			<div class="col-sm-5">
				<div id="email-hints">
					<h3 class="text-center">Hints</h3>
					<p>$FIRSTNAME_EN</p>
				</div>
			</div>
		</div>
			
	</div>
</div>