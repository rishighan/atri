// instagram.js
// rishi ghan
// ninth muse and the usuals

//Details:
//clientid: 9f748070d00748cf8c845f874800ab00
//redirect_uri: http://rishighan.com/photolog


//self calling function
var Instashizzle = function(){}

Instashizzle.prototype = {

  init: function(options){
    if(options){
      this.url = "https://instagram.com/oauth/authorize/?client_id="+options.clientid+"&redirect_uri="+options.redirect_uri+"&response_type=token";
    }
    this.authenticate(this.url);
  },

  authenticate: function(url){
    window.location.replace(url);
    this.connect(this.getToken());
  },

  getToken: function(){
    var hash = window.location.hash,
        regex = "[^\#access_token\=](.*)",
        token = [];
    if(hash){
      token = hash.match(regex);

      if(token){
        return token[1];
      }
      else{
        return false;
      }
    }

  }
}