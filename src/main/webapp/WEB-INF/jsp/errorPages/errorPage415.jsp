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
			<div class="col-md-5">
				<div id="randerleft" align="center">
					<img src="${pageContext.request.contextPath}/static/resources/images/errorimage.png"  style="height:90%;width:75%;margin: auto;">
	       		</div>  	         
			</div>
			<div class="col-md-6" style="float: left;">
				<h1>Error! 415</h1>	    
				<p>The server is refusing to service the request because the entity 
					of the request is in a format not supported by the requested resource for the requested method.</p>
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