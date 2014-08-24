// admin section.
console.log("Rishi Ghan")
console.log("----------")


function setProjectHeroImage(callback) {

  var projectHeroBg = document.getElementById('project-hero-bg'); // hero image
  var heroBgContainer = document.getElementById('hero-bg'); //container

  //console.log(projectHeroBg)

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
  overflow = "hidden",
  // get url
  imgsrc = projectHeroBg.getAttribute('data-src');

  // change style
  heroBgContainer.style.backgroundImage = "url("+imgsrc+")";
  heroBgContainer.style.backgroundSize =  bgSize;
  heroBgContainer.style.margin = margin;
  heroBgContainer.style.height = heroHeight+"px";
  heroBgContainer.style.width = heroWidth+"%";
  heroBgContainer.style.overflow = overflow;
  heroBgContainer.style.backgroundPosition = position;
  heroBgContainer.style.backgroundAttachment = bgattachment;
  heroBgContainer.style.backgroundRepeat = repeat;

}

function setDominantColor(targetid){

 // Get the id of the image that you
 // want the dominant color calculated on.
 var target = $(targetid),
 targetWidth = target.width(),
 targetHeight = target.height(),
 finalSrc = target.attr('src');

// init colorThief
 var colorThief = new ColorThief(),
 finalImg = new Image(targetWidth, targetHeight); // not sure about dimensions

 finalImg.src = window.location.origin+finalSrc;
 console.log(finalImg.src)
 console.log(colorThief.getColor(finalImg));
}

$(document).ready(function(){
  setProjectHeroImage();
  setDominantColor('#color-target');
});

$(document).on('page:load', setProjectHeroImage);