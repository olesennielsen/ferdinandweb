$(function() {
	// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	
	// defining the dialog used for the pageobject partial
	$( "#dialog-form" ).dialog({
		autoOpen: false,
		height: 700,
		width: 600,
		modal: true,
		open: function() {
			// the data is stored in the x,y,object variables 
			var x = $(this).data("x");
			var y = $(this).data("y");
			var object = $(this).data("object");
			
			// set the values of three hidden field in the pageobject/_form partial
			$('#hidden-x').val(x);
			$('#hidden-y').val(y);
			$('#hidden-object').val(object);
			
			// hide the field not needed in that particular rendering of the partial
			if (object == 0) { // text object
				$('#video_link').hide();
				$('#image_link').hide();
				$('#textobject').show();
				$('#color').show();
			} else if (object == 1) { // image object
				$('#textobject').hide();
				$('#color').hide();
				$('#image_link').show();
				$('#video_link').hide();			
			} else if (object == 2) { // video object
				$('#textobject').hide();
				$('#color').hide();
				$('#image_link').hide();
				$('#video_link').show();
			}
		},
		close: function() {
			allFields.val( "" ).removeClass( "ui-state-error" );
		}
	});
	
	// Define the draggable objects: text, image and video and couple them with the divs with the correct ids	
	$( "#draggabletext" ).draggable({
		revert: "invalid",
		cursor: "move"
	});
		
	$( "#draggableimage" ).draggable({
		revert: "invalid",
		cursor: "move"
	});
		
	$( "#draggablevideo" ).draggable({
		revert: "invalid",
		cursor: "move"
	});
	
	// define the droppable draganddropphone id 
	var $phone = $( "#draganddropphone" );	
	
	$phone.droppable({
		activeClass: "ui-state-highlight",
		drop: function( event, ui ) {
			// get offset position for both the dropped ui.draggable object and the off set for the drop zone (phone)
			var dropPosition = ui.draggable.offset();			
			var phonePosition = $(this).offset();
			
			// Calculate the position inside the phoe
			var top = dropPosition.top - phonePosition.top;
			var left = dropPosition.left - phonePosition.left;
			
			// depending on the id of the dropped ui.draggable object show different div with ids
			var id = ui.draggable.attr("id");
			
			// Call the function with the correct data and open the dialog
			if (id == "draggabletext") {
				$( "#dialog-form" ).data("x", left).data("y", top).data("object", 0).dialog( "open" );				
			}
			else if (id == "draggableimage") {
				$( "#dialog-form" ).data("x", left).data("y", top).data("object", 1).dialog( "open" );
			}
			else if (id == "draggablevideo"){
				$( "#dialog-form" ).data("x", left).data("y", top).data("object", 2).dialog( "open" );
			}
		}
	});
});