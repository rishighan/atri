// admin section.
console.log("Rishi Ghan")
console.log("----------")


// remove fixed positioning and
// float the nav according to scroll amount.
function toggleFixed(targetid) {
    var scrollamount = 490,
        windowWidth = 700;
    if ($(window).scrollTop() > scrollamount && $(window).innerWidth() > windowWidth) {
        $(targetid).removeClass("site-nav").addClass("fixed")
    } else {
        $(targetid).removeClass("fixed").addClass("site-nav")
    }
}


// refactored js
function Heroize(opts) {

    //set the options
    this.heroHeight = opts.heroHeight || 510,
    this.heroWidth = opts.heroWidth || 100,
    this.margin = opts.margin || "0 0 -510px, 0",
    this.bgSize = opts.bgSize || "cover",
    this.position = opts.position || "center center",
    this.repeat = opts.repeat || "no-repeat",
    this.bgAttachment = opts.bgAttachment || "fixed",
    this.overflow = opts.overflow || "hidden",

    // target div, image element and hero bg container
    this.heroBgContainer = opts.container || '#project-hero-bg',
    this.imageSrc = opts.imageSrc || 'data-src',
    this.heroBgContainer = opts.heroBgContainer || '#hero-bg',

    // target for color-thief
    this.colorTarget = opts.colorTarget || '#color-target';
}


Heroize.prototype = {
    setProjectHeroImage: function() {

        // get url
        var imgsrc = this.heroBgContainer.getAttribute(this.imageSrc),
        heroBgContainer = document.getElementById(this.heroBgContainer); //container

        // change style
        heroBgContainer.style.backgroundSize = this.bgSize;
        heroBgContainer.style.backgroundImage = "url(" + this.imageSrc + ")";
        heroBgContainer.style.margin = this.margin;
        heroBgContainer.style.height = this.heroHeight + "px";
        heroBgContainer.style.width = this.heroWidth + "%";
        heroBgContainer.style.overflow = this.overflow;
        heroBgContainer.style.backgroundPosition = this.position;
        heroBgContainer.style.backgroundAttachment = this.bgAttachment;
        heroBgContainer.style.backgroundRepeat = this.repeat;


        console.log(projectHeroBg)
        return imgsrc;

    },

    setDominantColor: function(targetId) {
        // Get the id of the image that you
        // want the dominant color calculated on.
        var target = document.getElementById(this.colorTarget),
            targetWidth = target.width(),
            targetHeight = target.height(),
            finalSrc = target.attr('src');

        // have to create an Image object for Color Thief
        var finalImg = new Image(targetWidth, targetHeight);
        finalImg.src = window.location.origin + finalSrc;
        console.log(finalImg.src)

        finalImg.onload = function() {
            // init colorThief
            var colorThief = new ColorThief();
            console.log("hoosh");
            colorThief.getColor(finalImg);
            console.log(colorThief.getColor(finalImg));
        }

    }
}



// one for old times sake.
$(document).ready(function() {
    // set the options object
    var opts = {
            colorTarget: '#color-target'
        },
        foo = new Heroize(opts);
    foo.setProjectHeroImage();
    foo.setDominantColor(opts.colorTarget)
    console.log(opts.colorTarget);
});

$(window).bind('scroll', function() {
    toggleFixed('#site-nav');

})

// and one for the turbo/
$(document).on('page:load', function() {

    // set the options object
    var opts = {
            colorTarget: '#color-target'
        },
        foo = new Heroize(opts);
    foo.setProjectHeroImage();
    foo.setDominantColor(opts.colorTarget)
    console.log(opts.colorTarget);


});
