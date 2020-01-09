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
  String[] types={"fire", "bomb", "life"};

  Gift(float x, float y) {
    size = 60;
    minsize=size;
    maxsize = size*1.2;
    tosize = maxsize;
    type = types[(int)random(0, 3)];

    this.x=x;
    this.y=y;
    img = loadImage(type+".png");
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
      if (type=="bomb") {
        killed_obj+=objs.size();
        objs = new ArrayList<Obj>();
      }
      if (type=="life") {
        player.life++;
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
      
      strokeWeight(0);
      fill(255, 255, 255,80);
      ellipse(x, y, size*1.2, size*1.2);
      //fill(255, 255, 255,10);
      ellipse(x, y, size*1.5, size*1.5);
      image(img, x, y, size, size);
    }
  }
  boolean isDie() {
    return die;
  }
}
