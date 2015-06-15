$(document).ready(function() {
  $('.sparky').sparkline("html", {
    type: "line"
  });

  // for notices
  setTimeout(function() {
    $('.sitewide-notice').fadeOut('slow');
  }, 1000);

  var posts = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: "/posts/autocomplete?query=%QUERY",
    remote: {
      url: "/posts/autocomplete?query=%QUERY"
    }
  });

  $('#query').typeahead({
    name: 'posts',
    display: 'value',
    source: posts
  });

});

$(document).on('page:load', function() {
  $('.sparky').sparkline("html", {
    type: "line"
  });
});
