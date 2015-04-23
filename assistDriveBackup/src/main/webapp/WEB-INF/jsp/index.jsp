<html>
<head>
  
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="/resources/main.css">

  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.2/underscore-min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<script>


$(document).ready(function() {
	$("#toggle").hide();
	$("#about").hide();
	$("#section-shopping").css("background-color","red");
	$("#section-eating-content").hide();
	$("#section-roaming-content").hide();
	
	var matchingList = [];
	
	$('.enter-input').on("input", function() {
		//console.log("Inside On");
	    var sourceVal = this.value;
	    var inputId = this.id;
	    //console.log(sourceVal);
	    $.ajax({
	        url:"http://localhost:9200/city/places/_search?q=node_name:" + sourceVal+"*&pretty",
	        dataType: 'json'
	    }).success(function(result) {
	    	 	//console.log(result);
		        matchingList = [];
	    	 	var result =result.hits.hits;
		        $.each(result, function(ind, val) {
		        	console.log("success " + val._source.node_name);
		        	matchingList[ind] = val._source;
		        	matchingList[ind].label = val._source.node_name;
		        });
		     
		        $('.enter-input').autocomplete({
		            delay: 250,
		            minLength: 0,
		            autoFocus: true,
		            source: matchingList,
		            messages: {
		                noResults: '',
		                results: function() {}
		            },
		            select: function(event, ui) {
		            		//console.log("Success");
		            		//console.log(ui.item.id);
		            		var populateId = "#"+inputId+"-select";
		            		//console.log(populateId);
		            		$("#"+inputId).attr("value",ui.item.node_name);
		            		$(populateId).attr("value",ui.item.id);
		            }
		        }).data("ui-autocomplete")._renderItem = function(ul, item) {
		        	console.log("render " + item.label);
		        	//console.log(item.label);
		        	ul.addClass("autocomplete-ul")
		            return $("<li></li>").addClass("autocomplete-li").data("item.autocomplete", item).append("<a>" + item.label + "</a>").appendTo(ul);
		        	//return $("<a/>").text(item.label).appendTo(ul);
		        };
	        
	    });
	    
	});
	
	
	
	
	$(".section-eating").on("click", function(ev) {
		$("#section-shopping-content").hide();
		$("#section-roaming-content").hide();
		$("#section-shopping").css("background-color","pink");
		$("#section-roaming").css("background-color","pink");
		$("#section-eating").css("background-color","red");
		$("#section-eating-content").show();
		
		ev.preventDefault();
	});
	
	$(".section-shopping").on("click", function(ev) {
		$("#section-roaming-content").hide();
		$("#section-eating-content").hide();
		$("#section-roaming").css("background-color","pink");
		$("#section-eating").css("background-color","pink");
		$("#section-shopping").css("background-color","red");
		$("#section-shopping-content").show();		
		ev.preventDefault();
	});
	
	
	$(".section-roaming").on("click", function(ev) {
		$("#section-eating-content").hide();
		$("#section-shopping-content").hide();
		$("#section-eating").css("background-color","pink");
		$("#section-shopping").css("background-color","pink");
		$("#section-roaming").css("background-color","red");
		$("#section-roaming-content").show();
		ev.preventDefault();
	});
	
	
	
	$("body").on("click",".node-name",function (ev) {
		$("#map").hide();
		$("#about-title-header").text(this.text);
		$("#about").show();
		$("#toggle").show();
		ev.preventDefault();
	});
	
	
	$("body").on("click",".service",function (ev) {
		$("#about").hide();
		$("#service-route").empty();
		$("#service-frequency").empty();
		
		if ($(this).hasClass("busLink")) {
			getMoreBusDetails(this.text);
		}
		if ($(this).hasClass("mmtsLink")) {
			getMoreTrainDetails(this.text);
		}
		$("#map").show();
		ev.preventDefault();
	});
	
	var toggleFrm = $("#toggle-form");
	toggleFrm.submit(function (ev) {
		$("#map").toggle();
		$("#about").toggle();
		ev.preventDefault();
	});
	
	var frm = $('#select-form');
	
	frm.submit(function (ev) {
		$("#toggle").hide();
		$("#about").hide();
		
		var info = $('#info');
		$("#info").empty();
		$("#service-route").empty();
		$("#service-frequency").empty();
		
		var source = $("#from-select").attr("value");
		var destination = $("#to-select").attr("value");
		
        $.ajax({
            type: frm.attr('method'),
            url: '/getBus',
            data: {"source": source, "destination": destination},
            success: function (ob) {
            	//alert(ob.data[0].id);
            	loadService(info, "Bus Info", ob.data,"busLink");        	    
            }
        });
        
        $.ajax({
            type: frm.attr('method'),
            url: '/getMMTS',
            data: {"source": source, "destination": destination},
            success: function (ob) {
            	//alert(ob.data[0].id);
            	//var info = $('#info');
            	loadService(info, "MMTS Info", ob.data,"mmtsLink");
            }
        });
        
        var map = $("#google-map-frame");
        var selectFrom = $("#from").attr("value");
        var selectTo = $("#to").attr("value");
       	map.attr("src", "https://www.google.com/maps/embed/v1/directions?origin="+selectFrom+"%2C%20Hyderabad%2C%20Telangana%2C%20India&destination="+selectTo+"%2C%20Hyderabad%2C%20Telangana%2C%20India&key=AIzaSyDIz0mYgBbp_C5uTM5ClsuVXeswu22Aouc");
       	//map.attr("src", "https://www.google.com/maps/embed/v1/directions?origin=17.383608,78.483107&destination=17.450829,78.380324&waypoints=17.399229,78.415373|17.434654,78.386883&key=AIzaSyDIz0mYgBbp_C5uTM5ClsuVXeswu22Aouc");
       	
       	$("#map").show();
       	ev.preventDefault();
    });
    
    var loadService = function(info, infoTitle, serviceList, type) {
    	if(serviceList.size == 0) return;
    	console.log("adding table");
    	
    	
    	var table = $("<table/>");
    	table.addClass('info-table');
    	
    	$.each(serviceList, function(index, serviceDetails) {
	    	var row = $("<tr/>");
	    	var link = $("<a/>");
	    	link.addClass("service")
	    	link.addClass(type);
	    	link.attr("href","");
	    	//link.attr("onclick","linkClick(event);"); 	
	    	link.text(serviceDetails.id);
	    	var cell = $("<td/>");
	    	cell.append(link);
	    	row.append(cell);
		 	row.append($("<td/>").text(serviceDetails.routeSummary));
			table.append(row);
	 	});
    	var name = $("<h4/>");
    	name.text(infoTitle)
    	info.append(name);
    	if(serviceList.length > 0) {
    		info.append(table);
    	}
    }
    
    var getMoreBusDetails = function(id) {
		$.ajax({
            type: 'POST',
            url: '/getBusDetails',
            data: {"id": id},
            success: function (ob) {
            	//alert(ob.data.routeDescription);
            	var ndList = ob.data.nodeList;//.routeDescription;
            	var sr = $("#service-route");
            	var table = $("<table/>");
            	var waypoints = "";
            	$.each(ndList, function(index, node) {
            		var link = $("<a/>");
        	    	link.addClass("node-name");
        	    	link.attr("href","");
        	    	link.text(node.name);
        	    	
            		table.append($("<tr/>").append($("<td/>").addClass("service-route-td").append(link)));
            		if(index>0) {
            			waypoints=waypoints+"|"+node.geoLocation;
            		} else {
            			waypoints=node.geoLocation;
            		}
            		console.log(waypoints);
            	});
            	if(ndList.length > 0 ) {
            		table.addClass("route-table");
            		sr.append($("<h4/>").text(id+" Route").css('text-align','center'));
            		sr.append(table);
            	}
            	
            	var sf = $("#service-frequency");
            	sf.append($("<h4/>").text("Frequency").css('text-align','center'));
            	sf.append($("<div/>").addClass("service-frequency-value").append(ob.data.frequency).css({'text-align':'center','font-size': '120%'}));
            	

        		var map = $("#google-map-frame");
                var selectFrom = ob.data.nodeList[0].geoLocation;
                var selectTo = ob.data.nodeList[ob.data.nodeList.length-1].geoLocation;
                map.attr("src", "https://www.google.com/maps/embed/v1/directions?origin="+selectFrom+"&destination="+selectTo+"&waypoints="+waypoints+"&key=AIzaSyDIz0mYgBbp_C5uTM5ClsuVXeswu22Aouc");
               	
               	
            }
        });
	}
	
	var getMoreTrainDetails = function(id) {
		$.ajax({
            type: 'POST',
            url: '/getTrainDetails',
            data: {"id": id},
            success: function (ob) {
            	//alert(ob.data.routeDescription);
            	var ndList = ob.data.nodeList;
            	var sr = $("#service-route");
            	var table = $("<table/>");
            	var waypoints = "";
            	$.each(ndList, function(index, node) {
            		var link = $("<a/>");
        	    	link.addClass("node-name");
        	    	link.attr("href","");
        	    	link.text(node.name);
        	    	
            		table.append($("<tr/>").append($("<td/>").addClass("service-route-td").append(link)));
            		if(index>0) {
            			waypoints=waypoints+"|"+node.geoLocation;
            		} else {
            			waypoints=node.geoLocation;
            		}
            		console.log(waypoints);
            	});
            	
            	if(ndList.length > 0 ) {
            		table.addClass("route-table");
            		sr.append($("<h4/>").text(id+" Route").css('text-align','center'));
            		sr.append(table);
            	}
            	
            	var sf = $("#service-frequency");
            	sf.append($("<h4/>").text("Frequency").css('text-align','center'));
            	sf.append($("<div/>").addClass("service-frequency-value").append(ob.data.frequency).css({'text-align':'center','font-size': '120%'}));
            	
            	var map = $("#google-map-frame");
                var selectFrom = ob.data.nodeList[0].geoLocation;
                var selectTo = ob.data.nodeList[ob.data.nodeList.length-1].geoLocation;
                map.attr("src", "https://www.google.com/maps/embed/v1/directions?origin="+selectFrom+"&destination="+selectTo+"&waypoints="+waypoints+"&key=AIzaSyDIz0mYgBbp_C5uTM5ClsuVXeswu22Aouc");
               	
            }
        });
		
		
	}
});
</script>
</head>
<body background="/resources/Charminar5.jpg">
	<div class="header">
		<h2>Travel now!</h2>
	</div>
	<div class="container">
		<div class="details">
			<div class="select">
				<form id="select-form" method="post">
					<label class="select-label">FROM</label>
					<!-- <input type="hidden" name="source" value="1"-->
					<input class="enter-input" type="text" id="from">
					<input id="from-select" type="hidden" name="source">
					<!-- <select class="select-dropdown" id="selectFrom" name="source">
						<option value="1" name="Abids">Abids</option>
						<option value="0" name="Koti">Koti</option>
						<option value="10" name="Madhapur">Madhapur</option>
						<option value="11" name="Kondapur">Kondapur</option>
					</select> --> <label class="select-label">TO</label>
					<input class="enter-input" type="text" id="to">
					<input id="to-select" type="hidden" name="destination"> 
					<!-- <select
						class="select-dropdown" id="selectTo" name="destination">
						<option value="1" name="Abids">Abids</option>
						<option value="0" name="Koti">Koti</option>
						<option value="10" name="Madhapur">Madhapur</option>
						<option value="11" name="Kondapur">Kondapur</option>
					</select> --> <input class="select-submit" type="submit" value="Search">
				</form>
			</div>
			
			<div class="info" id="info">
				<!-- add tables of bus and mmts here via JS -->	
			</div>
			<div class="service-details" id="service-details">
				<!-- add bus specific data -->
				<div class="service-route" id="service-route">
				</div>
				<div class="service-misc" id="service-misc">
					<div class="service-frequency" id="service-frequency">
					</div>
				</div>
			</div>
			
		</div>
		<div class="description">
			<div class="toggle" id="toggle">
				<form id="toggle-form" method="post">
					<input class="toggle-submit" type="submit" value="switch MAP <-> ABOUT">
				</form>
			</div>
			<div class="about" id="about">
				<div class="about-image" id="about-image">
					<h3>image</h3>
				</div>
				<div class="about-title" id="about-title">
					<h4 id="about-title-header"></h4>
				</div>
				<div class="about-sections" id="about-sections">
					<ul class="section-tabs">
						<li class="section-shopping section-tab" id="section-shopping"><a href="#tab1">Shopping</a></li>
						<li class="section-eating section-tab" id="section-eating"><a href="#tab2">Eating</a></li>
						<li class="section-roaming section-tab" id="section-roaming"><a href="#tab3">Roaming</a></li>
					</ul>
				</div>
				<div class="about-types" id="about-types">
					<div class="about-type" id="about-type1">
						<h4>type1</h4>
					</div>
					<div class="about-type" id="about-type2">
						<h4>type2</h4>
					</div>
					<div class="about-type" id="about-type3">
						<h4>type3</h4>
					</div>
					<div class="about-type" id="about-type4">
						<h4>type4</h4>
					</div>
					<div class="about-type" id="about-type5">
						<h4>type5</h4>
					</div>
				</div>
				<div class="about-description" id="about-description">
					<div class="section-contents">
						<div id="section-shopping-content" class="section-content active">
							<p>Tab #1 content goes here!</p>
							<p>Donec pulvinar neque sed semper lacinia. Curabitur lacinia
								ullamcorper nibh; quis imperdiet velit eleifend ac. Donec
								blandit mauris eget aliquet lacinia! Donec pulvinar massa
								interdum risus ornare mollis.</p>
						</div>

						<div id="section-eating-content" class="section-content">
							<p>Tab #2 content goes here!</p>
							<p>Donec pulvinar neque sed semper lacinia. Curabitur lacinia
								ullamcorper nibh; quis imperdiet velit eleifend ac. Donec
								blandit mauris eget aliquet lacinia! Donec pulvinar massa
								interdum risus ornare mollis. In hac habitasse platea dictumst.
								Ut euismod tempus hendrerit. Morbi ut adipiscing nisi. Etiam
								rutrum sodales gravida! Aliquam tellus orci, iaculis vel.</p>
						</div>
						<div id="section-roaming-content" class="section-content">
							<p>Tab #3 content goes here!</p>
							<p>Donec pulvinar neque sed semper lacinia. Curabitur lacinia
								ullamcorper nibh; quis imperdiet velit eleifend ac. Donec
								blandit mauris eget aliquet lacinia! Donec pulvinar massa
								interdum ri.</p>
						</div>
					</div>
				</div>
				
			</div>
			
			<div class="map" id="map">
				<iframe width="100%" height="70%" style="border: 0" id="google-map-frame"
				src=""></iframe>
			</div>
			
		
	</div>
</body>

</html>
