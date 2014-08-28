var arr = [1,2,3,1,3,4,5,7,8,5,2]


function listops(list){


}

listops.prototype ={

    contains: function(el){
        for(var i=0; i<this.length; i++){
            if(list[i]===el){
             return true;
            }
        }
        return false;
    },

    unique: function(){
        var output =[];
        for(var j=0; j<this.length; j++){
            if(!output.contains(list[j])){
             output.push(list[j]);
               }

        }
        return output;
},

    occurance: function(kel){
     var count =0;
        for(var l=0; l<this.length; l++){
            if(this.contains(kel)){
                count++;
            }
        }
     return count;
    }

};
