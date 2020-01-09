Player player;
ArrayList<Obj> objs;
ArrayList<Gift> gifts;
int objtime=0;
int gifttime=0;
PFont font80, font30;
boolean loop=false;
int killed_obj;
Screen screen;
boolean pause;
PImage bg;
void setup() {
  screen = new Screen();
  //font80 = createFont(PFont.list()[2], 80);
  //font30 = createFont(PFont.list()[2], 30);
  font80=createFont("SourceSansPro-Light.ttf", 80);
  font30=createFont("SourceSansPro-Light.ttf", 30);
  fill(0);
  size(1000, 600);
  //size(displayWidth,displayHeight);
  ellipseMode(CENTER);
  imageMode(CENTER);
  screen.ready();
  //bg = loadImage("bg.jpeg");
}

void init() {
  killed_obj=0;
  player = new Player(width/2, height-50);
  objs = new ArrayList<Obj>();
  gifts = new ArrayList<Gift>();
  loop=true;
  pause=false;
}

void draw() {
  if (loop && !pause) {
    //background(bg);
    background(0);
    objtime+=1;
    gifttime+=1;
    //print(time);
    print("\n");
    if (objtime>=50) {
      objs.add(new Obj(random(50, width-50), 0));
      objtime=0;
    }
    if (gifttime>=500) {
      gifts.add(new Gift(random(50, width-50), 0));
      gifttime=0;
    }

    for (int i=0; i<objs.size(); i++) {
      Obj o = objs.get(i);
      if (o.isDie()) {
        objs.remove(i);
      } else {
        o.update(player);
      }
    }

    for (int g=0; g<gifts.size(); g++) {
      Gift gift = gifts.get(g);
      if (gift.isDie()) {
        gifts.remove(g);
      } else {
        gift.update(player);
      }
    }
    textFont(font30);
    fill(255);
    text("life:"+player.life, 20, 30);
    text("killed spider:"+killed_obj, 20, 60);
    text("fires:"+player.firesnum, 20, 90);
    player.update();
  } else if (loop && pause) {
    screen.pause();
  }
}



void keyPressed() {
  //print(byte(key));
  if (key == 'a') {
    //left
    if (loop) {
      player.left();
    }
  }
  if (key == 'd') {
    //right
    if (loop) {
      player.right();
    }
  }
  if (key == 'w') {
    //right
    if (loop) {
      player.up();
    }
  }
  if (key == 's') {
    //right
    if (loop) {
      player.down();
    }
  }
  if (key == ' ') {
    //space
    if (loop) {
      player.fire();
    }
  }
  if (key == 'p') {
    //pause
    if (loop) {
      pause=!pause;
    }
  }
  if (key == 'r') {
    //space
    if (!loop) {
      init();
    }
  }
}
