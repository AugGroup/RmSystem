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
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<link rel="stylesheet" type="text/css" href="<c:url value ="/static/resources/pageCss/header.css"/>">
<%
	User user = (User) SecurityContextHolder.getContext()
			.getAuthentication().getPrincipal();
	String name = user.getUsername();
%>


<nav class="navbar navbar-back">
	<div id="top-con" class="container-fluid ">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed top-toggle" data-toggle="collapse" data-target="#navbar-collapse" aria-expanded="false">
				<span class="sr-only">Toggle navigation</span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<img  id="logo" src="${pageContext.request.contextPath}/static/decorators/augmentis.jpg" alt="logo" />
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="navbar-collapse">
			<ul class="nav navbar-nav" id="nav-menu">
				<li><a href="${pageContext.request.contextPath}/applicant" id="applicantPage"><span class="glyphicon glyphicon-home "></span></a></li>
				<sec:authorize access="hasAnyRole('ROLE_STAFF','ROLE_ADMIN')">
					<li><a href="${pageContext.request.contextPath}/request" id="requestPage"><spring:message code="request.button" /></a></li>
				</sec:authorize>
				<sec:authorize access="hasAnyRole('ROLE_HR','ROLE_ADMIN')">
					<li><a href="${pageContext.request.contextPath}/approve" id="approvePage"><spring:message code="request.approve" /></a></li>
				</sec:authorize>
				<li><a href="${pageContext.request.contextPath}/calendar" id="calendarPage"><spring:message code="request.calendar" /></a></li>
				<li class="dropdown emailPage" id="email-dropdown">
					<a  href="#" class="dropdown-toggle emailPage" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" 
						id="btn_email" data-toggle="tooltip" data-placement="right" title="<spring:message code="warning.appointment" />"><spring:message code="request.email" /> <span class="badge" id="email-badge"></span> <span class="caret"></span>
					</a>
					<ul class="dropdown-menu sub-menu" id="sub-menu-email">
						<li  ><a href="${pageContext.request.contextPath}/email/create" id="emailCreatePage"><spring:message code="request.email.header.create" /></a></li>
						<li id="emailEditPage"><a href="${pageContext.request.contextPath}/email/edit"><spring:message code="request.email.header.edit" /></a></li>
						<li id="emailWritePage"><a href="${pageContext.request.contextPath}/email/write"><spring:message code="request.email.header.write" /></a></li>
	              		<li class="divider"></li>
	            		<li class="dropdown-submenu" id="email-appointment-new-parent">
	              			<a tabindex="-1" href="#"><spring:message code="request.email.new.appointment" /></a>
	              			<ul class="dropdown-menu" id="email-appointment-new">
	              				<!-- <li><a href="#">send all appoinment success</a></li> -->
	               				<!-- <li><a href="#">Second level</a></li>
	               				<li><a href="#">Second level</a></li> -->
	              			</ul>
	            		</li>
	            		
	            		<li class="dropdown-submenu" id="email-appointment-update-parent">
	              			<a tabindex="-1" href="#"><spring:message code="request.email.update.appointment" /></a>
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
					
					<a id="flag-link" class="navbar-link" href="${request.getRequestURL}?locale=th" > 
						<img src="${pageContext.request.contextPath}/static/resources/images/flag_thailand.png" alt="logo" class='img-flag ${ (locale eq "th") ? "flag-active" : ""}' />
					</a>
					
					<a id="flag-link" class="navbar-link" href="${request.getRequestURL}?locale=en" > 
						<img src="${pageContext.request.contextPath}/static/resources/images/flag_usa.png" alt="logo" class='img-flag ${ (locale eq "en") ? "flag-active" : ""}' />
					</a>
					
					</li>
					
					<li >
						<a href="#" id="btn_report" class="dropdown-toggle " data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
							<spring:message code="report.text" /> <span class="caret"></span>
						</a>
						<ul class="dropdown-menu sub-menu" id="dropdown_report">
							<li><a href="${pageContext.request.contextPath}/report" id="reportPage" ><spring:message code="report.text" /></a></li>
							<li><a href="${pageContext.request.contextPath}/monthlyReport" id="monthlyPage"><spring:message code="report.text.monthly" /></a></li>
						</ul>
					</li>
			
			</ul>
			
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</nav>