class Player {
  int life;
  String to;
  PImage img;
  float x, y;
  int speed=5;
  int size=80;
  ArrayList<Fire> fires = new ArrayList<Fire>();
  int firesnum;
  boolean die=false;
  Player(float x, float y) {
    life=3;
    this.x=x;
    this.y=y;
    img = loadImage("crab.png");
    firesnum = 30;
    stop();
  }
  void left() {
    to = "left"; //left
  }
  void right() {
    to = "right"; //right
  }
  void stop() {
    to = "stop" ;//stop
  }
  void fire() {
    if (firesnum>0) {
      fires.add(new Fire(x, y));
      firesnum--;
    }
  }
  void update() {
    if (to=="left") {
      x-=speed;
    } else if (to=="right") {
      x+=speed;
    }
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
    image(img, x, y, size, size);
  }
}
