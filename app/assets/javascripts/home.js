$(document).ready(function() {
    $('.sparky').sparkline("html", {
        type: "line"
    });

    // for notices
    setTimeout(function() {
        $('.sitewide-notice').fadeOut('slow');
    }, 1000);
})

$(document).on('page:load', function() {
    $('.sparky').sparkline("html", {
        type: "line"
    });
})
