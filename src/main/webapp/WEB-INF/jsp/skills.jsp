<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="<c:url value ="/static/resources/pageJS/aug-skill.js"/>"></script> 

<script>
var valSkill = "<spring:message code="valid.skill.skill"/>";
var valRank = "<spring:message code="valid.skill.rank"/>";
var valEdit = "<spring:message code="main.edit.info"/>";
var valDelete = "<spring:message code="main.delete"/>";
var id = ${id};
</script>


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
				<form role="form" id="skillForm">
						<div class="form-group">
							<input type="hidden" id="applicant" name="applicant" value="${id}">
							<input type="hidden" id="skillsId">
						</div>
						<div class="form-group">
							<label for="skill">SPECIALTY :</label>
							 <select class="form-control" id="masspecialty" name="masspecialties">
								<option value="" label="---Select Skills---" />
								<c:forEach var="masspecialtiesist" items="${masspecialties}">
									<option value="${masspecialtiesist.id}">${ masspecialtiesist.name}</option>
								</c:forEach>
							</select>
							<span id="special-error" style="color:red;"></span>
						</div>
				<div class="form-group">
					<div class="row" id="rankSkill">
						<label class="radio-inline" for="rank" > 
		 			     	<input id="rank1" name="rank" value="1" type="radio" />1</label>
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
					<th>SPECIALTY</th>
					<th>RANK</th>
					<th><spring:message code="main.edit.info" /></th>
					<th><spring:message code="main.delete" /></th>

				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<div align="right">
			<button class="btn btn-warning" id="buttonAdd" data-toggle="modal" data-target="#skillModal"><span class="glyphicon glyphicon-plus"></span> <spring:message code="skill.name.add"/></button>	
			<button class="btn btn-default" type="button" id="buttonBack" name="buttonBack" onclick="window.location='${pageContext.request.contextPath}/certificates/${id}'"><span class="glyphicon glyphicon-step-backward"></span> Back </button>
			<button class="btn btn-default" type="button" id="buttonNext" name="buttonNext" onclick="window.location='${pageContext.request.contextPath}/languages/${id}'"><span class="glyphicon glyphicon-step-forward"></span> Next </button>
		</div>
	</div>
</div>
