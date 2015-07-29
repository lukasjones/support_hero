

$(document).ready(function(){

	$("html").on("click", ".cal_link", function(e){
		e.preventDefault();
		url = $(this).attr("href");
		$.ajax({
			url: url,
			type: "PUT"
		})
		.success(function(response){
			$(".table-container").html(response)
		})
		.fail(function(){
			console.log("failed");
		})
	})

})