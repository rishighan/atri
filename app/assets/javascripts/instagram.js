// instagram.js
// rishi ghan
// ninth muse and the usuals

var jiff = function(){

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
  }

}