// admin section.
console.log("Rishi Ghan")
console.log("----------")


// remove fixed positioning and
// float the nav according to scroll amount.
function toggleFixed(targetid){
   var scrollamount = 490,
       windowWidth = 700;
   if($(window).scrollTop() > scrollamount && $(window).innerWidth() > windowWidth){
     $(targetid).removeClass("site-nav").addClass("fixed")
      }
   else{
      $(targetid).removeClass("fixed").addClass("site-nav")
   }
}


function setProjectHeroImage(callback) {

  //set dimensions
  var heroHeight = 510,
  heroWidth = 100,
  //set margin
  margin = "0 0 -510px 0",
  bgSize = "cover",
  position ="center center",
  repeat = "no-repeat",
  bgattachment = "fixed"
  //overflow
  overflow = "hidden";


    // hero image
    var projectHeroBg = document.getElementById('project-hero-bg'),

    // get url
    imgsrc = projectHeroBg.getAttribute('data-src'),
    heroBgContainer = document.getElementById('hero-bg'); //container

    // change style
    heroBgContainer.style.backgroundSize =  bgSize;
    heroBgContainer.style.backgroundImage = "url("+imgsrc+")";
    heroBgContainer.style.margin = margin;
    heroBgContainer.style.height = heroHeight+"px";
    heroBgContainer.style.width = heroWidth+"%";
    heroBgContainer.style.overflow = overflow;
    heroBgContainer.style.backgroundPosition = position;
    heroBgContainer.style.backgroundAttachment = bgattachment;
    heroBgContainer.style.backgroundRepeat = repeat;


  //console.log(projectHeroBg)
   return imgsrc;
}

// get the dominant color or palette
function setDominantColor(targetid){

 // Get the id of the image that you
 // want the dominant color calculated on.
 var target = $(targetid),
 targetWidth = target.width(),
 targetHeight = target.height(),
 finalSrc = target.attr('src');

 // have to create an Image object for Color Thief
 var finalImg = new Image(targetWidth, targetHeight);
 finalImg.src = window.location.origin+finalSrc;
 console.log(finalImg.src)

 finalImg.onload= function(){
  // init colorThief
  var colorThief = new ColorThief();
  console.log("hoosh");
  colorThief.getColor(finalImg);
  console.log(colorThief.getColor(finalImg));
}
}

// one for old times sake.
$(document).ready(function(){

    setProjectHeroImage();
    setDominantColor('#color-target');


});

 $(window).bind('scroll', function(){
     toggleFixed('#site-nav');

  })

// and one for the turbo/
$(document).on('page:load', function(){

    setProjectHeroImage();
    setDominantColor('#color-target');


});
