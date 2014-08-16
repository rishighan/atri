// admin section.
console.log("Rishi Ghan")
console.log("----------")



function setProjectHeroImage() {

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

$(document).ready(setProjectHeroImage)
$(document).on('page:load', setProjectHeroImage)