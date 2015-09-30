<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/resources/pageCss/email-create.css" />

<script type="text/javascript">
function showModal(title, detail,btn) {
	$("#showModal").modal("show");
	$("#title-detail").text(title);
	$("#body-detail").text(detail);
	$("#btnActive").addClass(btn);
}

function cleanModal() {
	$("#btnActive").removeClass("btn-warning");
	$("#btnActive").removeClass("btn-danger")
	$("#btnActive").removeClass("btn-success")
}
$( document ).ready(function() {
	var $id = -1;
	$("#mailTemplate").change(function(){		
		$id = $("#mailTemplate").val();
		
		if($id == -1){
			CKEDITOR.instances.editor.setData("");	
		}else{
			$.ajax({
			    url: '${pageContext.request.contextPath}/email/edit/update/'+$id,
			    type : 'GET',
			    success : function(data){
			    	CKEDITOR.instances.editor.setData(data);
			    },
			    error:function (jqXHR, textStatus, error){
			    	alert('CallBack error');
			    }
		   	});
		}
	});
	
	$("#update").on('click',function(){
		
		if($id == -1){
			var title = "Select Template";
			var detail = "Please Select The Template";
			var btn = "btn-warning";
			showModal(title,detail,btn);
			$("#btnActive").off().on("click",function(){
				cleanModal(btn);
			});
		}else{
			var title = "Update Template";
			var detail = "Do You Want To Update The Template?";
			var btn = "btn-success";
			showModal(title,detail,btn);			
			$("#btnActive").off().on("click",function(){
				var data = {
						'id':$id,
						'template':CKEDITOR.instances.editor.getData()
				}
				$.ajax({
				 	data:JSON.stringify(data),
				    url: '${pageContext.request.contextPath}/email/edit/update',
				    type :'POST',
				    contentType : 'application/json',
				    success : function(data){	
				    	cleanModal(btn);
				    },
				    error:function (jqXHR, textStatus, error){
				    	alert('CallBack error');
				    }
				});
			});
		}
	});
	
	$("#delete").on('click',function(){
		
		if($id == -1){
			var title = "Select Template";
			var detail = "Please Select The Template";
			var btn = "btn-warning";
			showModal(title,detail,btn);
			$("#btnActive").off().on("click",function(){
				cleanModal(btn);
			});
		}else{
			var title  = "Delete Template";
			var detail = "Do You Want To Delete The Template?";
			var btn	   = "btn-danger";
			showModal(title,detail,btn);	
			$("#btnActive").off().on("click",function(){
				$.ajax({
				    url: '${pageContext.request.contextPath}/email/edit/delete/'+$id,
				    type : 'GET', 
				    success : function(data){	
				    	CKEDITOR.instances.editor.setData("");
				    	$('select option[value="-1"]').attr("selected",true);
				    	$id = -1;
				    	cleanModal(btn);
				    },
				    error:function (jqXHR, textStatus, error){
				    	alert('CallBack error');
				    }
				});
			});
		}
	});
	
	$("#btnClose").off().on("click",function(){
		cleanModal();
	});
});
</script>

<div class="container">
	<div class="col-sm-12" id="email-section">
		
		<div class="row">
			
			<div class="col-sm-12">
				<div class="page-header">
					<h1>Edit Email</h1>
				</div>
			</div>
			
		</div>	
		
		<div class="row">
			<div class="col-sm-7">
				<div id="email-template">
					<form>
						<div class="form-group">
							<label for="name">Template Name :</label>
							<select class="form-control" id="mailTemplate">
								<option value="-1" label="--- Select Template ---" />
								<c:forEach items="${mailTemplate}" var="mailTemplate">
									<option value="${mailTemplate.id}">${mailTemplate.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="template">Template :</label>
							<textarea id="editor" name="template"></textarea>
						</div>
						<button type="button" class="btn btn-success" id="update" >Update</button>
						<button type="button" class="btn btn-danger" id="delete">Delete</button>
					</form>
					<ckeditor:replace replace="editor" basePath="${ pageContext.request.contextPath }/static/resources/ckeditor/" />
					<%-- <ckeditor:replace replace="editor1" basePath="${ pageContext.request.contextPath }/static/ckeditor/" 
						config="<%= Config.createConfig() %>" events="<%= Config.createEventHandlers() %>" /> --%>
				</div>
			</div>
			<div class="col-sm-5">
				<div id="email-hints">
					<p class="text-center"><strong id="email-hints-header">Hints</strong></p>
					<p><b>$FIRST_NAME</b> : Applicant's first name.</p>
					<p><b>$LAST_NAME</b> : Applicant's last name.</p>
					<p><b>$TECHNOLOGY</b> : Applicant's technology.</p>
					<p><b>$DATE</b> : Appointment date.</p>
					<p><b>$TIME</b> : Appointment time.</p>
					<p><b>$RECRUIT_FIRST_NAME</b> : Recruiter's first name.</p>
					<p><b>$RECRUIT_LAST_NAME</b> : Recruiter's last name.</p>
					<p><b>$RECRUIT_POSITION</b> : Recruiter's position</p>
					<p><b>$RECRUIT_PHONE</b> : Recruiter's phone number</p>
				</div>
			</div>
		</div>
			
	</div>
</div>

<div class="modal fade" id="showModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <div class="modal-header">
        <h4 class="modal-title" id="title-detail">
        	<span class="glyphicon glyphicon-remove-sign"></span> Delete Template
        </h4>
      </div>
      
      <div class="modal-body" id="body-detail">
        <p>Do You Want To Delete The Template?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" id="btnClose" data-dismiss="modal">Close</button>
        <button type="button" class="btn" id="btnActive" data-dismiss="modal">Ok</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->