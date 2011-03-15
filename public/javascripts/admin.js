jQuery(function($) {
// ADMIN TOOLTIP
  (function() {
    var methods = {
      init: function() {
        this.
          tooltip('cancelOff').
          tooltip('remove');
        var myself = this,
            offset = this.offset(),
            tooltip = $('<div/>').
              addClass('tooltip').
              css({
                top: offset.top + 'px',
                left: offset.left + this.width() + 'px' }).
              data('target', this).
              mouseenter(function() { myself.tooltip('cancelOff'); }).
              mouseleave(function() { myself.tooltip('off'); });
        $(['new', 'edit', 'delete']).each(function() {
          var verb = '' + this;
          if (myself.is('[data-' + verb + '-url]'))
            tooltip.append($('<a/>').
              attr('href', myself.attr('data-' + verb + '-url')).
              addClass(verb).text(verb));
        });
        tooltip.appendTo($('body'));
        this.data('tooltip', tooltip);
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
    var newAndEditCallback = function(myself, success) {
      var target = myself.closest('.tooltip').data('target');
      $.get(myself.attr('href')).success(function(r) {
        var form = $('form', r),
            submit = form.find(':submit').remove().attr('value'),
            buttons = {};
        buttons[submit] = function() { form.submit(); };
        form.dialog({
          title: $('h1:first', r),
          modal: true,
          buttons: buttons
        });
        $('form').ajaxForm(function(r) {
          var newForm = $('form:first', r);
          if (newForm.length) {
            form.html(newForm.find(':submit').remove().end().html());
          }
          else {
            form.dialog('close');
            success(target, r);
          }
          //$('#notice', r).dialog(); # FIXME ?
        });
      });
    };
    $('body').
      delegate('.tooltip a.new', 'click', function(e) {
        e.preventDefault();
        newAndEditCallback($(this), function(target, result) {
          target.prepend($('[data-edit-url]:first', result));
        });
      }).
      delegate('.tooltip a.edit', 'click', function(e) {
        e.preventDefault();
        newAndEditCallback($(this), function(target, result) {
          target.html($('[data-edit-url]:first', result).html());
        });
      }).
      delegate('.tooltip a.delete', 'click', function(e) {
        e.preventDefault();
        var myself = $(this),
            target = myself.closest('.tooltip').data('target');
        $('<div/>').
          text("Etes-vous sûr de vouloir supprimer cet élément ?").
          dialog({
            resizable: false,
            modal: true,
            title: "Supprimer l'élément",
            buttons: {
              Annuler: function() { $(this).dialog('close'); },
              Ok: function() {
                $.post(myself.attr('href'), { _method: 'delete' }).
                  success(function(r) { target.remove(); });
                $(this).dialog('close');
                //$('#notice', r).dialog(); # FIXME ?
              }
            }
          });
      });
  })();
// END ADMIN TOOLTIP

  $('body').
    delegate(
      '[data-new-url], [data-edit-url], [data-delete-url]',
      'mouseenter',
      function(e) { $(this).tooltip(); }).
    delegate(
      '[data-new-url], [data-edit-url], [data-delete-url]',
      'mouseleave',
      function(e) { $(this).tooltip('off'); });
});
