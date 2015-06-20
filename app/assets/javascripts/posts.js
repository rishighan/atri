// admin section.
console.log("Rishi Ghan");
console.log("----------");


// remove fixed positioning and
// float the nav according to scroll amount.
function toggleFixed(targetid) {
  'use strict';
  var scrollamount = 490,
    windowWidth = 700;
  if ($(window).scrollTop() > scrollamount && $(window).innerWidth() > windowWidth) {
    $(targetid).removeClass("site-nav").addClass("fixed");
  } else {
    $(targetid).removeClass("fixed").addClass("site-nav");
  }
}


// refactored js
function Heroize(opts) {
  'use strict';
  //set the options
  this.heroHeight = opts.heroHeight || 510,
    this.heroWidth = opts.heroWidth || 100,
    this.margin = opts.margin || "0 0 -510px 0",
    this.bgSize = opts.bgSize || "cover",
    this.position = opts.position || "center center",
    this.repeat = opts.repeat || "no-repeat",
    this.bgAttachment = opts.bgAttachment || "fixed",
    this.overflow = opts.overflow || "hidden",

    // target div, image element and hero bg container
    this.srcContainer = opts.srcContainer || document.getElementById('project-hero-bg'),
    this.imageSrc = opts.imageSrc || 'data-src',
    this.heroBgContainer = opts.heroBgContainer || document.getElementById('hero-bg'),

    // target for color-thief
    this.colorTarget = opts.colorTarget || 'color-target';
}


Heroize.prototype = {
  setProjectHeroImage: function() {

    if (this.srcContainer !== null) {
      // get url
      var imgsrc = this.srcContainer.getAttribute('data-src'),
        heroContainer = this.heroBgContainer;
      // change style
      heroContainer.style.backgroundSize = this.bgSize;
      heroContainer.style.backgroundImage = "url(" + imgsrc + ")";
      heroContainer.style.margin = this.margin;
      heroContainer.style.height = this.heroHeight + "px";
      heroContainer.style.width = this.heroWidth + "%";
      heroContainer.style.overflow = this.overflow;
      heroContainer.style.backgroundPosition = this.position;
      heroContainer.style.backgroundAttachment = this.bgAttachment;
      heroContainer.style.backgroundRepeat = this.repeat;

      return imgsrc;
    }

  },

  setDominantColor: function(targetId) {
    // Get the id of the image that you
    // want the dominant color calculated on.
    var target = document.getElementById(this.colorTarget);
    if (target !== null) {
      var targetWidth = target.width,
        targetHeight = target.height,
        finalSrc = target.getAttribute('src');

      // have to create an Image object for Color Thief
      var finalImg = new Image(targetWidth, targetHeight);
      finalImg.src = window.location.origin + finalSrc;

      finalImg.onload = function() {
        // init colorThief
        var colorThief = new ColorThief();
        console.log("Color analysis complete.");
        colorThief.getColor(finalImg);
        console.log(colorThief.getColor(finalImg));
      };
    }

  }
};

// one for old times sake.
$(document).ready(function() {
  // set the options object
  var opts = {
      colorTarget: 'color-target'
    },
    foo = new Heroize(opts);
  foo.setProjectHeroImage();
  foo.setDominantColor(opts.colorTarget);

  // Autocomplete search
  var posts = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: '/posts/autocomplete.json',
    remote: {
      url: '/posts/autocomplete.json?query=%QUERY',
      wildcard: '%QUERY'
    }
  });

  $('.typeahead').typeahead(null, {
    name: 'posts',
    display: 'title',
    source: posts,
    templates: {
      empty: [
        '<div class="empty-message">',
        'No posts matching the current query were found',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile('<div class="search-result"><strong>{{title}}</strong><br> <small>{{excerpt}}<small> </div>')
    }
  });

});

$(window).bind('scroll', function() {
  toggleFixed('#site-nav');

});

// and one for the turbolinks
$(document).on('page:load', function() {

  // set the options object
  var opts = {
      colorTarget: 'color-target'
    },
      foo = new Heroize(opts);
      foo.setProjectHeroImage();
      foo.setDominantColor(opts.colorTarget);



});
