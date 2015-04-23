<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.2/underscore-min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>

	<script>
$('document').ready(function(){
	var matchingList = [];
	
	$.ajax({
        url:"http://localhost:9200/bank/account/_search?q=firstname:Freema*&pretty",
        dataType: 'json'
    }).success(function(companyData) {
    	console.log(companyData.hits.hits[0]._source.employer);
    });
	
	$('#enter-input').on("input", function() {
		console.log("Inside On");
	    var sourceVal = $('input[name=source]').val();
	    console.log(sourceVal);
	    $.ajax({
	        url:"http://localhost:9200/bank/account/_search?q=firstname:" + sourceVal+"*&pretty",
	        dataType: 'json'
	    }).success(function(result) {
	    	 	console.log(result);
		        var result =result.hits.hits;
		        $.each(result, function(ind, val) {
		        	console.log(val._source.firstname);
		        	matchingList[ind] = val._source;
		        	matchingList[ind].label = val._source.firstname;
		        });
		        console.log(matchingList);
		        $('#enter-input').autocomplete({
		            delay: 0,
		            minLength: 0,
		            source: matchingList,
		            select: function(event, ui) {
		            		console.log("Success");
		            }
		        }).data("ui-autocomplete")._renderItem = function(ul, item) {
		        	console.log(item);
		            return $("<li></li>").data("item.autocomplete", item).append("<a>" + item.label + "</a>").appendTo(ul);
		        };
	        
	    });
	    
	});
});
	
	
	
</script>
</head>
<body>
<form id="select-form" method="post">
	<label class="enter">enter</label>
	<input id="enter-input" type="text" name="source">
	<p id="first-selected"></p>
</form>
</body>
</html>