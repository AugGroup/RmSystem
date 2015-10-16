<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title><spring:message code="skill.name" /></title>

<script src="<c:url value ="/static/resources/pageJS/aug-skill.js"/>"></script> 

<script>
var valSkill = "<spring:message code="valid.skill.skill"/>";
var valRank = "<spring:message code="valid.skill.rank"/>";
var valDuplicate = "<spring:message code="valid.duplicate"/>";
var valEdit = "<spring:message code="main.edit.info"/>";
var valDelete = "<spring:message code="main.delete"/>";
var id = ${id};
var pnotifyAdd="<spring:message code="pnotify.add"/>";
var pnotifyEdit="<spring:message code="pnotify.edit"/>";
var pnotifyDel="<spring:message code="pnotify.delete"/>";
var pnotifySuccess="<spring:message code="pnotify.success"/>";
var pnotifyError="<spring:message code="pnotify.error"/>";
var datatablei18n = "<c:url value='/static/resources/dt-i18n/${pageContext.response.locale}.json' />";
</script>


<style type="text/css">
	#fg-rankskill{
	width:120%;
	}
</style>

<div class="container" id="titleHead">
<jsp:include page="applicationMenu.jsp" />
	<div class="modal fade" id="skillModal" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>
						<span class="glyphicon glyphicon-lock"></span>
						<spring:message code="skill.name" />
					</h4>
			<div class="modal-body" style="padding: 40px 50px;">
				<div class="container-fluid">
					<form role="form" id="skillForm">
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<input type="hidden" id="applicant" name="applicant" value="${id}">
									<input type="hidden" id="skillsId">
								</div>
								<div class="form-group">
									<label for="masspecialty"><spring:message code="skill.specialty"/></label>
									<select class="form-control" id="masspecialty" name="masspecialties">
										<option value="" label="<spring:message code="skill.text.select"/>" />
										<c:forEach var="masspecialtiesist" items="${masspecialties}">
											<option value="${masspecialtiesist.id}">${ masspecialtiesist.name}</option>
										</c:forEach>
									</select>
									<span id="special-error" style="color:red;"></span>
									<label id="masspecialty-error" class="error" for="masspecialty"></label>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<label for="fg-rankskill"><spring:message code="skill.rank"/></label>
								<div class="form-group" id="fg-rankskill">
									 <label class="radio-inline" for="rank" > 
					 			     	<input id="rank1" name="rank" value="1" type="radio" checked/>1</label>
					 			     <label class="radio-inline" for="rank" > 
					 			     	<input id="rank2" name="rank" value="2" type="radio" />2</label>
					 			     <label class="radio-inline" for="rank" > 
					 			     	<input id="rank3" name="rank" value="3" type="radio" />3</label>
					 			     <label class="radio-inline" for="rank" > 
					 			     	<input id="rank4" name="rank" value="4" type="radio" />4</label>
					 			     <label class="radio-inline" for="rank" > 
					 			     	<input id="rank5" name="rank" value="5" type="radio" />5</label>
					 			     <label class="radio-inline" for="rank" > 
					 			     	<input id="rank6" name="rank" value="6" type="radio" />6</label>
					 			     <label class="radio-inline" for="rank" > 
					 			     	<input id="rank7" name="rank" value="7" type="radio" />7</label>
					 			     <label class="radio-inline" for="rank" > 
					 			     	<input id="rank8" name="rank" value="8" type="radio" />8</label>
					 			     <label class="radio-inline" for="rank" > 
					 			     	<input id="rank9" name="rank" value="9" type="radio" />9</label>
					 			     <label class="radio-inline" for="rank" > 
					 			     	<input id="rank10" name="rank" value="10" type="radio" />10</label>
						 		</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<button type="button" class="btn btn-warning" id="btn_save">
									<span class="glyphicon glyphicon-save"></span>
									<spring:message code="edit.button.save" />
								</button>
								<button type="button" class="btn btn-default" data-dismiss="modal">
									<spring:message code="button.cancel" />
								</button>
							</div>
						</div>
					</form>
				</div>
						
				
			</div>
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
		<table id="skillTable" class="display" cellspacing="0" width="100%">
		<caption title="" class="tableHeader"><spring:message code="skill.name"/></caption>
			<thead>
				<tr>
					<th><spring:message code="skill.specialty"/></th>
					<th><spring:message code="skill.rank"/></th>
					<th><spring:message code="main.edit.info" /></th>
					<th><spring:message code="main.delete" /></th>

				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<div align="right">
			<button class="btn btn-warning" id="buttonAdd" data-toggle="modal" data-target="#skillModal"><span class="glyphicon glyphicon-plus"></span> <spring:message code="skill.name.add"/></button>	
			<button class="btn btn-default" type="button" id="buttonBack" name="buttonBack" onclick="window.location='${pageContext.request.contextPath}/certificates/${id}'"><span class="glyphicon glyphicon-step-backward"></span> <spring:message code="button.back"/> </button>
			<button class="btn btn-default" type="button" id="buttonNext" name="buttonNext" onclick="window.location='${pageContext.request.contextPath}/languages/${id}'"><span class="glyphicon glyphicon-step-forward"></span> <spring:message code="button.next"/> </button>
		</div>
	</div>
</div>