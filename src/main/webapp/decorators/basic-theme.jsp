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

<title><decorator:title/></title>

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


<body background="${ pageContext.request.contextPath }/static/decorators/BG_W.jpg">

<jsp:include page="header.jsp" />
<div class="body" ><decorator:body /></div>
<div class="footer">
		<p class="text-muted credit">&copy; 2011-2015 Augmentis (Thailand) Limited. All rights reserved.</p>
</div>

</body>
</html>