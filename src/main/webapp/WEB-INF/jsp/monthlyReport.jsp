<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title><spring:message code="report.text.monthly" /></title>
<link rel="stylesheet" type="text/css" href="<c:url value ="/static/resources/pageCss/monthlyReport.css"/>">
<script src="<c:url value ="/static/resources/pageJS/monthly-report.js"/>"></script> 

<script>
var datatablei18n = "<c:url value='/static/resources/dt-i18n/${pageContext.response.locale}.json' />";
</script>

<script type="text/javascript">
$(document).ready(function(){
	$("#btn_report").addClass('active-menu'); 
	$("#monthlyPage").addClass('active-menu'); 
});
</script>

<div class="container">
<!------------------- Report header-------------------> 
 	<div class="row"><h1 align="center"><spring:message code="report.text.monthly"/></h1></div>
 
<!------------------- Report search-------------------> 
	<div class="container">
	<div class="report_search " align="right" style="float: right;">
		<f:form method="post" name="reportForm" target="_blank" commandName="searchReportDTO" action="${pageContext.request.contextPath}/reportMonthly/preview" cssClass="form-inline">
   			<div class="search_inputgroup" >
   				<div class="form-group" id="radio_inputgroup">
   					<label for="reportType"><spring:message code="report.text.type"/> </label>
					<input type="radio" value="pdf" id="reportType" name="reportType" checked="checked"> <spring:message code="report.text.pdf"/> 
					<input type="radio" value="xls" id="reportType" name="reportType"> <spring:message code="report.text.xls"/> 
    			</div>
    			<button type="button" class="btn btn-primary submit" id="btn_preview" data-toggle="modal" data-target="#previewReportModal" ><span class="glyphicon glyphicon-search"></span> <spring:message code="request.preview"/> </button>		 				
		 	</div>
		 	
		 	<div class="search_inputgroup">
				<div class="form-group">
					<label for="applyDateStr"><spring:message code="report.text.search.month"/></label>
					<input type="text" name="applyDateStr" id="applyDateStr" class="form-control" placeholder="<spring:message code="report.text.month"/>"/>
            	</div>
       			<button type="button" class="btn btn-primary" id="btn_search"><span class="glyphicon glyphicon-search"></span> <spring:message code="main.button.search"/> </button>				
   			</div>
	
		</f:form>
	</div>
	</div>
	<!------------------- Report DataTable-------------------> 
	<div class="table-responsive" id="table2">
    	<table  id="reportTable" class="cell-border" style="width: 100%">
    	<caption title="" class="tableHeader"><spring:message code="report.text.monthly" /></caption>
            <thead>
                <tr>
                    <th><spring:message code="main.code"/></th>
                    <th><spring:message code="info.apply.date"/></th>
                  	<th><spring:message code="main.name"/></th>
                    <th><spring:message code="main.position1"/></th>
                    <th><spring:message code="main.position2"/></th>
                    <th><spring:message code="report.data.school"/></th>
                    <th><spring:message code="education.degree"/></th>
                    <th><spring:message code="education.data.gpa"/></th>
                </tr>
            </thead>
         </table>
     </div>
     
</div>
