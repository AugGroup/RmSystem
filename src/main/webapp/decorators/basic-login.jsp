
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title></title>

<script
	src='<c:url value ="/static/resources/js/jquery-1.11.3.min.js" />'></script>
<script src='<c:url value ="/static/resources/js/bootstrap.min.js"/>'></script>

<link rel="stylesheet" type="text/css" media="all"
	href="<c:url value ='/static/resources/css/bootstrap.min.css'/>"></link>
<link rel="stylesheet" type="text/css" media="all"
	href="<c:url value ="/static/resources/css/bootstrap-theme.min.css"/>" />

<script
	src='<c:url value ="/static/resources/js/bootstrap-datepicker.min.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all"
	href="<c:url value ="/static/resources/css/bootstrap-datepicker3.min.css"/>" />

<script
	src='<c:url value ="/static/resources/js/jquery.dataTables.min.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all"
	href="<c:url value ="/static/resources/css/jquery.dataTables.min.css"/>" />


<script
	src='<c:url value ="/static/resources/js/pnotify.custom.min.js"/>'></script>
<link rel="stylesheet" type="text/css" media="all"
	href="<c:url value ="/static/resources/css/pnotify.custom.min.css"/>" />

<script
	src='<c:url value ="/static/resources/js/jquery.validate.min.js"/>'></script>
<script
	src='<c:url value ="/static/resources/js/additional-methods.min.js"/>'></script>

<script
	src='<c:url value ="/static/resources/js/jquery.maskedinput.js" />'></script>
<script
	src='<c:url value ="/static/resources/js/jquery.maskedinput.min.js" />'></script>
<link rel="stylesheet" type="text/css" href="<c:url value ="/static/resources/pageCss/loginCss.css"/>">

<script src="<c:url value ="/static/resources/pageJS/aug-theme.js"/>"></script> 
</head>
<body>
	<div class="headLogo" id="headId">
		<img
			src="${pageContext.request.contextPath}/static/decorators/augmentis-logo-hires.png"
			alt="logo" style="width: 250px; height: 100px;" />
		<div class="form-group" align="right">
		<c:set var="locale">${pageContext.response.locale}</c:set>
			<a class='${ (locale eq "en") ? "" : "flag"}' href="${request.getRequestURL}?locale=en"> <img src="${pageContext.request.contextPath}/static/decorators/eng_flag.png"
				alt="logo" class="img-flag" style="width: 30px; height: 20px;" /></a> 
			<a class='${ (locale eq "th") ? "" : "flag"}' href="${request.getRequestURL}?locale=th"> <img src="${pageContext.request.contextPath}/static/decorators/thai_flag.jpg"
				alt="logo" class="img-flag" style="width: 30px; height: 20px;" /></a>

		</div>
	</div>
	<div>
		<decorator:body />
	</div>

	<div id="footer">
		<div class="container">
			<p class="text-muted credit">
				Copyright &copy; <a href="http://www.augmentis.biz/">
					augmentis.biz</a>
			</p>
		</div>
	</div>


</body>
</html>