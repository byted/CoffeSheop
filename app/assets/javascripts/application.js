// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui.min
//= require jquery_ujs
//= require metro-ui
//= require jquery.keyboard.min
//= require_tree 
$( function() {
	$('.keyboard').keyboard({ 
    layout : 'custom',
    display : {
    	bksp : "Del"
    },
    customLayout : {
      'default' : ['1 2 3 {bksp}', '4 5 6 {sp:2}', '7 8 9 {enter}', '{sp:1} 0 . {sp:1.5}']
    }, 
    position     : {
    	of : null,
    	my : 'left top',
    	at : 'left bottom',
    	at2: 'left bottom'
      },
     usePreview : false,
    restrictInput : false,
    preventPaste : true,  
    autoAccept : true,
    enterNavigation : true
  });

});

$('tr[data-link]').click(function() {
  window.location = $(this).data("link");
});

$( function() {
		$('.error-bar, .info-bar').fadeIn().delay(2000).fadeOut();
	}
);

$('.plus_btn').click(function() {
	var inputElement = $(this).siblings('input');
  var oldVal = parseInt(inputElement.val());
	inputElement.val( (oldVal + 1) || 1);
})

$('.minus_btn').click(function() {
	var inputElement = $(this).siblings('input');
	var oldVal = parseInt(inputElement.val());
	if(oldVal > 0) {
		inputElement.val(oldVal - 1);
	} else {
    inputElement.val(0);
  }
})