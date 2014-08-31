// instagram.js
// rishi ghan
// ninth muse and the usuals

var jiff = function(){
 var clientid = "9f748070d00748cf8c845f874800ab00",
     clientsecret = "436bcc784d874a9bb3a450eb138b3193";

}

jiff.prototype = {

  start: function(url, callback){
    var request = new XMLHttpRequest();
    request.open("GET", url);
    // handle the event
    request.onreadystatechange = function(){
      if(request.readyState == 4 && request.status == 200){
        callback(request.responseText)

      }
    }
    request.send(null);
  },

  spill: function(response){

    console.log(response);

  }

}