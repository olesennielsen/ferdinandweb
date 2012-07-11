// the flickr search of the flickr api formatted as a json callback 

function SearchFlickr() {
	$.getJSON("http://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?",
  {
    tags: $("#flickrinput").val(),
    tagmode: "any",
    format: "json"
  },
	function(data) {
		// add all the videos to the row and set the search-image-block's innerHTML to this value 
		var row = "";
		$.each(data.items, function(i,item) {
			var link = item.media.m;
			row += "<div class='search_item'>";
      row += "<table width=100%>";
      row += "<tr>";
      row += "<td width=80%>";
      row += "<img src=" + item.media.m + " />";
      row += "</td>";
			row += "<td width=20%>";
			row += '<input type="button" onclick="setImageLink(\'' + link + '\', this)" class="nice small radius blue button" value="Use"></input>';
			row += "</td>";
      row += "</tr>";
      row += "</table>";
      row += "</div>";
			if ( i == 20 ) return false;
		});
		document.getElementById("search-image-block").innerHTML = row;
	});	
}