<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>

<!DOCTYPE html>
<html>
<head>
<script src='<c:url value ="/static/resources/js/jquery-1.11.3.min.js" />'></script>
<script src='<c:url value ="/static/resources/js/bootstrap.min.js"/>'></script>

<link rel="stylesheet" type="text/css" media="all" href="<c:url value ='/static/resources/css/bootstrap.min.css'/>"></link>
<link rel="stylesheet" type="text/css" media="all" href="<c:url value ="/static/resources/css/bootstrap-theme.min.css"/>" />

<script src='<c:url value ="/static/resources/js/jquery.bootstrap.wizard.js"/>'></script>
<script src='<c:url value ="/static/resources/js/jquery.bootstrap.wizard.min.js"/>'></script>

<script src='<c:url value ="/static/resources/js/jquery.validate.min.js"/>'></script>
<script src='<c:url value ="/static/resources/js/additional-methods.min.js"/>'></script>

<title>Error 503 page</title>
</head>
<script type="text/javascript">
$(document).ready(function () {
	$('#btn_submit').trigger("click");

});
</script>

<body>
	<f:form action="${pageContext.request.contextPath}/errorPages/error503" method="get">
		<input type="submit" id="btn_submit" style="visibility: hidden;" value="submit"/>
	</f:form>
</body>
</html>


