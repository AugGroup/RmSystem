<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title><spring:message code="report.text" /></title>

<script src="<c:url value ="/static/resources/pageJS/main-report.js"/>"></script> 

<script>
var datatablei18n = "<c:url value='/static/resources/dt-i18n/${pageContext.response.locale}.json' />";
</script>

<style>
.report_preview {
	margin-right: 0px;
	float: right;
}

.div_btn_search{
	float: right;
}

@media (max-width: 1100px){
}

@media (min-width: 768px){
	.form-inline .form-control {
	    display: inline-block;
	    width: 100%;
	    vertical-align: middle;
	    font-size: 10px;
	}
	
	#divCon{
		width: 100%;
	}
	
	.report_search {
		float:left;
	    width: 100%;
	}
}

@media (min-width: 960px){
	.report_preview {
	    margin-right: 25px;
	    float: right;
	}
}

@media (max-width: 960px){
	.report_preview {
	    margin-right: 25px;
	    float: right;
	}
}

@media (max-width: 768px){
	.form-inline .form-control {
	    display: inline-block;
	    width: 100%;
	    vertical-align: middle;
	    font-size: 14px;
	}
	
	.search_inputgroup {
		width: 100%;
		float: none;
		margin: 0px;
		padding: 0px;
	}
	
	.report_search {
	    width: 100%;
	}
	
	#divCon{
		width: 100%;
		float: right;
	}
	
	#radio_inputgroup {
    	margin: 15px 15px 0px 5px;
	}
}

</style>

<div class="container">
	<!------------------- Report header------------------->
	<div class="row">
		<h1 align="center">
			<spring:message code="report.text" />
		</h1>
	</div>

	<!------------------- Report search------------------->
	<div class="container" id="divCon">
	<div class="report_search">
		<f:form method="post" name="reportForm" target="_blank" commandName="searchReportDTO"
			action="${pageContext.request.contextPath}/report/preview" cssClass="form-inline">
			<div class="row">
				<div class="search_inputgroup">
				<div class="report_search">
				<%-- <h3><spring:message code="report.text.search" /></h3> --%>
				
					<div class="form-group">
						<input type="hidden" id="jobLevelId" name="jobLevelId">
						<input type="hidden" id="technologyId" name="technologyId">
					</div>
					
					
					<div class="col-sm-12">
								<div class="col-sm-12 col-md-2">
									<label for="joblevel"><spring:message code="main.position1" /></label><br>
									<select name="joblevel" id="joblevel" class="form-control" >
									<option value="-1" label="---Select Joblevel---" />
										<c:forEach items="${jobLevels}" var="jobLevelList">
											<option value="${jobLevelList.id}">${jobLevelList.name}</option>
										</c:forEach>
									</select>
								</div>	
							
	
								<div class="col-sm-12 col-md-2">
									<label for="technology"><spring:message code="main.position2" /></label><br> 
									<select name="technology" id="technology" class="form-control">
									<option value="-1" label="---Select Technology---" />
										<c:forEach items="${technologies}" var="technologyList">
											<option value="${technologyList.id}">${technologyList.name}</option>
										</c:forEach>
									</select> 
								</div>
								
					 			<div class="col-sm-12 col-md-2">
					 				<label for="masdegreetype"><spring:message code="education.degree"/></label><br>
					 				<select class="form-control" id="masdegreetype" name="masdegreetype">
										<option value="-1" label="---Select DegreeType---" />
										<c:forEach var="obj" items="${degreeTypes}">
											<option value="${obj.id}">${obj.name}</option>
										</c:forEach>
									</select>
								</div> 
								
								<div class="col-sm-12 col-md-2">
									<label for="major"><spring:message code="education.major" /></label>
									<input type="text" class="form-control" id="major" name="major" placeholder="<spring:message code="education.text.major"/>">
								</div>
								
								<div class="col-sm-12 col-md-1">
									<label for="gpa"><spring:message code="education.gpa" /></label>
									<!-- step="0.1" -->
									<input type="text" class="form-control" maxlength="5" id="gpa" name="gpa" placeholder="0.00">
								</div>
								
								<div class="col-sm-12 col-md-2">
									<label for="university"><spring:message code="report.text.school" /></label> 
									<input type="text" class="form-control" id="university" name="university" 
									placeholder="<spring:message code="report.enter.school"/>">
								</div>
								
								<div class="col-sm-12 col-md-1">
									<div class="div_btn_search">
										<button type="button" class="btn btn-primary" id="btn_search">
											<span class="glyphicon glyphicon-search"></span><spring:message code="main.button.search" />
										</button>
									</div>
								</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row" >
				<div class="report_preview">
					<div class="search_inputgroup">
							<div class="form-group" id="radio_inputgroup">
								<label for="reportType"><spring:message code="report.text.type" /> </label> 
								<input type="radio" value="pdf" id="reportType" name="reportType" checked="checked"><spring:message code="report.text.pdf" />
								<input type="radio" value="xls" id="reportType" name="reportType"><spring:message code="report.text.xls" />
							</div>
							
							<button type="button" class="btn btn-primary submit" data-toggle="modal" data-target="#previewReportModal" id="btn_preview">
								<span class="glyphicon glyphicon-search"></span><spring:message code="request.preview" />
							</button>
					</div>
				</div>
			</div>

		</f:form>
	</div>
	</div>


	<!------------------- Report DataTable------------------->

	<div class="table-responsive" id="table2">
		<table class="dataTable" id="reportTable" class="cell-border" style="width: 100%">

		<caption title="" class="tableHeader"><spring:message code="report.text" /></caption>
			<thead>
				<tr>
					<th><spring:message code="main.code" /></th>
					<th><spring:message code="info.apply.date" /></th>
					<th><spring:message code="main.name" /></th>
					<th><spring:message code="main.position1" /></th>
					<th><spring:message code="main.position2" /></th>
					<th><spring:message code="report.data.school" /></th>
					<th><spring:message code="education.degree" /></th>
					<th><spring:message code="education.data.gpa" /></th>
				</tr>
			</thead>
		</table>
	</div>
</div>
