<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="<c:url value ="/static/resources/pageJS/aug-family.js"/>"></script> 

<script>
var valName = "<spring:message code="valid.ref.name"/>";
var valRelation = "<spring:message code="valid.fam.relation"/>";
var valOccupationFamily = "<spring:message code="valid.fam.occ"/>";
var valAddress = "<spring:message code="valid.addr.addr"/>";
var valOccupation = "<spring:message code="valid.fam.occ"/>";
var valPositionFamily = "<spring:message code="valid.ex.position"/>";
var valEdit = "<spring:message code="main.edit.info"/>";
var valDelete = "<spring:message code="main.delete"/>";
var id = ${id};
</script>

<jsp:include page="applicationMenu.jsp" />
<div class="container" id="titleHead">
 <div class="form-group"><label for="informationFamily" id="text"><spring:message code="info.parent.number"/> </label></div>
				<div class="row">
						<div class="col-sm-12 col-xs-12 col-md-12 col-lg-12">
							<h3 id="textTitle"><spring:message code="family.name"/></h3>
							
						</div>
					</div>
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
						</div>
						<div class="form-group">
							<label for="nameFamily"><spring:message
									code="family.fname" /> </label> <input type="text" class="form-control"
								id="nameFamily" name="nameFamily"
								placeholder="<spring:message code="family.text.name"/>">
						</div>

						<div class="form-group">
							<label for="relationFamily"><spring:message
									code="family.relation" /> </label> <input type="text"
								class="form-control" id="relationFamily" name="relationFamily"
								placeholder="<spring:message code="family.text.relation"/>">
						</div>
						<div class="form-group">
							<label for="occupationFamily"><spring:message
									code="family.occupation" /> </label> <input type="text"
								class="form-control" id="occupationFamily"
								name="occupationFamily"
								placeholder="<spring:message code="info.text.occupation"/> ">
						</div>

						<div class="form-group">
							<label for="addressFamily"><spring:message
									code="address.name" /> </label>
							<textarea class="form-control" rows="5" id="addressFamily"
								name="addressFamily"
								placeholder="<spring:message code="info.text.address"/>"></textarea>
						</div>

						<div class="form-group">
							<label for="positionFamily"><spring:message
									code="info.position" /> </label> <input type="text"
								class="form-control" id="positionFamily" name="positionFamily"
								placeholder="<spring:message code="exp.text.position"/>">
						</div>
						<br> <br>
						<button type="button" class="btn btn-success" id="btn_save">
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
	<div id="table">
		<table id="familyTable" class="display" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th><spring:message code="family.data" /></th>
					<th><spring:message code="family.data.relation" /></th>
					<th><spring:message code="family.data.occupation" /></th>
					<th><spring:message code="family.data.address" /></th>
					<th><spring:message code="family.data.position" /></th>
					<th><spring:message code="main.edit.info" /></th>
					<th><spring:message code="main.delete" /></th>

				</tr>
			</thead>


			<tbody></tbody>
		</table>
		<div align="right">
			<button class="btn btn-warning" id="buttonAdd" data-toggle="modal" data-target="#familyModal"><span class="glyphicon glyphicon-plus"></span> <spring:message code="family.name.add"/></button>
			<button class="btn btn-default" type="button" id="buttonBack" name="buttonBack" onclick="window.location='${pageContext.request.contextPath}/address/${id}'"><span class="glyphicon glyphicon-step-backward"></span> Back </button>
			<button class="btn btn-default" type="button" id="buttonNext" name="buttonNext" onclick="window.location='${pageContext.request.contextPath}/educations/${id}'"><span class="glyphicon glyphicon-step-forward"></span> Next </button>
		</div>
	</div>
</div>

