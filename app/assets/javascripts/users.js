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

	setTimeout(function(){
    $('.notice').remove();
  }, 5000);


})