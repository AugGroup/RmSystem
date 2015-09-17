$(document).ready(function () {
	var dtReport;
	//GPA pattern
	/*$("#gpa").inputmask('Regex', { regex: "[0-3]\\.[0-9][0-9]?$ |4\\.00$" });*/
	
	//Search By Criteria and Show function 
	$('#btn_search').off('click').on('click', function(){
		if(dtReport){
			dtReport.ajax.reload();
		}else{
			dtReport = $('#reportTable').DataTable({
				columnDefs : [
				               { "width": "14%", "targets": 2 },
				               { "width": "13%", "targets": 3 },
				               { "width": "13%", "targets": 4 },
				               { "width": "13%", "targets": 5 },

				             ],
				searching : false,
				paging: true,
				ajax :{
					type:'POST',
					url: 'report/search',
					data: function (d) {
						d.position = $('#position').val();
						d.degree = $('#degree').val();
						d.major = $('#major').val();
						d.schoolName = $('#schoolName').val();
						d.gpa = $('#gpa').val(); 
					},
					complete: function(data){
						if($('.dataTables_empty').length > 0){
							document.getElementById("btn_preview").disabled = true;
						}else document.getElementById("btn_preview").disabled = false;
					}
				},
				columns : [
			           {data: "code"},
				       {data: "applyDate"},
				       {data: "fullNameEN"},
				       {data: "positionName1"},
				       {data: "positionName2"},
				       {data: "positionName3"},
				       {data: "schoolName"},
				       {data: "degree"},
				       {data: "gpa"},
				       ]
			});
			
		}
		
	});
	
	
	
	$('#btn_search').trigger("click");
	
 	 $(".submit").click(function() {
		$("form[name='reportForm']").submit();
	});
 
});