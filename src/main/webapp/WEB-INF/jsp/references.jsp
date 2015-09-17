<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="<c:url value ="/static/resources/pageJS/aug-reference.js"/>"></script> 

<script>
var valName = "<spring:message code="valid.ref.name"/>";
var valAddress = "<spring:message code="valid.addr.addr"/>";
var valTel = "<spring:message code="valid.ref.tel"/>";
var valOccupation = "<spring:message code="valid.fam.occ"/>";
var valEdit = "<spring:message code="main.edit.info"/>";
var valDelete = "<spring:message code="main.delete"/>";
var id = ${id};
</script>

<jsp:include page="applicationMenu.jsp" />
<div class="container" id="titleHead">
	<div class="form-group">
		<label for="reference" id="text"><spring:message code="ref.text" /> </label>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-12 col-xs-12 col-md-12 col-lg-12">
			<h3 id="textTitle"><spring:message code="ref.name"/></h3>
			
		</div>
	</div>
	<div class="modal fade" id="referenceModal" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>
						<span class="glyphicon glyphicon-lock"></span>
						<spring:message code="ref.name" />
					</h4>
				</div>
				<div class="modal-body" style="padding: 40px 50px;">
					<form role="form" id="referenceForm">
						<div class="form-group">
							<input type="hidden" id="applicant" name="applicant"
								value="${id}">
						</div>
						<div class="form-group">
							<label for="fullNameRef"><spring:message
									code="ref.fullName" /> </label> <input type="text" class="form-control"
								id="fullName" name="fullName"
								placeholder="<spring:message code="ref.text.fullname"/>">
						</div>
						<div class="form-group">
							<label for="completeAddress"><spring:message
									code="ref.address" /> </label> <input type="text" class="form-control"
								id="completeAddress" name="completeAddress"
								placeholder="<spring:message code="ref.text.address"/>">
						</div>
						<div class="form-group">
							<label for="telNo"><spring:message code="ref.tel" /> </label> <input
								type="text" class="form-control" id="telNo" name="telNo"
								placeholder="<spring:message code="ref.text.tel"/>">
						</div>
						<div class="form-group">
							<label for="occupationRef"><spring:message
									code="family.occupation" /> </label> <input type="text"
								class="form-control" id="occupationRef" name="occupationRef"
								placeholder="<spring:message code="info.text.occupation"/>">
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
		<table id="referenceTable" class="display" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th><spring:message code="ref.data" /></th>
					<th><spring:message code="ref.data.tel" /></th>
					<th><spring:message code="family.data.occupation" /></th>
					<th><spring:message code="ref.data.address" /></th>
					<th><spring:message code="main.edit.info" /></th>
					<th><spring:message code="main.delete" /></th>
				</tr>
			</thead>

			<tbody></tbody>
		</table>
		<div align="right">
			<button class="btn btn-warning" id="buttonAdd" data-toggle="modal" data-target="#referenceModal"><span class="glyphicon glyphicon-plus"></span> <spring:message code="ref.name.add"/></button>
			<button class="btn btn-default" type="button" id="buttonBack" name="buttonBack" onclick="window.location='${pageContext.request.contextPath}/languages/${id}'"><span class="glyphicon glyphicon-step-backward"></span> Back </button>
			<button class="btn btn-default" type="button" id="buttonNext" name="buttonNext" onclick="window.location='${pageContext.request.contextPath}/experiences/${id}'"><span class="glyphicon glyphicon-step-forward"></span> Next </button>		
		</div>
	</div>
</div>