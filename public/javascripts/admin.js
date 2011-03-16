jQuery(function($) {
  var formDialogDefaultWidth = 290,
      formPictureWidthLimit = 390,
      formPictureHeightLimit = 555;
// IMAGE CROPPING
  (function() {
    var width = 35;
    $('body').delegate('form :file', 'change', function() {
      var myself = $(this),
          file = this.files[0],
          mydiv = myself.closest('div'),
          form = mydiv.closest('form'),
          crop_x = mydiv.find('input[name$="[crop_x]"]'),
          crop_y = mydiv.find('input[name$="[crop_y]"]'),
          crop_w = mydiv.find('input[name$="[crop_w]"]'),
          crop_h = mydiv.find('input[name$="[crop_h]"]'),
          cropbox = form.find('.cropbox'),
          ratio = 1,
          imageRealWidth = 0,
          imageRealHeight = 0;
      if (!(crop_x.length && crop_y.length && crop_w.length && crop_h.length))
        return;
      if (cropbox.length) cropbox.remove();
      if (!file.type.match('image.*')) throw 'This is not an image';
      var applyDimensions = function(coordinates) {
        var realX = coordinates.x / ratio,
            realY = coordinates.y / ratio,
            realW = coordinates.w / ratio,
            realH = coordinates.h / ratio;
        crop_x.val(Math.round(realX));
        crop_y.val(Math.round(realY));
        crop_w.val(Math.round(realW));
        crop_h.val(Math.round(realH));
      };
      cropbox = $('<div/>').addClass('cropbox').appendTo(form);
      var reader = new FileReader();
      reader.onload = function(e) {
        var image = $('<img/>').
          attr('src', e.target.result).appendTo(cropbox).
          Jcrop({
            onSelect: applyDimensions,
            onChange: applyDimensions,
            setSelect: [ 0, 0, width, width ],
            aspectRatio: 1
          });
        imageRealWidth = image.width();
        imageRealHeight = image.height();
        var ratioWidth = 1,
            ratioHeight = 1;
        if (imageRealWidth > formPictureWidthLimit)
          ratioWidth = formPictureWidthLimit / imageRealWidth;
        if (imageRealHeight > formPictureHeightLimit)
          ratioHeight = formPictureHeightLimit / imageRealHeight;
        ratio = (ratioWidth > ratioHeight) ? ratioHeight : ratioWidth;
        var imageFinalWidth = Math.round(ratio * imageRealWidth),
            imageFinalHeight = Math.round(ratio * imageRealHeight);
        image.css({
          width: imageFinalWidth + 'px',
          height: imageFinalHeight + 'px'
        });
        image.closest('form').
          dialog('option', 'width', formDialogDefaultWidth + image.width() + 10);
      };
      reader.readAsDataURL(file);
    });
  })();
// END IMAGE CROPPING
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
                left: offset.left + this.outerWidth() + 'px' }).
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
          buttons: buttons,
          width: formDialogDefaultWidth
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
  $('body').
    delegate(
      '[data-new-url], [data-edit-url], [data-delete-url]',
      'mouseenter',
      function(e) { $(this).tooltip(); }).
    delegate(
      '[data-new-url], [data-edit-url], [data-delete-url]',
      'mouseleave',
      function(e) { $(this).tooltip('off'); });
// END ADMIN TOOLTIP
});
