// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap.min
//= require dataTables/jquery.dataTables
//= require dataTables/extras/dataTables.tableTools
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require_tree .
//= require websocket_rails/main

function number_format(number, decimals, dec_point, thousands_sep)
{
  number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
  var n = !isFinite(+number) ? 0 : +number,
  prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
  sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
  dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
  s = '',
  toFixedFix = function(n, prec) {
    var k = Math.pow(10, prec);
    return '' + (Math.round(n * k) / k)
    .toFixed(prec);
  };
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n))
  .split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '')
    .length < prec) {
    s[1] = s[1] || '';
  s[1] += new Array(prec - s[1].length + 1)
  .join('0');
}
return s.join(dec);
}

function truncate (string, length) {
  var length = length;
  return string.substring(0, length) + "...";
}

// function pop_notify(options) {
//   var defaults = {
//     width: "250px",
//     delay: 5000,
//     styling: "fontawesome",
//     buttons: {sticker: false, closer_hover: false},
//     mouse_reset: false
//   }
//   var settings = $.extend({},defaults,options);
//   return (new PNotify(settings));
// }

function pop_desktop_notify(options) {

}

function pop_notify(options){
  timeout = typeof timeout !== 'undefined' ? timeout : 5000;
  var notification = new NotificationFx({
    message : options.text,
    layout : 'bar',
    effect : 'slidetop',
    ttl: 5000,
    type : "notice", // notice, warning or error
    onClose : function() {
      console.log('bar closed');
    },
    onOpen : function() {
      $($(".ns-effect-slidetop")[1]).fadeOut(300)
      setTimeout( function() {
        $($(".ns-effect-slidetop")[1]).remove()
      }, 200 );
    }
  });
  notification.show();
}

function bootstrap_env() {
  var envs = ['xs', 'sm', 'md', 'lg'];

  $el = $('<div>');
  $el.appendTo($('body'));

  for (var i = envs.length - 1; i >= 0; i--) {
    var env = envs[i];

    $el.addClass('hidden-'+env);
    if ($el.is(':hidden')) {
      $el.remove();
      return env
    }
  };
}

  function MarkAsChanged(){
      $(this).addClass("changed");
  }
  function disableUnchangedFields(){
    $(':input:not(.changed):not([name=_method])').attr('disabled', 'disabled');
  }

  function enableFields(){
    $(':input:not(.changed):not([name=_method])').prop('disabled', false);
  }
