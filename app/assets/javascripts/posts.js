// admin section.
console.log("Rishi Ghan")
console.log("----------")
$(document).ready(setProjectHeroImage)
$(document).on('page:load', setProjectHeroImage)
function setProjectHeroImage() {

  var projectHeroBg = document.getElementById('project-hero-bg'); // hero image
  var heroBgContainer = document.getElementById('hero-bg'); //container

  console.log(projectHeroBg)

  //set dimensions
  var heroHeight = 510;
  var heroWidth = 100;
  //set margin
  var margin = "0 0 -510px 0";
  var bgSize = "cover";
  //overflow
  var overflow = "hidden";
  // get url
  var imgsrc = projectHeroBg.getAttribute('data-src');

  // change style
  heroBgContainer.style.backgroundImage = "url("+imgsrc+")";
  heroBgContainer.style.backgroundSize =  bgSize;
  heroBgContainer.style.margin = margin;
  heroBgContainer.style.height = heroHeight+"px";
  heroBgContainer.style.width = heroWidth+"%";
  heroBgContainer.style.overflow = overflow;
}