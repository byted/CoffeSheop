$('#total_price').html("Σ <%= number_to_currency(@cart.total_price) %>");
$('.quantity').each(function() { $(this).html('0'); $(this).parents('.tile').removeClass("selected");});