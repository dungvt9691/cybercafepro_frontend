(function($) {

  // jQuery plugin definition
  var pluginName = "scrollToElement"
  $.fn[pluginName] = function(params) {

    // merge default and user parameters
    var defaults = {speed: 1000};
    var settings = $.extend({},defaults,params);

    // traverse all nodes
    this.each(function() {

      // express a single node as a jQuery object
      var $that = $(this);
      $that.click(function() {
        $('html, body').animate({
            scrollTop: $(settings["to"]).offset().top
        }, settings["speed"]);
      });

    });

    // allow jQuery chaining
    return this;
  };

})(jQuery);


jQuery.scrollToElement = function(params) {
  var defaults = {speed: 1000};
  var settings = $.extend({},defaults,params);
  $('html, body').animate({
    scrollTop: $(settings["to"]).offset().top
  }, settings["speed"]);
}
