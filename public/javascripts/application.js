jQuery(function ($) {
  $('body').
    delegate('#session form', 'submit', function (e) {
      e.preventDefault();
      var myself = $(this);
      $.post(myself.attr('action'), myself.serialize()).
        error(function (r) {
          myself.replaceAll($('form:first', r.responseText));
        }).
        success(function () {
          window.location.reload();
        });
      return false;
    });
});
