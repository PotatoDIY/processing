class Player {
  PImage img;
  float x, y;
  int speed=5;
  int size=80;
  ArrayList<Fire> fires = new ArrayList<Fire>();
  boolean die=false;
  Player(float x, float y) {
    this.x=x;
    this.y=y;
    img = loadImage("crab.png");
  }
  void left() {
    x-=speed;
  }
  void right() {
    x+=speed;
  }
  void fire() {
    fires.add(new Fire(x, y));
  }
  void update() {
    if (x<=0+size/2) {
      x=0+size/2;
    }
    if (x>=width-size/2) {
      x=width-size/2;
    }
    for (int i=0; i<fires.size(); i++) {
      Fire f = fires.get(i);
      if (f.isDie()) {
        fires.remove(i);
      } else {
        f.update();
      }
    }
    fill(50);
    //ellipse(x, y, size, size);
    image(img,x,y,size,size);
    
  }
}
