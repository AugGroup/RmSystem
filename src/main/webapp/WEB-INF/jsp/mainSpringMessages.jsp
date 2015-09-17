<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="<c:url value ="/static/resources/js/aug-request.js"/>"></script> 
<script type="text/javascript">
var reqName = "<spring:message code="valid.req.name"/>"; 
var reqDate = "<spring:message code="valid.req.date"/>"; 
var reqPosition = "<spring:message code="valid.req.position"/>"; 
var reqApproval = "<spring:message code="valid.req.approval"/>"; 
var approveDate = "<spring:message code="valid.req.approve.date"/>"; 
var reqApplicant = "<spring:message code="valid.req.applicant"/>"; 
var infoTelNumber = "<spring:message code="valid.info.tel.number"/>"; 
var reqSkill = "<spring:message code="valid.req.skill"/>"; 
var reqYear = "<spring:message code="valid.req.year"/>"; 
var reqStatus = "<spring:message code="valid.req.status"/>"; 

var preview_tx = '<spring:message code="request.preview"/>';
var edit_tx = '<spring:message code="main.edit.info"/>';
var delete_tx = '<spring:message code="main.delete"/>';
</script>
