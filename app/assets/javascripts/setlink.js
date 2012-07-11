// functions used to set the link of the hidden-link form field when the element is selected

function setVideoLink(video_id, element) {
		document.getElementById('hidden-link').value = "http://www.youtube.com/embed/" + video_id;
		
		element.setAttribute("class", "nice small radius green button");
		element.value = "Selected";
		document.getElementById("add-notification").innerHTML = "Press add to add the video in your campaign";
		document.getElementById("add-notification").setAttribute("class", "alert-box success");
		return false;
}

function setImageLink(link, element) {
	document.getElementById('hidden-link').value = link;
	
	element.setAttribute("class", "nice small radius green button");
	element.value = "Selected";
	document.getElementById("add-notification").innerHTML = "Press add to add the video in your campaign";
	document.getElementById("add-notification").setAttribute("class", "alert-box success");
	return false;	
}



