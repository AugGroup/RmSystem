<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title><spring:message code="request.application" /></title>

<%-- <jsp:include page="messageValidate.jsp"></jsp:include> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/resources/pageCss/main.css" />
<script src="<c:url value ="/static/resources/pageJS/aug-request.js"/>"></script> 
<script type="text/javascript">
var reqName = "<spring:message code="valid.req.name"/>"; 
var reqDate = "<spring:message code="valid.req.date"/>"; 
var reqJoblevel = "<spring:message code="valid.req.joblevel"/>"; 
var reqTechnology = "<spring:message code="valid.req.technology"/>"; 
var reqApproval = "<spring:message code="valid.req.approval"/>"; 
var approveDate = "<spring:message code="valid.req.approve.date"/>"; 
var reqApplicant = "<spring:message code="valid.req.applicant"/>"; 
var infoTelNumber = "<spring:message code="valid.info.tel.number"/>"; 
var reqSkill = "<spring:message code="valid.req.skill"/>"; 
var reqYear = "<spring:message code="valid.req.year"/>"; 
var reqStatus = "<spring:message code="valid.req.status"/>"; 

var preview_tx = "<spring:message code="request.preview"/>";
var edit_tx = "<spring:message code="main.edit.info"/>";
var delete_tx = "<spring:message code="main.delete"/>";
var datatablei18n = "<c:url value='/static/resources/dt-i18n/${pageContext.response.locale}.json' />";
</script>

<style>
	.modal-footer {
		padding: 15px;
		text-align: right;
		border: none;
	}
	.inputRequest{
		width: 400px;
		padding-left: 50px;
	}
/* max-width  960px */
@media ( max-width : 960px) {
	.inputRequest{
		width: 100%;
		padding-left: 0px;
	}
	
	.modal-footer {
		padding: 0px;
		text-align: right;
		border: none;
	}
}
	
</style>

<script type="text/javascript">
$(document).ready(function(){
	$("#request").addClass('active-menu'); 
});
</script>

<div class="container">
	<div><h1 align="center"><spring:message code="request.title"/></h1></div>
	<div class="container table-responsive" id="table2" >
		<table class="dataTable" id="requestTable" class="cell-border" style="width: 100%">
			<caption title="" class="tableHeader"><spring:message code="request.title" /></caption>
			<thead>
				<tr>
					<th><spring:message code="request.id" /></th>
					<th><spring:message code="request.date" /></th>
					<th><spring:message code="request.human" /></th>
					<th><spring:message code="main.position1" /></th>
					<th><spring:message code="main.position2" /></th>
					<th><spring:message code="request.number" /></th>
					<th><spring:message code="main.status" /></th>
					<th><spring:message code="request.preview" /></th>
					<th><spring:message code="main.edit" /></th>
					<th><spring:message code="main.delete" /></th>
				</tr>
			</thead>
		</table>
		<button id="btn_new_req" class="btn btn-warning" data-toggle="modal" data-target="#addRequestModal">
			<span class="glyphicon glyphicon-plus"></span><spring:message code="request.add.new" />
		</button>
	</div>


	<!-------------------- Save Modal -------------------->
	<div class="modal fade" id="addRequestModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><spring:message code="request.title.appli"/></h4>
				</div>
				<div class="modal-body" >
					<form role='form' id="requestForm" name="requestForm">
						<div class="inputRequest">
						<div class="form-group">
							<input type="hidden" id="jobLevelId" name="jobLevelId">
							<input type="hidden" id="technologyId" name="technologyId">
							<input type="hidden" id="degreeType" name="degreeType">
						</div>
						<div class="form-group">
							<label for="inputRequesterName"><spring:message code="request.human" /></label> 
							<input type="text" class="form-control" name="inputRequesterName" id="inputRequesterName" />
						</div>
						<div class="form-group">
							<label for="inputRequestDate"><spring:message code="request.date" /></label>
							<div class="input-group date">
								<input type="text" class="form-control" name="inputRequestDate" id="inputRequestDate">
								<span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
							</div>
							<label for="inputRequestDate" class="error"></label>
						</div>
						<div class="form-group">
							<label for="joblevel"><spring:message code="main.position1" /></label> 
							<select name="joblevel" id="joblevel" class="form-control">
							<option value="-1" label="---Select Joblevel---" />
								<c:forEach items="${jobLevels}" var="jobLevelList">
									<option value="${jobLevelList.id}">${jobLevelList.name}</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="form-group">
							<label for="technology"><spring:message code="main.position2" /></label> 
							<select name="technology" id="technology" class="form-control">
							<option value="-1" label="---Select Technology---" />
								<c:forEach items="${technologies}" var="technologyList">
									<option value="${technologyList.id}">${technologyList.name}</option>
								</c:forEach>
							</select> 
						</div>
						<div class="form-group">
							<label for="inputApprovalName"><spring:message code="request.approve.name" /></label> 
							<input type="text" class="form-control" name="inputApprovalName" id="inputApprovalName" />
						</div>
						<div class="form-group">
							<label for="inputApproveDate"><spring:message code="request.approve.date" /></label>
							<div class="input-group date">
								<input type="text" class="form-control" name="inputApproveDate" id="inputApproveDate">
								<span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
							</div>
							<label for="inputApproveDate" class="error"></label>
							
						</div>
						<div class="form-group">
							<label for="inputNumberApplicant"><spring:message code="request.number" /></label> 
							<input type="text" class="form-control" name="inputNumberApplicant" id="inputNumberApplicant"
								placeholder="<spring:message code="request.text.number"/>" />
						</div>
						<div class="form-group">
							<label for="inputSpecificSkill"><spring:message code="request.skill" /> </label>
							<textarea class="form-control" name="inputSpecificSkill" id="inputSpecificSkill"
								placeholder="<spring:message code="request.text.skill"/>"></textarea>
						</div>
						<div class="form-group">
							<label for="inputYearExperience"><spring:message code="request.year" /></label> 
							<input type="text" class="form-control" name="inputYearExperience" id="inputYearExperience"
								placeholder="<spring:message code="request.text.year"/>" />
						</div>
						<div class="form-group">
							<label for="inputStatus"><spring:message code="main.status" /></label> 
							<select name="inputStatus" id='inputStatus' class="form-control">
								<option value='New Request' selected='selected'><spring:message code="request.new" /></option>
								<option value='Approve'><spring:message code="edit.approve" /></option>
								<option value='Not Approve'><spring:message code="edit.notApprove" /></option>
							</select>
						</div>
						</div>
						<div class="modal-footer">
							<button type="button" id="btn_save_req" style="width: 100px;" class="btn btn-warning">
								<span class="glyphicon glyphicon-save"></span><spring:message code="edit.button.save"/>  
							</button>
							<button type="button" id="btn_close"  style="width: 100px;" class="btn btn-default" data-dismiss="modal">
								<spring:message code="button.cancel" />
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-------------------- Delete Model -------------------->
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
						<spring:message code="request.delete" />
					</h4>
				</div>
				<div class="modal-body">
					<div class="container">
						<div class="row" >
							<spring:message code="request.ask" />
							<br><br>
						</div>
						<div class="row" style="float: right; padding-right: 20px;">
								<button id="btn_delete_submit" type="button" class="btn btn-danger" data-dismiss="modal">
									<span class="glyphicon glyphicon-remove-sign "></span><spring:message code="main.delete" />
								</button>
								<button id="btn_close" type="button" class="btn btn-default" data-dismiss="modal">
									<spring:message code="button.cancel" />
								</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-------------------- Preview Model -------------------->
	<div class="modal fade" id="previewModal" tabindex="-1" role="dialog"
		aria-labelledby="ModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="ModalLabel"><spring:message code="request.desc" /></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-4 col-md-offset-2" style="width: 170px;"><spring:message code="request.request" /></div>
						<div class="col-md-6"><p id="tx_requester"></p></div>
					</div>
					<div class="row">
						<div class="col-md-4 col-md-offset-2" style="width: 170px;"><spring:message code="request.request.date" /></div>
						<div class="col-md-6"><p id="tx_requestDate"></p></div>
					</div>
					<div class="row">
						<div class="col-md-4 col-md-offset-2" style="width: 170px;"><spring:message code="request.job" /></div>
						<div class="col-md-6"><p id="tx_jobLevel"></p></div>
					</div>
					<div class="row">
						<div class="col-md-4 col-md-offset-2" style="width: 170px;"><spring:message code="request.tech" /></div>
						<div class="col-md-6"><p id="tx_technology"></p></div>
					</div>
					<div class="row">
						<div class="col-md-4 col-md-offset-2" style="width: 170px;"><spring:message code="request.approv.name" /></div>
						<div class="col-md-6"><p id="tx_approvalName"></p></div>
					</div>
					<div class="row">
						<div class="col-md-4 col-md-offset-2" style="width: 170px;"><spring:message code="request.approv.date" /></div>
						<div class="col-md-6"><p id="tx_approveDate"></p></div>
					</div>
					<div class="row">
						<div class="col-md-4 col-md-offset-2" style="width: 170px;"><spring:message code="request.number.appli" /></div>
						<div class="col-md-6"><p id="tx_noOfApplicant"></p></div>
					</div>
					<div class="row">
						<div class="col-md-4 col-md-offset-2" style="width: 170px;"><spring:message code="request.spec.skill" /></div>
						<div class="col-md-6"><p id="tx_specificSkill"></p></div>
					</div>
					<div class="row">
						<div class="col-md-4 col-md-offset-2" style="width: 170px;"><spring:message code="request.year.exper" /></div>
						<div class="col-md-6"><p id="tx_yearExperience"></p></div>
					</div>
					<div class="row">
						<div class="col-md-4 col-md-offset-2" style="width: 170px;"><spring:message code="request.request.status"/></div>
						<div class="col-md-6"><p id="tx_status"></p></div>
					</div>
				</div>
				<div class="modal-footer">
					<div align="right">
						<button id="btn_close" type="button" class="btn btn-default" data-dismiss="modal">
							<spring:message code="button.cancel" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-------------------- Exception Model -------------------->
	<!-- <div class="modal fade" id="exceptionModal" tabindex="-1" role="dialog"
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
							<h4>Contact me +22003455!!!</h4>
						</div>
						<div class="row">
							<div class="col-sm-4"></div>
							<div class="col-sm-2">
								<button id="btn_close" type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> -->

</div>
