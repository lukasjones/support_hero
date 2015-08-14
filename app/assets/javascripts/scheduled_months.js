$(document).ready(function(){


	$(".users").ready(function(){
		
		$.ajax({
			url: "/get_month_num", 
			type: "get"
		})
		.done(function(response){
			month = response["month_num"]
			console.log(response)
			url   = "/get_month/" + month
			$.ajax({
				url: url,
				type: "get"
			})
			.done(function(response){
				$(".table-container").html(response);
			})
			.fail(function(){
				console.log("didn't work");
			})

		})
		.fail(function(){
			console.log("could not get month number");
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
	
})