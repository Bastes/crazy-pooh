$(function(jQuery) {
// ADMIN TOOLTIP
  (function() {
    var methods = {
      init: function() {
        this.
          tooltip('cancelOff').
          tooltip('remove');
        var myself = this,
            offset = this.offset();
        this.data(
          'tooltip',
          $('<div/>').
            addClass('tooltip').
            append($('<a/>').
              addClass('edit').
              attr('href', this.attr('data-edit-url')).
              text('edit')).
            css({
              top: offset.top + 'px',
              left: offset.left + this.width() + 'px'
            }).
            data('target', this).
            mouseenter(function() { myself.tooltip('cancelOff'); }).
            mouseleave(function() { myself.tooltip('off'); }).
            appendTo($('body')));
        return this;
      },
      off: function() {
        this.tooltip('cancelOff');
        var myself = this;
        this.data('tooltip-timeout',
          setTimeout(function() { myself.tooltip('remove') }, 1000));
        return this;
      },
      cancelOff: function() {
        var timeout = this.data('tooltip-timeout');
        if (timeout) {
          clearTimeout(timeout);
          this.data('tooltip-timeout', null);
        }
        return this;
      },
      remove: function() {
        var tooltip = this.data('tooltip');
        if (tooltip) tooltip.remove();
        return this;
      }
    };

    $.fn.tooltip = function(method) {
      if (methods[method])
        return methods[method].apply(
          this, Array.prototype.slice.call(arguments, 1));
      else if (typeof method === 'object' || !method)
        return methods.init.apply(this, arguments);
      else
        $.error( 'Method ' +  method + ' does not exist on jQuery.tooltip' );
    };
    $('body').
      delegate('.tooltip a.edit', 'click', function(e) {
        e.preventDefault();
        var target = $(this).closest('.tooltip').data('target');
        console.log(target);
        $.get($(this).attr('href')).success(function(r) {
          var form = $('form', r),
              submit = form.find(':submit').remove().attr('value'),
              buttons = {};
          buttons[submit] = function() {
            $.post(form.attr('action'), form.serialize()).success(function(r) {
              target.html($('[data-edit-url]:first', r).html());
              form.dialog('close');
              //$('#notice', r).dialog(); # FIXME ?
            });
          };
          form.dialog({
            title: $('h1:first', r),
            modal: true,
            buttons: buttons
          });
        });
      });
  })();
// END ADMIN TOOLTIP

  $('body').
    delegate('[data-edit-url]', 'mouseenter', function(e) {
      $(this).tooltip();
    }).
    delegate('[data-edit-url]', 'mouseleave', function(e) {
      $(this).tooltip('off');
    });
});
