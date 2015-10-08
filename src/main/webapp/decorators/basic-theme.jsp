<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.userdetails.User"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<script
	src='<c:url value ="/static/resources/js/jquery-1.11.3.min.js" />'></script>
<script src='<c:url value ="/static/resources/js/bootstrap.min.js"/>'></script>

<link rel="stylesheet" type="text/css" media="all" href="<c:url value ='/static/resources/css/bootstrap.min.css'/>"></link>
<link rel="stylesheet" type="text/css" media="all" href="<c:url value ="/static/resources/css/bootstrap-theme.min.css"/>" />
<link rel="stylesheet" type="text/css" media="all" href="<c:url value ='/static/resources/css/alertify.core.css'/>"></link>
<link rel="stylesheet" type="text/css" media="all" href="<c:url value ='/static/resources/css/alertify.bootstrap.css'/>"></link>
<script src='<c:url value ="/static/resources/js/alertify.js"/>'></script>

<script
	src='<c:url value ="/static/resources/js/bootstrap-datepicker.min.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all"
	href="<c:url value ="/static/resources/css/bootstrap-datepicker3.min.css"/>" />

<script
	src='<c:url value ="/static/resources/js/jquery.dataTables.min.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all"
	href="<c:url value ="/static/resources/css/jquery.dataTables.min.css"/>" />

<script
	src='<c:url value ="/static/resources/js/jquery.bootstrap.wizard.js"/>'></script>
<script
	src='<c:url value ="/static/resources/js/jquery.bootstrap.wizard.min.js"/>'></script>

<script
	src='<c:url value ="/static/resources/js/pnotify.custom.min.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all"
	href="<c:url value ="/static/resources/css/pnotify.custom.min.css"/>" />

<script
	src='<c:url value ="/static/resources/js/jquery.validate.min.js"/>'></script>
<script
	src='<c:url value ="/static/resources/js/additional-methods.min.js"/>'></script>

<%-- <script src='<c:url value ="/static/resources/js/jquery.inputmask.bundle.js" />'></script> --%>
<script src='<c:url value ="/static/resources/js/jquery.inputmask.bundle.min.js" />'></script>

<script src='<c:url value ="/static/resources/js/jquery.maskedinput.js" />'></script>
<script src='<c:url value ="/static/resources/js/date.js" />'></script>
<script src='<c:url value ="/static/resources/js/dataTables.bootstrap.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all" href="<c:url value ="/static/resources/css/dataTables.bootstrap.css"/>" />

<script src='<c:url value ="/static/resources/js/moment.js"/>'></script>
<script src='<c:url value ="/static/resources/js/daterangepicker.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all"
	href="<c:url value ="/static/resources/css/daterangepicker-bs3.css"/>" />

<link rel="stylesheet" type="text/css"
	href="<c:url value ="/static/resources/pageCss/infoCss.css"/>">

<link href='<c:url value="/static/resources/css/bootstrap.min.css"/>'
	rel="stylesheet" type="text/css"></link>
<link href='<c:url value="/static/resources/css/fullcalendar.css"/>'
	rel='stylesheet' type="text/css" />
<link
	href='<c:url value="/static/resources/css/fullcalendar.print.css"/>'
	rel='stylesheet' media='print' />
<link href='<c:url value="/static/resources/css/jquery-ui.min.css"/>'
	rel='stylesheet' />

<script src='<c:url value="/static/resources/js/moment-timezone.js"/>'></script>
<script src='<c:url value="/static/resources/js/fullcalendar.min.js"/>'></script>
<script src='<c:url value="/static/resources/js/calendar_lang-all.js"/>'></script>

<link rel="stylesheet" type="text/css"
	href="<c:url value ="/static/resources/pageCss/main.css"/>">
<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
</script>

</head>
<%
	User user = (User) SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
	String name = user.getUsername();
%>
<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
	var local = '${pageContext.response.locale}';
</script>

<link href="${ pageContext.request.contextPath }/static/resources/pageCss/email-main.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="${ pageContext.request.contextPath }/static/resources/pageJS/email-main.js"></script>

<body>
<nav class="navbar navbar-back">
	<div class="container-fluid " id="conDiv">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed top-toggle" data-toggle="collapse" data-target="#navbar-collapse" aria-expanded="false">
				<span class="sr-only">Toggle navigation</span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<img class="left-logo size-logo" id="logo" src="${pageContext.request.contextPath}/static/decorators/augmentis.jpg" alt="logo" />
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="navbar-collapse">
			<ul class="nav navbar-nav" id="headerTop">
				<li><a href="${pageContext.request.contextPath}/applicant"><span class="glyphicon glyphicon-home"></span></a></li>
				<li><a href="${pageContext.request.contextPath}/request" style=""><spring:message code="request.button" /></a></li>
				<li><a href="${pageContext.request.contextPath}/approve"><spring:message code="request.approve" /></a></li>
				<li><a href="${pageContext.request.contextPath}/calendar"><spring:message code="request.calendar" /></a></li>
				<li class="dropdown" >
				
					<a style="text-decoration: none;" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" 
						id="btn_email" data-toggle="tooltip" data-placement="right" title="<spring:message code="warning.appointment" />"><spring:message code="request.email" /> <span class="caret"></span>
					</a>
					<ul class="dropdown-menu" >
						<li><a href="${pageContext.request.contextPath}/email/create"><spring:message code="request.email.header.create" /></a></li>
						<li><a href="${pageContext.request.contextPath}/email/edit"><spring:message code="request.email.header.edit" /></a></li>
						<li><a href="${pageContext.request.contextPath}/email/write"><spring:message code="request.email.header.write" /></a></li>
	              		<li class="divider"></li>
	            		<li class="dropdown-submenu" id="email-appointment-new-parent">
	              			<a tabindex="-1" href="#">New Appointment Email</a>
	              			<ul class="dropdown-menu" id="email-appointment-new">
	              				<!-- <li><a href="#">send all appoinment success</a></li> -->
	               				<!-- <li><a href="#">Second level</a></li>
	               				<li><a href="#">Second level</a></li> -->
	              			</ul>
	            		</li>
	            		
	            		<li class="dropdown-submenu" id="email-appointment-update-parent">
	              			<a tabindex="-1" href="#">Update Appointment Email</a>
	              			<ul class="dropdown-menu" id="email-appointment-update">
	              			</ul>
	            		</li>
					</ul>
				</li>
			</ul>
		
			<ul class="nav navbar-nav navbar-right">
				<li id="bgLogout">						
					<a id="linkLogout" class="navbar-link" href="<c:url value="/logout"/>">
						<spring:message code="sitemesh.logout" /> | <%=name%>
					</a>
				</li>
			</ul>
			<div class="clearFloat"></div>
			<ul class="nav navbar-nav navbar-right" id="top-flag">
					<c:set var="locale">${pageContext.response.locale}</c:set>					
					<li class="flags-link" >
					
					<a id="flag-link" class="navbar-link" href="${request.getRequestURL}?locale=en" > 
						<b><img src="${pageContext.request.contextPath}/static/resources/images/flag_usa.png" alt="logo" class='img-flag ${ (locale eq "en") ? "img-active" : ""}' /></b>
					</a>
					
					<a id="flag-link" class="navbar-link" href="${request.getRequestURL}?locale=th" > 
						<img src="${pageContext.request.contextPath}/static/resources/images/flag_thailand.png" alt="logo" class='img-flag ${ (locale eq "th") ? "img-active" : ""}' />
					</a>
					
					</li>
					
					<li >
						<a style="text-decoration: none;" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
							<spring:message code="report.text" /> <span class="caret"></span>
						</a>
						<ul class="dropdown-menu" id="dropdown_report">
							<li><a href="${pageContext.request.contextPath}/report"><spring:message code="report.text" /></a></li>
							<li><a href="${pageContext.request.contextPath}/monthlyReport"><spring:message code="report.text.monthly" /></a></li>
						</ul>
					</li>
			
			</ul>
			
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</nav>

<div class="body" >
	<decorator:body />
</div>

<div class="footer">
	<div class="container">
		<p class="text-muted credit">&copy; 2011-2015 Augmentis (Thailand) Limited. All rights reserved.</p>
	</div>
</div>

</body>
</html>