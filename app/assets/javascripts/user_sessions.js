$(function() {
	$('#pw_input_field').keyboard({ 
    layout : 'custom',
    customLayout : {
      'default' : ['1 2 3 {sp:2}', '4 5 6 {cancel}', '7 8 9 {enter}', '{sp:1} 0 {sp:3}']
    },
    position     : {
    	of : null,
    	my : 'center top',
    	at : 'center top',
    	at2 : 'center bottom'
      },
    usePreview : false,
    restrictInput : true,
    preventPaste : true,  
    autoAccept : true
  });

  $.keyboard.keyaction = {
    enter : function(base) {
      base.accept();
      $('form.instant_submit').submit(); 
      return false; 
    },
    cancel : function(base) {
      base.close();
      location.reload();
      return false;
    }
  };

  $('.select_user_tile').click( function() {
    $('#login_input_field').val($(this).find('.select_user_name').text());
    if($(this).attr('data-fastforward')) {
      $('form.instant_submit').submit(); 
    }
    else {
      $('#login').show();
      $('#pw_input_field').focus()
    }
  });
  $('.ask_pin').focus()
})