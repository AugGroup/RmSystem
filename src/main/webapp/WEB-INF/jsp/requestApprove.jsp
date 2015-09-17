<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title>Request for Application</title>

<script src="<c:url value ="/static/resources/pageJS/aug-approve.js"/>"></script>

<script type="text/javascript">
	var approve_tx = '<spring:message code="edit.approve"/>';
</script>

<div class="container">

	<h1 align="center">
		<spring:message code="request.title.approve" />
	</h1>
	<!------------------- Request DataTable------------------->
	<div id="table">
		<table class="dataTable" id="requestTable" class="cell-border" style="width: 100%">
			<thead>
				<tr>
					<th><spring:message code="request.id" /></th>
					<th><spring:message code="request.date" /></th>
					<th><spring:message code="request.human" /></th>
					<th><spring:message code="info.position" /></th>
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
						<label for="inputStatus"><spring:message code="request.as" /></label>
						<select name="inputStatus" id='inputStatus' class="form-control">
							<option value='New Request' selected='selected'><spring:message
									code="request.nr" /></option>
							<option value='Approve'><spring:message
									code="edit.approve" /></option>
							<option value='Not Approve'><spring:message
									code="edit.notApprove" /></option>
						</select>
					</div>
					<button id="btn_approve_submit" type="button"
						class="btn btn-primary" data-dismiss="modal">
						<spring:message code="edit.button.save" />
					</button>
					<button id="btn_close" type="button" class="btn btn-default"
						data-dismiss="modal">
						>
						<spring:message code="button.cancel" />
					</button>

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
									>
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
