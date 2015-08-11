// $(document).ready(function(){

	$(".users.index").ready(function(){
		$.ajax({
			url: "/get_month/8",
			type: "get"
		})
		.done(function(response){
			$(".users.index").find(".table-container").html(response);
		})
		.fail(function(){
			console.log("didn't work");
		})
	})

	$(".users.show").ready(function(){
		$.ajax({
			url: "/get_month/8",
			type: "get"
		})
		.done(function(response){
			$(".users.show").find(".table-container").html(response);
		})
		.fail(function(){
			console.log("didn't work");
		})


		$("html").on("click", ".cal_link", function(e){
			e.preventDefault();
			url = $(this).attr("href");
			$.ajax({
				url: url,
				type: "get"
			})
			.success(function(response){
				$(".table-container").html(response)
			})
			.fail(function(){
				console.log("failed");
			})
		})
	})
	
// })