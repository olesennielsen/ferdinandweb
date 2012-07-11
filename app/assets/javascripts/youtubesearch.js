// function used to search youtube like the flickr search

function SearchYouTube(query) {
    $.ajax({
        url: 'http://gdata.youtube.com/feeds/mobile/videos?alt=json-in-script&q=' + query,
        dataType: 'jsonp',
        success: function (data) {
            var row = "";
            for (i = 0; i < data.feed.entry.length; i++) {
								var id = data.feed.entry[i].id.$t;	
								id = id.replace("http://gdata.youtube.com/feeds/mobile/videos/", "");
                row += "<div class='search_item'>";
                row += "<table width=100%>";
                row += "<tr>";
                row += "<td width=30%>";
                row += "<img width='120px' height='80px' src=" + data.feed.entry[i].media$group.media$thumbnail[0].url + " />";
                row += "</td>";
                row += "<td width=50%>";
                row += "<b>" + data.feed.entry[i].media$group.media$title.$t + "</b><br/>";               
                row += "</td>";
								row += "<td width=20%>";
								row += '<input type="button" onclick="setVideoLink(\'' + id + '\', this)" class="nice small radius blue button" value="Use"></input>';
								row += "</td>";
                row += "</tr>";
                row += "</table>";
                row += "</div>";
            }
            document.getElementById("search-video-block").innerHTML = row;
        },
        error: function () {
            alert("Error loading youtube video results");
        }
    });
    return false;
}