<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.userdetails.User"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<script src='<c:url value ="/static/resources/js/jquery-1.11.3.min.js" />'></script>
<script src='<c:url value ="/static/resources/js/bootstrap.min.js"/>'></script>

<link rel="stylesheet" type="text/css" media="all" href="<c:url value ='/static/resources/css/bootstrap.min.css'/>"></link>
<link rel="stylesheet" type="text/css" media="all" href="<c:url value ="/static/resources/css/bootstrap-theme.min.css"/>" />

<script src='<c:url value ="/static/resources/js/bootstrap-datepicker.min.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all" href="<c:url value ="/static/resources/css/bootstrap-datepicker3.min.css"/>" />

<script src='<c:url value ="/static/resources/js/jquery.dataTables.min.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all" href="<c:url value ="/static/resources/css/jquery.dataTables.min.css"/>" />

<script src='<c:url value ="/static/resources/js/jquery.bootstrap.wizard.js"/>'></script>
<script src='<c:url value ="/static/resources/js/jquery.bootstrap.wizard.min.js"/>'></script>

<script src='<c:url value ="/static/resources/js/pnotify.custom.min.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all" href="<c:url value ="/static/resources/css/pnotify.custom.min.css"/>" />

<script src='<c:url value ="/static/resources/js/jquery.validate.min.js"/>'></script>
<script src='<c:url value ="/static/resources/js/additional-methods.min.js"/>'></script>

<script src='<c:url value ="/static/resources/js/jquery.inputmask.bundle.js" />'></script>
<script src='<c:url value ="/static/resources/js/jquery.inputmask.bundle.min.js" />'></script>
 
 <%-- 	<script src='<c:url value ="/static/resources/js/fileinput.min.js"/>'></script>
	<link rel="stylesheet" type="text/css" media="all" href="<c:url value ="/static/resources/css/fileinput.min.css"/>" />
 --%>
<script src='<c:url value ="/static/resources/js/jquery.maskedinput.js" />'></script>
<script src='<c:url value ="/static/resources/js/jquery.maskedinput.js" />'></script>

<script src='<c:url value ="/static/resources/js/dataTables.bootstrap.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all" href="<c:url value ="/static/resources/css/dataTables.bootstrap.css"/>" />

<script src='<c:url value ="/static/resources/js/moment.js"/>'></script>
<script src='<c:url value ="/static/resources/js/daterangepicker.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all" href="<c:url value ="/static/resources/css/daterangepicker-bs3.css"/>" />

<link rel="stylesheet" type="text/css" href="<c:url value ="/static/resources/pageCss/main.css"/>">

<link rel="stylesheet" type="text/css" href="<c:url value ="/static/resources/pageCss/infoCss.css"/>">

<link href='<c:url value="/static/resources/css/bootstrap.min.css"/>' rel="stylesheet" type="text/css"></link>
<link href='<c:url value="/static/resources/css/fullcalendar.css"/>' rel='stylesheet' type="text/css"/>
<link href='<c:url value="/static/resources/css/fullcalendar.print.css"/>' rel='stylesheet' media='print' />


<script src='<c:url value="/static/resources/js/moment-timezone.js"/>'></script>
<%-- <script src='<c:url value="/static/resources/js/jquery-1.11.3.min.js"/>'></script> --%>
<script src='<c:url value="/static/resources/js/fullcalendar.min.js"/>'></script>

</head>
<%
	User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String name = user.getUsername();
%>
<script type="text/javascript">
	var local = '${pageContext.response.locale}';
</script>

<body>
	<div class="headed">
		<div class="headLogo" id="headId">
			<img id="logo" src="${pageContext.request.contextPath}/static/decorators/augmentis.jpg" alt="logo"/>
			<a href="${pageContext.request.contextPath}/applicant"><span class="glyphicon glyphicon-home"></span></a>
			<a href="${pageContext.request.contextPath}/request"><spring:message code="request.button" /></a>
			<a href="${pageContext.request.contextPath}/approve"><spring:message code="request.approve" /></a>
			<a href="${pageContext.request.contextPath}/calendar"><spring:message code="request.calendar" /></a>
			<%-- <a href="${pageContext.request.contextPath}/email/create"><spring:message code="request.email" /></a> --%>
			<div class="btn-group">
				<button type="button" class="btn btn-defult dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
					id="btn_email"> <spring:message code="request.email" /> <span class="caret"></span>
				</button>
				<ul class="dropdown-menu" id="dropdown_report">
					<li><a href="${pageContext.request.contextPath}/email/create"><spring:message code="request.email.header.create" /></a></li>
					<li><a href="${pageContext.request.contextPath}/email/edit"><spring:message code="request.email.header.edit" /></a></li>
				</ul>
			</div>
			
			<div class="user">
				<a href="<c:url value="/logout"/>"><span class="glyphicon glyphicon-log-out"></span> <spring:message code="sitemesh.logout" /></a>
				<a href=""><span class="glyphicon glyphicon-user"></span> <%=name %></a>
				<div class="user2">
				<c:set var="locale">${pageContext.response.locale}</c:set>
					<a class='${ (locale eq "en") ? "" : "flag"}' href="${request.getRequestURL}?locale=en" id="en"> <img src="${pageContext.request.contextPath}/static/decorators/eng_flag.png" alt="logo" class="img-flag" /></a>
					<a class='${ (locale eq "th") ? "" : "flag"}' href="${request.getRequestURL}?locale=th" id="th"> <img src="${pageContext.request.contextPath}/static/decorators/thai_flag.jpg"	alt="logo" class="img-flag" /></a>
					<div class="btn-group">
						<button type="button" class="btn btn-defult dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
							id="btn_report"> <spring:message code="report.text" /><span class="caret"></span>
						</button>
						<ul class="dropdown-menu" id="dropdown_report">
							<li><a href="${pageContext.request.contextPath}/report"><spring:message code="report.text" /></a></li>
							<li><a href="${pageContext.request.contextPath}/monthlyReport"><spring:message code="report.text.monthly" /></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="body">
		<decorator:body />
	</div>

	<div class="footer">
		<div class="container">
			<p class="text-muted credit">&copy; 2011-2015 Augmentis (Thailand) Limited. All rights reserved.</p>
		</div>
	</div>
</body>
</html>