;(function($) {
    $('#hide_announcements').click(function() {

        var $hide_announcements = $(this);

        $.getJSON('/announcements/hide', function(data) {
            $('#announcements').fadeOut();
          });
        return false;
      });

})(jQuery);
