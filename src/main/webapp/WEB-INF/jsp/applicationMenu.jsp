<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.dropdownMenu {
 background: #EBEBEB;
 padding-left: 10px;
 padding-bottom: 10px;
}

#btnDropdownMenu {
 color: #808080;
 background: #fff;
 width: 115px; 
 height: 30px;
 border: 1px solid #ebebeb;
 border-radius: 0px;
 margin-top: 15px;
}

.dropdown-menu>li>a {
    color: #808080;
}

table.dataTable tr.odd {
 background-color: #e7e7e7;
}

table.dataTable tr.even {
 background-color: #d6d6d6;
}
</style>
<script type="text/javascript">
function checkId(id){
	if(id == null || id == ""){
		$( "ul#applicationMenu li" ).addClass('disabled');
		$( "ul#applicationMenu li a" ).removeAttr('href');
		
		$( "ul#applicationMenu li#information" ).addClass('active');
		$( "ul#applicationMenu li#information" ).removeClass('disabled');
		$( "ul#applicationMenu li#information a" ).attr('href',"${pageContext.request.contextPath}/informations/");
	}
}

$(document).ready(function(){
	checkId("${id}");	
});
</script>

  <div class="row">
   <div class="col-sm-12" >
    <div class="dropdownMenu">
       <button class="btn btn-defult dropdown-toggle" type="button" id="btnDropdownMenu" data-toggle="dropdown" aria-haspopup="true" 
         aria-expanded="true"><spring:message code="menu.text"/> <span class="caret"></span>
       </button>
      <ul class="dropdown-menu" id="applicationMenu" aria-labelledby="btnDropdownMenu">
        <li id="information" class='${ (tag eq "information") ? "active" : ""}'><a href="${pageContext.request.contextPath}/info/${id}"><span
         class="glyphicon glyphicon-user"></span> <spring:message code="tab.info"/></a></li>
        <li class='${ (tag eq "address") ? "active" : ""}' ><a href="${pageContext.request.contextPath}/address/${id}"><span
        class="glyphicon glyphicon-home"></span> <spring:message code="tab.address"/></a></li>
      <li class='${ (tag eq "family") ? "active" : ""}'><a  href="${pageContext.request.contextPath}/family/${id}"><span
        class="glyphicon glyphicon-file"></span> <spring:message code="tab.family"/></a></li>
      <li class='${ (tag eq "education") ? "active" : ""}'><a  href="${pageContext.request.contextPath}/educations/${id}"><span
        class="glyphicon glyphicon-education"></span> <spring:message code="tab.education"/></a></li>
      <li class='${ (tag eq "certificate") ? "active" : ""}'><a  href="${pageContext.request.contextPath}/certificates/${id}"><span
        class="glyphicon glyphicon-certificate"></span> <spring:message code="tab.certificate"/></a></li>
      <li class='${ (tag eq "skill") ? "active" : ""}'><a  href="${pageContext.request.contextPath}/skills/${id}"><span
        class="glyphicon glyphicon-book"></span> <spring:message code="tab.skill"/></a></li>
      <li class='${ (tag eq "languages") ? "active" : ""}'><a  href="${pageContext.request.contextPath}/languages/${id}"><span
        class="glyphicon glyphicon-envelope"></span> <spring:message code="tab.languages"/></a></li>
      <li class='${ (tag eq "reference") ? "active" : ""}'><a  href="${pageContext.request.contextPath}/references/${id}"><span
        class="glyphicon glyphicon-th-list"></span> <spring:message code="tab.reference"/></a></li>
      <li class='${ (tag eq "experience") ? "active" : ""}'><a  href="${pageContext.request.contextPath}/experiences/${id}"><span 
        class="glyphicon glyphicon-folder-open"></span> <spring:message code="tab.experience"/></a></li>      
      </ul>
    </div>
   </div>
  </div>
<!-- </div> -->