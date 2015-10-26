<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title><spring:message code="family.name" /></title>

<script src="<c:url value ="/static/resources/pageJS/aug-family.js"/>"></script> 

<script>
var valName = "<spring:message code="valid.ref.name"/>";
var valRelation = "<spring:message code="valid.fam.relation"/>";
var valOccupationFamily = "<spring:message code="valid.fam.occ"/>";
var valAddress = "<spring:message code="valid.addr.addr"/>";
var valOccupation = "<spring:message code="valid.fam.occ"/>";
var valPositionFamily = "<spring:message code="valid.ex.position"/>";
var valAgeFamily = "<spring:message code="valid.info.age"/>";
var valSexFamily = "<spring:message code="valid.info.sex"/>";
var valTel = "<spring:message code="valid.ref.tel"/>";
var valEdit = "<spring:message code="main.edit.info"/>";
var valDelete = "<spring:message code="main.delete"/>";
var digitOnly = "<spring:message code="valid.digit.only"/>";
var id = ${id};
var pnotifyAdd="<spring:message code="pnotify.add"/>";
var pnotifyEdit="<spring:message code="pnotify.edit"/>";
var pnotifyDel="<spring:message code="pnotify.delete"/>";
var pnotifySuccess="<spring:message code="pnotify.success"/>";
var pnotifyError="<spring:message code="pnotify.error"/>";
var datatablei18n = "<c:url value='/static/resources/dt-i18n/${pageContext.response.locale}.json' />";
</script>


<div class="container" id="titleHead">
<jsp:include page="applicationMenu.jsp" />
				<div class="modal fade" id="familyModal" role="dialog">
					<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>
						<span class="glyphicon glyphicon-lock"></span>
						<spring:message code="family.name" />
					</h4>
				</div>
				<div class="modal-body" style="padding: 40px 50px;">
					<form role="form" id="familyForm">
						<div class="form-group">
							<input type="hidden" id="applicant" name="applicant"
								value="${id}">
							<input type="hidden" id="relationId" name="relationId">
							<input type="hidden" id="familyId" name="familyId">
						</div>
						<div class="form-group">
							<label for="nameFamily"><spring:message
									code="family.fname" /> </label> <input type="text" class="form-control"
								id="nameFamily" name="nameFamily"
								placeholder="<spring:message code="family.text.name"/>">
						</div>
<!-- 						<div class="form-inline"> -->
						<div class="form-group">
							<label for="age"><spring:message
										code="info.age" /> </label> <input type="text" class="form-control"
									id="age" name="age"
									placeholder="<spring:message code="info.text.age"/>">
							</div>
							<div class="form-group">
								<label for="gender"><spring:message
										code="info.sex" /> </label> 
								<select class="form-control" id="gender" name="gender">
									<option value=""><spring:message code="info.sex.choose"/></option>
									<option value="Male"><spring:message code="info.male"/></option>
									<option value="Female"><spring:message code="info.female"/></option>
								</select>
							</div>
<!-- 						</div> -->
						<div class="form-group">
							<label for="telNo"><spring:message code="ref.tel" /> </label> <input
								type="text" class="form-control" id="telNo" name="telNo"
								placeholder="<spring:message code="ref.text.tel"/>">
						</div>
						<div class="form-group">
 							<label for="relationFamily"><spring:message code="family.text.relation"/></label><br>
 							<select class="form-control" id="relationFamily" name="relationFamily">
								<option value="" label="<spring:message code="family.text.select"/>" />
								<c:forEach var="obj" items="${relations}">
									<option value="${obj.id}">${obj.relationType}</option>
								</c:forEach>
							</select>
						</div> 
						<div class="form-group">
							<label for="occupationFamily"><spring:message
									code="family.occupation" /> </label> <input type="text"
								class="form-control" id="occupationFamily"
								name="occupationFamily"
								placeholder="<spring:message code="info.text.occupation"/> ">
						</div>
						<div class="form-group">
							<label for="positionFamily"><spring:message
									code="info.position" /> </label> <input type="text"
								class="form-control" id="positionFamily" name="positionFamily"
								placeholder="<spring:message code="exp.text.position"/>">
						</div>

						<div class="form-group">
							<label for="addressFamily"><spring:message
									code="address.name" /> </label>
							<textarea class="form-control" rows="5" id="addressFamily"
								name="addressFamily"
								placeholder="<spring:message code="info.text.address"/>"></textarea>
						</div>

						<br> <br>
						<button type="button" class="btn btn-warning" id="btn_save">
							<span class="glyphicon glyphicon-save"></span>
							<spring:message code="edit.button.save" />
						</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">
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
	<div class="table-responsive" id="table">
		<table id="familyTable" class="display" cellspacing="0" width="100%">
		<label for="informationFamily" class="text"><spring:message code="info.parent.number"/> </label>
		<caption title="" class="tableHeader"><spring:message code="family.name"/></caption>
			<thead>
				<tr>
					<th><spring:message code="family.data" /></th>
					<th><spring:message code="family.data.relation" /></th>
					<th><spring:message code="family.data.occupation" /></th>
					<th><spring:message code="family.data.address" /></th>
					<th><spring:message code="info.tel"/></th>
					<th><spring:message code="info.age"/></th>
					<th><spring:message code="info.sex"/></th>
					<th><spring:message code="family.data.position" /></th>
					<th><spring:message code="main.edit.info" /></th>
					<th><spring:message code="main.delete" /></th>

				</tr>
			</thead>


			<tbody></tbody>
		</table>
		<div align="right">
			<button class="btn btn-warning" id="buttonAdd" data-toggle="modal" data-target="#familyModal"><span class="glyphicon glyphicon-plus"></span> <spring:message code="family.name.add"/></button>
			<button class="btn btn-default" type="button" id="buttonBack" name="buttonBack" onclick="window.location='${pageContext.request.contextPath}/address/${id}'"><span class="glyphicon glyphicon-step-backward"></span> <spring:message code="button.back"/> </button>
			<button class="btn btn-default" type="button" id="buttonNext" name="buttonNext" onclick="window.location='${pageContext.request.contextPath}/educations/${id}'"><span class="glyphicon glyphicon-step-forward"></span> <spring:message code="button.next"/> </button>
		</div>
	</div>
</div>