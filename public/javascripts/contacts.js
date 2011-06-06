jQuery(function ($) {
  $('body').delegate('form', 'submit', function (e) {
    e.preventDefault();
    var myself = $(this);
    if (myself.hasClass('disabled')) return false;
    myself.addClass('disabled');
    $.post(myself.attr('action'), myself.serialize()).
      error(function (r) {
        $('<div/>').
          append($('<p/>').text('Votre demande n\'a pu être envoyée.')).
          append($('<p/>').text('Certaines informations requises doivent être indiquées.')).
          append($('<p/>').text('Vérifiez que tous les champs sont remplis avec des données valides en renvoyez votre demande, j\'y répondrais bientôt.')).
          dialog({
            title: 'Erreur dans la saisie',
            modal: true,
            buttons: { Ok: function() { $(this).dialog('close'); } }
          });
        $('form', r.responseText).replaceAll(myself);
      }).
      success(function () {
        $('<div/>').
          append($('<p/>').text('Votre demande a bien été envoyée.')).
          append($('<p/>').text('Je la recevrais très bientôt et y répondrais dès que possible.')).
          append($('<p/>').text('Merci de votre visite.')).
          dialog({
            title: 'Demande envoyée',
            modal: true,
            buttons: { Ok: function() { $(this).dialog('close'); } }
          });
      });
    return false;
  });
});
