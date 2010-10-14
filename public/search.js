$(function(){
    $.ajax({
	url: "/result?date="+$(".date")[0].value,
	cache: false,
	success: function(html){
	    console.log(html);
	    $("#result").html(html);
	}
    });
})