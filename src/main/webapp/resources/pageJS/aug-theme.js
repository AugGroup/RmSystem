$(document).ready(function() {
	console.log(local);
	
	$('#'+local).on('click', function(e){
		e.preventDefault();
		$(this).addClass("disabled");
	});
});