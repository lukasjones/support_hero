$(document).ready(function(){


	$(".users").ready(function(){
		// get the current session's month number to user for next ajax call
		$.ajax({
			url: "/get_month_num", 
			type: "get"
		})
		.done(function(response){
			// get the current month and display on page
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
				console.log("get_month ajax call failed");
			})

		})
		.fail(function(){
			console.log("get_month_number ajax call failed");
		})
		


		$("html").on("click", ".cal_link", function(e){
			// get the next or previous month and replace current month on page
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