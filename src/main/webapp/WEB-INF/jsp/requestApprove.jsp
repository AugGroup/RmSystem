<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title><spring:message code="request.title.approve" /></title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/pageCss/main.css" />
<script src="<c:url value ="/static/resources/pageJS/aug-approve.js"/>"></script>

<script type="text/javascript">
    var datatablei18n = "<c:url value='/static/resources/dt-i18n/${pageContext.response.locale}.json' />";
    var pnotifyAdd="<spring:message code="pnotify.add"/>";
    var pnotifyEdit="<spring:message code="pnotify.edit"/>";
    var pnotifyDel="<spring:message code="pnotify.delete"/>";
    var pnotifySuccess="<spring:message code="pnotify.success"/>";
    var pnotifyError="<spring:message code="pnotify.error"/>";
	var approve_tx = '<spring:message code="edit.approve"/>';

	$(document).ready(function(){
		$("#approvePage").addClass('active-menu'); 
	});
</script>

<div class="container">


	<div><h1 align="center"><spring:message code="request.title.approve" /></h1></div>
	<!------------------- Request DataTable------------------->
	<div class="container table-responsive" id="table2">
		<table class="dataTable" id="requestTable" class="cell-border" style="width: 100%">
		<caption title="" class="tableHeader"><spring:message code="request.title.approve" /></caption>
			<thead>
				<tr>
					<th><spring:message code="request.id" /></th>
					<th><spring:message code="request.date" /></th>
					<th><spring:message code="request.human" /></th>
					<th><spring:message code="main.position1" /></th>
					<th><spring:message code="main.position2"/></th>
					<th><spring:message code="request.number" /></th>
					<th><spring:message code="main.status" /></th>
					<th><spring:message code="request.approve" /></th>
				</tr>
			</thead>
		</table>
	</div>


	<!------------------- Approve Modal ------------------->
	<div class="modal fade" id="approveModal" tabindex="-1" role="dialog"
		aria-labelledby="ModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="ModalLabel">
						<spring:message code="request.ar" />
					</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<input type="hidden" id="jobLevelId" name="jobLevelId">
						<input type="hidden" id="technologyId" name="technologyId">
						<input type="hidden" id="approveId" name="approveId" value="${ employee.id }">
						<input type="hidden" id="approveName" name="approveName" value="${ employee.applicant.firstNameEN }">
					</div>
					<div class="form-group">
						<label for="inputStatus"><spring:message code="request.as" /></label>
						<select name="inputStatus" id='inputStatus' class="form-control">
							<option value='Approve'><spring:message code="edit.approve" /></option>
							<option value='Not Approve'><spring:message code="edit.notApprove" /></option>
						</select>
					</div>
					<br>
					<div align="right">
				 	<button id="btn_approve_submit" type="button"
						class="btn btn-warning" data-dismiss="modal">
						<span class="glyphicon glyphicon-save"></span><spring:message code="edit.button.save" />
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

	<!-------------------- Exception Model -------------------->
	<div class="modal fade" id="exceptionModal" tabindex="-1" role="dialog"
		aria-labelledby="ModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h3 class="modal-title" id="ModalLabel">Exception Handler</h3>
				</div>
				<div class="modal-body">
					<div class="container">
						<div class="row">
							<div class="col-sm-5">
								<p>
									<b></b><em></em><span></span>
								</p>
							</div>
						</div>
						<div class="row">
							<h4>Please contact support.</h4>
						</div>
						<div class="row">
							<div class="col-sm-4"></div>
							<div class="col-sm-2">
								<button id="btn_close" type="button" class="btn btn-default"
									data-dismiss="modal">
									<spring:message code="button.cancel" />
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</div>
