class Player {
  int life;
  String to;
  PImage img;
  float x, y;
  float speed;
  float minspeed = 3;
  float maxspeed = 10;
  float size=80;
  ArrayList<Fire> fires = new ArrayList<Fire>();
  int firesnum;
  boolean die=false;
  Player(float x, float y) {
    speed = minspeed;
    life=1;
    this.x=x;
    this.y=y;
    img = loadImage("crab.png");
    firesnum = 30;
    stop();
    to = "stop";
  }
  void up() {
    to = "up";
  }
  void down() {
    to = "down";
  }
  void left() {
    to = "left"; //left
    //if (speed==0) {
    //  to = "left"; //left
    //}

    //if (to=="left") {
    //  speed+=1;
    //} else if (to =="right") {
    //  speed-=1;
    //}
    //if (speed>=maxspeed) {
    //  speed=maxspeed;
    //}
    //if (speed<=0) {
    //  speed=0;
    //}
  }
  void right() {
    to = "right"; //right
    //if (speed==0) {
    //  to = "right"; //right
    //}
    //if (to !="left") {
    //  speed+=1;
    //} else {
    //  speed-=1;
    //}
    //if (speed>=maxspeed) {
    //  speed=maxspeed;
    //}
    //if (speed<=0) {
    //  speed=0;
    //}
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
    } else if (to=="up") {
      y-=speed;
    } else if (to=="down") {
      y+=speed;
    }
    if (x<=0+size/2) {
      x=0+size/2;
      //speed=0;
    }
    if (x>=width-size/2) {
      x=width-size/2;
      //speed=0;
    }

    if (y<=0+size/2) {
      y=0+size/2;
      //speed=0;
    }
    if (y>=height-size/2) {
      y=height-size/2;
      //speed=0;
    }

    for (int i=0; i<fires.size(); i++) {
      Fire f = fires.get(i);
      if (f.isDie()) {
        fires.remove(i);
      } else {
        f.update();
      }
    }
    //ellipse(x, y, size, size);
    //strokeWeight(0);
    //fill(255, 255, 255, 80);
    //ellipse(x, y, size*1.2, size*1.2);
    image(img, x, y, size, size);
  }
}
