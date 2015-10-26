<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<title><spring:message code="applicant.table.head" /></title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/pageCss/main.css" />
<script src="<c:url value ="/static/resources/pageJS/main-applicant.js"/>"></script> 

<script type="text/javascript">
var valScore = "<spring:message code="valid.score"/>";
var valTech = "<spring:message code="valid.tech"/>";
var valAttHome = "<spring:message code="valid.attitude.home"/>";
var valAttOffice = "<spring:message code="valid.attitude.office"/>";
var valStatus = "<spring:message code="valid.status"/>";
var editScore_text = "<spring:message code="edit.button.edit.score"/>"; 
var editInfo_text = "<spring:message code="main.edit.info"/>"; 
var delete_text = "<spring:message code="main.delete"/>";
var pnotifyAdd="<spring:message code="pnotify.add"/>";
var pnotifyEdit="<spring:message code="pnotify.edit"/>";
var pnotifyDel="<spring:message code="pnotify.delete"/>";
var pnotifySuccess="<spring:message code="pnotify.success"/>";
var pnotifyError="<spring:message code="pnotify.error"/>";
var datatablei18n = "<c:url value='/static/resources/dt-i18n/${pageContext.response.locale}.json' />";
</script>
<style>
	#btnScore{
		width: 400px;
	}
/* max-width  960px */
@media ( max-width : 960px) {
	#btnScore{
		width: 200px;
	}
}
	
</style>

<script type="text/javascript">
$(document).ready(function(){
	$("#applicantPage").addClass('active-menu'); 
});
</script>

<div class="container">
<div><h1 align="center"><spring:message code="applicant.table.head" /></h1></div>
	<!--Input text for Search Applicant -->
	<div class="row" id="search_row">
		<div class="col-md-8"></div>
		<div class="col-md-4">
			<div class="input-group">
				<input type="text" class="form-control" id="inputSearch" placeholder="<spring:message code="main.text.field"/>" /> 
				<span class="input-group-btn">
					<button type="button" class="btn btn-primary" id="btn_search">
						<span class="glyphicon glyphicon-search"></span>
						<spring:message code="main.button.search" />
					</button>
				</span>
			</div>
		</div>
	</div>
	<!--Data Table for Applicant List -->
	<c:set var="ss" value="display:none;"></c:set>
	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_STAFF','ROLE_HR')">
		<div class="container table-responsive" id="table2">
			<table  class="dataTable" id="dataTable" class="cell-border" style="width: 100%" >
			<caption title="" class="tableHeader"><spring:message code="applicant.table.head" /></caption>
				<thead>
					<tr>
						<th><spring:message code="main.code" /></th>
						<th><spring:message code="main.date" /></th>
						<th><spring:message code="main.name" /></th>
						<th><spring:message code="main.position1" /></th>
						<th><spring:message code="main.position2" /></th>
						<th><spring:message code="main.status" /></th>
						<th><spring:message code="main.edit" /></th>
						<th><spring:message code="main.edit.info" /></th>
						<th><spring:message code="main.delete" /></th>
					</tr>
				</thead>
			</table>
			<a type="submit" id="btn_new_app" class="btn btn-warning" href="${pageContext.request.contextPath}/informations">
			<span class="glyphicon glyphicon-plus "></span><spring:message code="main.button.add" /></a>
<!-- 			<button id="btn_add" name="btn_add" type="button" class="btn btn-warning " data-toggle="modal" data-target="#myModal" ><span class="glyphicon glyphicon-plus"></span> Add New Applicant</button> -->
		</div>
	</sec:authorize>


	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_STAFF')">
		<!-- Modal of Edit Status and Score-->
		<div id="EditStatusModal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title"><spring:message code="edit.title" /> </h4>
					</div>
					<div class="modal-body">
						<h5> <spring:message code="edit.score.detail" /></h5>
						<form role="form" id="EditStatusForm">
							<div class="form-group" style="width: 200px">
								<label for="inputScore"><spring:message code="edit.score" /></label> 
								<input type="text" class="form-control" id="inputScore" name="inputScore" placeholder="<spring:message code="edit.text.feild"/>">
							</div>
							<div class="form-group">
								<label for="nameTechScore"><spring:message code="edit.tech.score" /></label>
								<label class="radio-inline"> <input type="radio" value="Pass" id="inputTechScore" name="inputTechScore">
								<spring:message code="edit.radio.pass" /></label>
								<label class="radio-inline"> <input type="radio" value="Not" id="inputTechScore" name="inputTechScore">
								<spring:message code="edit.radio.notPass" /></label>
								<span id="error-approve"></span>
							</div>
							<div class="form-group">
								<label for="inputScore"><spring:message code="edit.attitude.score" /> </label>
								<div id="btnScore" class="form-group" class="form-inline">
									<div class="row">
										<div class="col-md-6">
											<label for="inputAttitudeHome"><spring:message code="edit.attitude.home" /></label> 
											<input type="text" class="form-control" id="inputAttitudeHome" name="inputAttitudeHome" placeholder="<spring:message code="edit.text.feild"/>">
										</div>
										<div class="col-md-6">
											<label for="inputAttitudeOffice"><spring:message code="edit.attitude.office" /></label> 
											<input type="text" class="form-control" id="inputAttitudeOffice" name="inputAttitudeOffice" placeholder="<spring:message code="edit.text.feild"/>">
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="inputStatus"><spring:message code="edit.status" /></label> 
								<select name="inputStatus" id="inputStatus" class="form-control">
									<option value="Pending Test/Interview"><spring:message code="edit.pending.test" /></option>
									<option value="Pending Approve"><spring:message code="edit.pending.approve" /></option>
									<option value="Approve"><spring:message code="edit.approve" /></option>
									<option value="Not Approve"><spring:message code="edit.notApprove" /></option>
								</select>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" id="btn_submit" class="btn btn-warning" data-dismiss="alert"><span class="glyphicon glyphicon-save"></span><spring:message code="edit.button.save" /></button>
						<button type="button" id="btn_close" class="btn btn-default" data-dismiss="modal"><spring:message code="button.cancel" /></button>
					</div>
				</div>
			</div>
		</div>
	</sec:authorize>

	<!-- Delete Model -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
		aria-labelledby="ModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="ModalLabel"><spring:message code="delete.title" /></h4>
				</div>
				<div class="modal-body">
					<h4 class="modal-title" id="ModalLabel"><spring:message code="delete.confirm.title" /></h4><br>
					<div align="right">
						<button id="btn_delete_submit" type="button" class="btn btn-danger" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove-sign"></span><spring:message code="main.delete" />
						</button>
						<button id="btn_close" type="button" class="btn btn-default" data-dismiss="modal">
							<spring:message code="button.cancel" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- <!-- 		Add New Applicnt --> -->
<!-- 	<div class="modal fade" id="myModal" role="dialog"> -->
<!-- 			<div class="modal-dialog"> -->
			
<!-- 				<div class="modal-content"> -->
<!-- 					<div class="modal-header" style="padding: 35px 50px;"> -->
<!-- 						<button type="button" class="close" data-dismiss="modal">&times;</button> -->
<!-- 						<h4> -->
<!-- 							<span class="glyphicon glyphicon-lock"></span> New Applicant -->
<!-- 						</h4> -->
<!-- 					</div> -->
<!-- 					<div class="modal-body" style="padding: 40px 50px;"> -->
<%-- 						<form role="form" id="add_new" > --%>
						
<!-- <!-- ********************	information	  ******************** --> -->
		
<%-- 									<label for="firstNameTh"><spring:message code="info.firstname.th"/></label> --%>
<%-- 									<spring:message code="info.text.first.th" var="firstname"/><br> --%>
<%-- 									<input id="firstNameTH" name="firstNameTH" placeholder="${firstname}" class="form-control btn-information" type="text"></input>					 --%>
<%-- 									<label for="lastnameTh"><spring:message code="info.lastname.th"/></label> --%>
<%-- 									<spring:message code="info.text.last.th" var="lastname"/><br> --%>
<%-- 									<input id="lastNameTH" name="lastNameTH" placeholder="${lastname}" class="form-control btn-information" type="text"></input> --%>
<%-- 									<label for="nickNameTh"><spring:message code="info.nickname.th"/></label> --%>
<%-- 									<spring:message code="info.text.nick.th" var="nickname"/><br> --%>
<%-- 									<input  id="nickNameTH" name="nickNameTH" placeholder="${nickname}" class="form-control btn-information" type="text"></input> --%>
<%-- 									<label for="firstNameEng"><spring:message code="info.firstname.en"/></label> --%>
<%-- 									<spring:message code="info.text.first.en" var="firstnameEn"/><br> --%>
<%-- 									<input id="firstNameEN" name="firstNameEN" placeholder="${firstnameEn}" class="form-control btn-information" type="text"></input> --%>
<%-- 									<label for="lastnameEng"><spring:message code="info.lastname.en"/> </label> --%>
<%-- 									<spring:message code="info.text.last.en" var="lastnameEn"/><br> --%>
<%-- 									<input id="lastNameEN" name="lastNameEN" placeholder="${lastnameEn}" class="form-control btn-information" type="text"></input> --%>
<%-- 									<label for="nickNameEng"><spring:message code="info.nickname.en"/></label> --%>
<%-- 									<spring:message code="info.text.nick.en" var="nicknameEn"/><br> --%>
<%-- 									<input id="nickNameEN" name="nickNameEN" placeholder="${nicknameEn}" class="form-control btn-information" type="text"></input> --%>
<%-- 									<label for="eMail"><spring:message code="info.email"/></label> --%>
<%-- 									<spring:message code="info.text.email" var="email"/><br> --%>
<%-- 									<input id="email" name="email" type="email" placeholder="${email}" class="form-control btn-information"></input> --%>
<%-- 								<label for="jobLevel"><spring:message code="main.position1"/></label><br> --%>
<!-- 								 <div id="jobLevelLists"> -->
<!-- 									<select  id="joblevel" class="form-control" > -->
<%-- 									<c:forEach var ="jobLevelList" items="${jobLevels}" > --%>
<%-- 				    						<option  value=""><spring:message code="info.select.data"/></option> --%>
<%-- 				  							<option value="${jobLevelList.id}" >${jobLevelList.name}</option> --%>
<%-- 			                    	</c:forEach> --%>
<!-- 										</select> -->
<!-- 											<br><label for="jobLevel" class="error" ></label> -->
<!-- 								</div> -->
								
                        							
								
								
<!-- 								<br> -->
<!-- 								<br> -->
<!-- 								<button type="button" class="btn btn-success" id="buttonSave"> -->
<!-- 									<span class="glyphicon glyphicon-off"></span> Save -->
<!-- 								</button> -->
<!-- 								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
								
<%-- 							</form> --%>
<!-- 						</div> -->
<!-- 						<div class="modal-footer"> -->
<!-- 							<p> -->
<!-- 								Please fill your information -->
<!-- 							</p> -->
<!-- 						</div> -->
<!-- 					</div> -->
	
<!-- 				</div> -->
<!-- 			</div> -->







</div>
