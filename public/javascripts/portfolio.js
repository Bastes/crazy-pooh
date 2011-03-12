jQuery(function($) {
  $('body').delegate('#achievements a', 'click', function(e) {
    e.preventDefault();
    var myself = $(this);
    $('#achievements .selected').removeClass('selected');
    myself.closest('li').addClass('selected');
    $('#achievement').load(myself.attr('href') + ' #achievement>*');
  });
  var firstInList = $('#achievements a:first');
  if (firstInList.length) {
    firstInList.click();
  }
  else {
    var sectionLink = $('#breadcrumb a:first'),
        achievementLink = $('#breadcrumb h1 a:last');
    $('#achievements').load(sectionLink.attr('href') + ' #achievements>*',
      function() {
        $('#achievements a[href="' + achievementLink.attr('href') + '"]').
          closest('li').addClass('selected');
      });
  }
})
