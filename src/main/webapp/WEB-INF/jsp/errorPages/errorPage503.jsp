<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<style>
.body {
	height: 100%;
	background: #E0DFDD;
	padding-top: 15px;
	padding-bottom: 45px;
}
.gotohome{
	margin: 5px;
}
</style>

<section>
	<div class="row-fluid"  style=" margin-top: 150px;margin-bottom: 150px;">
  		<div class="row" style=" margin-right:10px;">
			<div class="col-lg-5 col-md-5">
				<div id="randerleft" align="center">
					<img src="${pageContext.request.contextPath}/static/resources/images/errorimage.png"  style="height:90%;width:75%;margin: auto;">
	        	</div>  	         
			</div>
			<div class="col-lg-6 col-md-6" style="float: left;">
				<h1>Error! 503 web.xml</h1>	    
				<p>The server is currently unable to handle the request due to a temporary overloading or maintenance of the server.</p>
			  	<br><br><br>
			  	<p>Return to the home page.</p>
			  	<div class="gotohome">
				  	<a id="linkgotohome" href="<%=request.getContextPath()%>/applicant" class="btn btn-danger" role="button">
				  	<span class="glyphicon glyphicon-home" style="margin-left: 2px;">
				  	</span>
				  	Home </a>    
			   </div>
			</div>
		</div>
	</div>
</section>