var MainClass = function(){};

MainClass.prototype = {
  initialize : function() {
    $("#navigation-header a").hover(main_class.toggle_image, main_class.toggle_image);
  },
  toggle_image : function() {
    obj_name = "#" + this.id + " img";
    obj = $(obj_name);
    current_src = obj.attr("src");
    if(current_src.search("_sel") == -1) {
      new_src = current_src.replace(/.png$/, "_sel.png");
      obj.attr("src", new_src);
    }
    else {
      new_src = current_src.replace(/_sel.png$/, ".png");
      obj.attr("src", new_src);
    }
  }
};

$(document).ready(function(event){
  main_class = new MainClass;
  main_class.initialize();
});