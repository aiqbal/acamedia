toggle_image = function() {
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

$(document).ready(function(event){
  $("#navigation-header a").hover(toggle_image, toggle_image);
});