class Obj {
  PImage img;
  float x, y;
  int speed=(int)random(1, 5);
  int size=(int)random(30, 180);
  boolean die=false;
  Obj(float x, float y) {
    this.x=x;
    this.y=y;
    img = loadImage("spider.png");
  }
  void update(Player player) {
    y+=speed;
    //if(player.x > x){
    //  x+=1;
    //}else{
    //  x-=1;
    //}
    if (y>=height) {
      die=true;
    }
    if (abs(x-player.x)<(player.size+size)/2.5 && abs(y-player.y)<(player.size+size)/2.5) {
      player.die=true;
      die=true;
      loop=false;
    } else {
      for (int j=0; j<player.fires.size(); j++) {
        Fire f = player.fires.get(j);
        if (abs(x-f.x)<size/2 && abs(y-f.y)<size/2) {
          f.die=true;
          die=true;
          killed_obj+=1;
        }
      }
    }
    //fill(20);
    //ellipse(x, y, size, size);
    strokeWeight(size/50);
    line(x, 0, x, y);
    image(img, x, y, size, size);
  }
  boolean isDie() {
    return die;
  }
}
