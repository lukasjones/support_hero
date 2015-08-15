$(document).ready(function(){
	
	// $form = $(".user_box").html();

	// showing no can do day form on mouse over
	$("html").on("mouseover", "td.selected", function(e){
		$(this).find("#user_no_can_do_day").val($(this).attr("data-date"))
		$(this).find("a").hide();
		$(this).find(".cant-do").show();
	})

	// hiding no can do day form on mouse leave
	$("html").on("mouseleave", "td.selected", function(){
		$(this).find("a").show();
		$(this).find(".cant-do").hide();
	})

	// hide notifications
	$('.errors').hide();
	$('.notice').hide();

	// slide notifications down 
	$('.errors').slideDown();
	$('.notice').slideDown();

	// slide notifications up after 5 seconds
	setTimeout(function(){
    $('.notice').slideUp();
    $('.errors').slideUp();
  }, 5000);

	// hide all elements in instructions that will be toggled
	$(".toggle").hide();


	// toggle functionality for instructions
	$(".instruction").on("click", function(e){
		e.preventDefault();
		console.log("got here")
		$(this).parent().find(".toggle").toggle();
	})


})