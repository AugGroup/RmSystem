<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>

<title><spring:message code="applicant.submit.login" /></title>

<style type="text/css">
.error {
	color: red;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	$('#loginForm').validate({
        rules: {
            j_username: "required",
            j_password: {
                required: true
            }
        },
        messages: {
            j_username: {
            	required: "Please enter your username"
            },
            j_password: {
                required: "Please enter a password",
        	}
        }
    });
});
</script>
<!-- 	<h1>Log-In</h1> -->

<div class="container">
	<form class="form-group" id="loginForm"
		action="${pageContext.request.contextPath}/j_spring_security_check"
		method="post">
		<div class="form-group">
			<label for="userName"><spring:message
					code="applicant.username" /></label> <input type="text"
				class="form-control" name="j_username">
		</div>
		<div class="form-group">
			<label for="password" class="control-label"><spring:message
					code="applicant.password" /></label> <input type="password"
				class="form-control" name="j_password">
		</div>

		<button type="submit" id="btnSubmit" class="btn btn-primary btn-md">
			<span class="glyphicon glyphicon-log-in"></span>
			<spring:message code="applicant.submit.login" />
		</button>
		<div style="color: red">
			${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</div>
	</form>
</div>