<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="<c:url value ="/static/resources/pageJS/aug-experiences.js"/>"></script> 

<script>
var valWorkBackground = "<spring:message code="valid.ex.pre"/>";
var valFromYear = "<spring:message code="valid.ex.from"/>";
var valToYear = "<spring:message code="valid.ex.to"/>";
var valEmp = "<spring:message code="valid.ex.emp"/>";
var valAddress = "<spring:message code="valid.addr.addr"/>";
var valType = "<spring:message code="valid.ex.type"/>";
var valPosition = "<spring:message code="valid.ex.position"/>";
var valSupervisor = "<spring:message code="valid.ex.supervisor"/>";
var valSalary = "<spring:message code="valid.ex.salary"/>";
var valDescription = "<spring:message code="valid.ex.des"/>";
var valReason = "<spring:message code="valid.ex.reason"/>";
var valEdit = "<spring:message code="main.edit.info"/>";
var valDelete = "<spring:message code="main.delete"/>";
var id = ${id};
</script>

<jsp:include page="applicationMenu.jsp" />
<div class="container" id="titleHead">
	<div class="form-group">
		<label for="experiences" id="text"><spring:message code="exp.text" /> </label>
	</div>
	<br>
		<div class="row">
			<div class="col-sm-12 col-xs-12 col-md-12 col-lg-12">
				<h3 id="textTitle"><spring:message code="exp.name"/></h3>
			</div>
		</div>
		<div class="modal fade" id="experiencesModal" role="dialog">
			<div class="modal-dialog">

				<div class="modal-content">
					<div class="modal-header" style="padding: 35px 50px;">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4>
							<span class="glyphicon glyphicon-lock"></span>
							<spring:message code="exp.name" />
						</h4>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
						<form role="form" id="experiencesForm">
							<div class="form-group">
								<input type="hidden" id="applicant" name="applicant"
									value="${id}">
							</div>

							<div class="form-group">
								<label for="workBackground"><spring:message
										code="exp.position" /> </label> <input type="text"
									class="form-control" id="workBackground" name="workBackground"
									placeholder="<spring:message code="exp.text.Pposition"/> ">
							</div>
							
							<div class="form-group" style="width:210px">
								<label for="applyDateStr">From-to date </label>
								<input type="text" name="applyDateStr" id="applyDateStr" class="form-control" style="width:210px" placeholder="<spring:message code="report.text.month"/>"/>
            				</div>

							<div class="form-group">
								<label for="emp"><spring:message code="exp.emp" /> </label> <input
									type="text" class="form-control" id="emp" name="emp"
									placeholder="<spring:message code="exp.text.emp"/> ">
							</div>

							<div class="form-group">
								<label for="addressBackground"><spring:message
										code="address.name" /> </label>
								<textarea class="form-control" rows="5" id="addressBackground"
									name="addressBackground"
									placeholder="<spring:message code="exp.text.address"/>"></textarea>

							</div>

							<div class="form-group">
								<label for="business"><spring:message
										code="exp.business" /> </label> <input type="text"
									class="form-control" id="business" name="business"
									placeholder="<spring:message code="exp.text.business"/> ">
							</div>

							<div class="form-group">
								<label for="positionBackground"><spring:message
										code="info.position" /> </label> <input type="text"
									class="form-control" id="positionBackground"
									name="positionBackground"
									placeholder="<spring:message code="exp.text.position"/> ">
							</div>

							<div class="form-group">
								<label for="supervisorBackground"><spring:message
										code="exp.supervisor" /> </label> <input type="text"
									class="form-control" id="supervisorBackground"
									name="supervisorBackground"
									placeholder="<spring:message code="exp.text.supervisor"/>">
							</div>

							<div class="form-group">
								<label for="salaryBackground"><spring:message
										code="exp.salary" /> </label> <input type="text" class="form-control"
									id="salaryBackground" name="salaryBackground"
									placeholder="<spring:message code="exp.text.salary"/> ">
							</div>

							<div class="form-group">
								<label for="descriptionBackground"><spring:message
										code="exp.desc" /> </label>
								<textarea class="form-control" rows="5"
									id="descriptionBackground" name="descriptionBackground"
									placeholder="<spring:message code="exp.text.desc"/>"></textarea>
							</div>

							<div class="form-group">
								<label for="reasonLeaving"><spring:message
										code="exp.reason" /> </label>
								<textarea class="form-control" rows="5" id="reasonLeaving"
									name="reasonLeaving"
									placeholder="<spring:message code="exp.text.reason"/>"></textarea>

							</div>
							<br> <br>
							<button type="button" class="btn btn-success" id="btn_save">
								<span class="glyphicon glyphicon-save"></span>
								<spring:message code="edit.button.save" />
							</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">
								<spring:message code="button.cancel" />
							</button>
						</form>
					</div>
				</div>
			</div>

		</div>

		<!-- Delete Model -->
		<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
			aria-labelledby="ModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="ModalLabel">
							<spring:message code="delete.title" />
						</h4>
					</div>
					<div class="modal-body">
						<h4 class="modal-title" id="ModalLabel">
							<spring:message code="delete.confirm.title" />
						</h4>
						<br>
						<div align="right">
							<button id="btn_delete_submit" type="button"
								class="btn btn-danger" data-dismiss="modal">
								<span class="glyphicon glyphicon-remove-sign"></span>
								<spring:message code="main.delete" />
							</button>
							<button id="btn_close" type="button" class="btn btn-default"
								data-dismiss="modal">
								<spring:message code="button.cancel" />
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	<br> <br>
	<div id="table">
		<table id="experiencesTable" class="display" cellspacing="0"
			width="100%">
			<thead>
				<tr>
					<th><spring:message code="exp.data.position"/></th>
<%-- 					<th><spring:message code="exp.data.from" /></th> --%>
<%-- 					<th><spring:message code="exp.data.to" /></th> --%>
					<th><spring:message code="exp.data.emp" /></th>
					<th><spring:message code="family.data.address" /></th>
					<th><spring:message code="exp.data.business" /></th>
<%-- 					<th><spring:message code="exp.data.position.emp" /></th> --%>
					<th><spring:message code="exp.data.super" /></th>
					<th><spring:message code="exp.data.salary" /></th>
<%-- 					<th><spring:message code="exp.data.desc" /></th> --%>
<%-- 					<th><spring:message code="exp.data.reason" /></th> --%>
					<th>DATE</th>
					<th><spring:message code="main.edit.info" /></th>
					<th><spring:message code="main.delete" /></th>
				</tr>
			</thead>


			<tbody></tbody>
		</table>
		<div align="right">
			<button class="btn btn-warning" id="buttonAdd" data-toggle="modal" data-target="#experiencesModal"><span class="glyphicon glyphicon-plus"></span><spring:message code="exp.name.add" /></button>
			<button class="btn btn-default" type="button" id="buttonBack" name="buttonBack" onclick="window.location='${pageContext.request.contextPath}/references/${id}'"><span class="glyphicon glyphicon-step-backward"></span> Back </button>
			<button class="btn btn-default" type="button" id="buttonNext" name="buttonNext" onclick="window.location='${pageContext.request.contextPath}/applicant'"><span class="glyphicon glyphicon-ok"></span> Finish </button>
		</div>
	</div>
</div>