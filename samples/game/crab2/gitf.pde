class Gift {

  String type;
  PImage img;
  float x, y;
  float speed=1;
  float minsize;
  float size;
  float maxsize;
  float tosize;
  boolean die=false;
  Gift(float x, float y) {
    size = 60;
    minsize=size;
    maxsize = size*1.2;
    tosize = maxsize;
    type = "fire";
    this.x=x;
    this.y=y;
    img = loadImage("fire.png");
  }
  void update(Player player) {
    y+=speed;
    if (y>=height) {
      die=true;
    }

    if (abs(x-player.x)<(player.size+size)/2.5 && abs(y-player.y)<(player.size+size)/2.5) {
      die=true;
      if (type=="fire") {
        player.firesnum+=20;
      }
    } 
    if (!die) {
      if (size>=tosize) {
        tosize=minsize;
      } else {
        size+=0.5;
      }
      if (size<=tosize) {
        tosize=maxsize;
      } else {
        size-=0.5;
      }
      fill(0, 255, 0);
      strokeWeight(0);
      ellipse(x, y, size*1.2, size*1.2);
      image(img, x, y, size, size);
    }
  }
  boolean isDie() {
    return die;
  }
}
