$(document).ready(function(){

	$(".users.index").ready(function(){
		$.ajax({
			url: "get_month/8",
			type: "get"
		})
		.done(function(response){
			console.log(response);
			$(".users.index").find(".table-container").html(response);
		})
		.fail(function(){
			console.log("didn't work");
		})
	})
	
})