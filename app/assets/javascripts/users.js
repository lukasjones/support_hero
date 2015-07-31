$(document).ready(function(){
	
	$form = $(".user_box").html();

	$("html").on("mouseover", "td.selected", function(e){
		$(this).find("#user_no_can_do_day").val($(this).attr("data-date"))
		$(this).find("a").hide();
		$(this).find(".cant-do").show();
	})

	$("html").on("mouseleave", "td.selected", function(){
		$(this).find("a").show();
		$(this).find(".cant-do").hide();
	})


	$("html").on("submit", ".edit_user", function(e){
		e.preventDefault();
		formData = $(this).serialize();
		url = $(this).attr("action");
		$.ajax({
			url: url,
			type: "PUT",
			data: formData
		})
		.success(function(response){
			console.log(response);
		})
		.fail(function(){
			console.log("update no can do day didn't work");
		})
	})


})