<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="<c:url value ="/static/resources/pageJS/aug-languages.js"/>"></script> 

<script>
var valName = "<spring:message code="valid.lang.name"/>";
var valSpeak = "<spring:message code="valid.lang.speak"/>";
var valUnderstand = "<spring:message code="valid.lang.understand"/>";
var valRead = "<spring:message code="valid.lang.read"/>";
var valWrite = "<spring:message code="valid.lang.write"/>";
var valEdit = "<spring:message code="main.edit.info"/>";
var valDelete = "<spring:message code="main.delete"/>";
var id = ${id};
</script>

<jsp:include page="applicationMenu.jsp" />
<div class="container" id="titleHead">
<div class="row">
		<div class="col-sm-12 col-xs-12 col-md-12 col-lg-12">
			<h3 id="textTitle"><spring:message code="languages.name.less"/></h3>			
		</div>
	</div>

	<div class="modal fade" id="languagesModal" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>
						<span class="glyphicon glyphicon-lock"></span>
						<spring:message code="languages.name.less" />
					</h4>
				</div>
				<div class="modal-body" style="padding: 40px 50px;">
					<form role="form" id="languagesForm">
						<div class="form-group">
							<input type="hidden" id="applicant" name="applicant"
								value="${id}">
						</div>
						<div class="form-group">

							<label for="languages"><spring:message
									code="languages.name.less" /> </label> <input type="text"
								class="form-control" id="languages" name="languages"
								placeholder="<spring:message code="languages.text.name"/>">
						<label for="languages" class="error" style="display:none;"></label><br>
							<label for="speaking"><spring:message
									code="languages.speak.less" /></label>
							<div class="radio-inline">
								<label><input type="radio" name="speaking" id="speaking"
									value="Excellent">
								<spring:message code="languages.excellent" /></label>
							</div>
							<div class="radio-inline">
								<label><input type="radio" name="speaking" id="speaking"
									value="Good">
								<spring:message code="languages.good" /></label>
							</div>
							<div class="radio-inline">
								<label><input type="radio" name="speaking" id="speaking"
									value="Fair">
								<spring:message code="languages.fair" /></label>
							</div><br>
						<label for="speaking" class="error" style="display:none;"></label>

							<br> <label for="understanding"><spring:message
									code="languages.understand.less" /> </label>
							<div class="radio-inline">
								<label><input type="radio" name="understanding"
									id="understanding" value="Excellent">
								<spring:message code="languages.excellent" /></label>
							</div>
							<div class="radio-inline">
								<label><input type="radio" name="understanding"
									id="understanding" value="Good">
								<spring:message code="languages.good" /></label>
							</div>
							<div class="radio-inline">
								<label><input type="radio" name="understanding"
									id="understanding" value="Fair">
								<spring:message code="languages.fair" /></label>
							</div><br>
						<label for="understanding" class="error" style="display:none;"></label>

							<br> <label for="reading"><spring:message
									code="languages.read.less" /> </label>
							<div class="radio-inline">
								<label><input type="radio" name="reading" id="reading"
									value="Excellent">
								<spring:message code="languages.excellent" /></label>
							</div>
							<div class="radio-inline">
								<label><input type="radio" name="reading" id="reading"
									value="Good">
								<spring:message code="languages.good" /></label>
							</div>
							<div class="radio-inline">
								<label><input type="radio" name="reading" id="reading"
									value="Fair">
								<spring:message code="languages.fair" /></label>
							</div><br>
						<label for="reading" class="error" style="display:none;"></label>

							<br> <label for="writing"><spring:message
									code="languages.write.less" /> </label>
							<div class="radio-inline">
								<label><input type="radio" name="writing" id="writing"
									value="Excellent">
								<spring:message code="languages.excellent" /></label>
							</div>
							<div class="radio-inline">
								<label><input type="radio" name="writing" id="writing"
									value="Good">
								<spring:message code="languages.good" /></label>
							</div>
							<div class="radio-inline">
								<label><input type="radio" name="writing" id="writing"
									value="Fair">
								<spring:message code="languages.fair" /></label>
							</div><br>
					<label for="writing" class="error" style="display:none;"></label>
							
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
		<table id="languagesTable" class="display" cellspacing="0"
			width="100%">
			<thead>
				<tr>
					<th><spring:message code="languages.name" /></th>
					<th><spring:message code="languages.speak" /></th>
					<th><spring:message code="languages.read" /></th>
					<th><spring:message code="languages.understand" /></th>
					<th><spring:message code="languages.write" /></th>
					<th><spring:message code="main.edit.info" /></th>
					<th><spring:message code="main.delete" /></th>

				</tr>
			</thead>


			<tbody></tbody>
		</table>
		<div align="right">
			<button class="btn btn-warning" id="buttonAdd" data-toggle="modal" data-target="#languagesModal"><span class="glyphicon glyphicon-plus"></span><spring:message code="languages.name.add" /></button>
			<button class="btn btn-default" type="button" id="buttonBack" name="buttonBack" onclick="window.location='${pageContext.request.contextPath}/skills/${id}'"><span class="glyphicon glyphicon-step-backward"></span> Back </button>
			<button class="btn btn-default" type="button" id="buttonNext" name="buttonNext" onclick="window.location='${pageContext.request.contextPath}/references/${id}'"><span class="glyphicon glyphicon-step-forward"></span> Next </button>
		</div>
	</div>
</div>