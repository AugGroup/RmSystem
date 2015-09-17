<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="<c:url value ="/static/resources/pageJS/aug-educations.js"/>"></script>

<script>
var valUniversity = "<spring:message code="valid.ed.univers"/>";
var valDegree = "<spring:message code="valid.ed.degree"/>";
var valFaculty = "<spring:message code="valid.ed.faculty"/>";
var valMajor = "<spring:message code="valid.ed.major"/>";
var valGPA = "<spring:message code="valid.ed.gpa"/>";
var valYear = "<spring:message code="valid.ed.year"/>";
var valEdit = "<spring:message code="main.edit.info"/>";
var valDelete = "<spring:message code="main.delete"/>";
var id = ${id};
</script>

<jsp:include page="applicationMenu.jsp" />
<div class="container" id="titleHead">
	<div class="row">
		<div class="col-sm-12 col-xs-12 col-md-12 col-lg-12">
			<h3 id="textTitle"><spring:message code="education.name"/></h3>
			
		</div>
	</div>

	<div class="modal fade" id="educationModal" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>
						<span class="glyphicon glyphicon-lock"></span>
						<spring:message code="education.name" />
					</h4>
				</div>
				<div class="modal-body" style="padding: 40px 50px;">
					<form role="form" id="educationsForm">
						<div id="educations">
							<div class="form-group">
								<input type="hidden" id="applicant" name="applicant"
									value="${id}">
							</div>

							<div class="form-group">
								<label for="university"><spring:message
										code="education.university" /> </label> <input type="text"
									class="form-control" id="university" name="university"
									placeholder="<spring:message code="education.text.university"/>">
							</div>

<!-- 							<div class="form-group"> -->
<%-- 								<label for="degree"><spring:message --%>
<%-- 										code="education.degree" /> </label> <input type="text" --%>
<!-- 									class="form-control" id="degree" name="degree" -->
<%-- 									placeholder="<spring:message code="education.text.degree"/>"> --%>
<!-- 							</div> -->
							
							<div class="form-group" style="width: 165px">
								<label for="degree"><spring:message code="education.degree" /></label>
								<select name="degree" id='degree' class="form-control"
										style="width: 165px">
									<option value='' selected='selected'><spring:message code="report.text.select" /></option>
									<option value='Bachelor'><spring:message code="report.bachelor"/></option>
									<option value='Master'><spring:message code="report.master"/></option>
									<option value='Doctor'><spring:message code="report.doctor"/></option>
								</select>
							</div>

							<div class="form-group">
								<label for="faculty"><spring:message
										code="education.faculty" /> </label> <input type="text"
									class="form-control" id="faculty" name="faculty"
									placeholder="<spring:message code="education.text.faculty"/>">
							</div>
							<div class="form-group">
								<label for="major"><spring:message
										code="education.major" /> </label> <input type="text"
									class="form-control" id="major" name="major"
									placeholder="<spring:message code="education.text.major"/>">
							</div>
							<div class="form-group">
								<label for="gpa"><spring:message code="education.gpa" />
								</label> <input type="text" class="form-control" id="gpa" name="gpa"
									placeholder="<spring:message code="education.text.gpa"/>">
							</div>

							<div class="form-group">
								<label for="graduate"><spring:message
										code="education.graduate" /> </label> <input type="text"
									class="form-control" id="graduate" name="graduate"
									placeholder="<spring:message code="education.text.graduate"/>">
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
						</div>
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
		<table id="educationTable" class="display" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th><spring:message code="education.data" /></th>
					<th><spring:message code="education.data.degree" /></th>
					<th><spring:message code="education.data.faculty" /></th>
					<th><spring:message code="education.data.major" /></th>
					<th><spring:message code="education.data.gpa" /></th>
					<th><spring:message code="education.data.graduate" /></th>
					<th><spring:message code="main.edit.info" /></th>
					<th><spring:message code="main.delete" /></th>

				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<div align="right">
			<button class="btn btn-warning" id="buttonAdd" data-toggle="modal" data-target="#educationModal"><span class="glyphicon glyphicon-plus"></span> <spring:message code="education.name.add"/></button>
			<button class="btn btn-default" type="button" id="buttonBack" name="buttonBack" onclick="window.location='${pageContext.request.contextPath}/family/${id}'"><span class="glyphicon glyphicon-step-backward"></span> Back </button>
			<button class="btn btn-default" type="button" id="buttonNext" name="buttonNext" onclick="window.location='${pageContext.request.contextPath}/certificates/${id}'"><span class="glyphicon glyphicon-step-forward"></span> Next </button>		
		</div>
	</div>
</div>
