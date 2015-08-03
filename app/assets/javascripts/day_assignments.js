
$(document).ready(function(){

	$("html").on("mouseover", "td", function(){

		$(this).find(".swap-form").show();

	})

	$("html").on("mouseout", "td", function(){

		$(this).find(".swap-form").hide();

	})
	
})