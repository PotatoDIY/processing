class Fire {
  PImage img;
  float x, y;
  float speed=0.5;
  int size=50;
  boolean die=false;
  Fire(float x, float y) {
    this.x=x;
    this.y=y;
    img = loadImage("fire.png");
  }
  void update() {
    y-=speed;
    speed+=0.2;
    if (y<=0) {
      die=true;
    }
    //fill(255,0,0);
    //ellipse(x, y, size, size);
    image(img,x,y,size,size);
  }
  boolean isDie(){
    return die;
  }
}
