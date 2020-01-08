Player player;
ArrayList<Obj> objs;
ArrayList<Gift> gifts;
int objtime=0;
int gifttime=0;
String gameover = "GAME OVER";
String gameoverinfo = "press key 'R' to Restart";
PFont font80, font30;
boolean loop=false;
int killed_obj;
void setup() {
  
  //font80 = createFont(PFont.list()[2], 80);
  //font30 = createFont(PFont.list()[2], 30);
  font80=createFont("SourceSansPro-Light.ttf", 80);
  font30=createFont("SourceSansPro-Light.ttf", 30);
  fill(0);
  size(1000, 600);
  //size(displayWidth,displayHeight);
  ellipseMode(CENTER);
  imageMode(CENTER);
  init();
}

void init() {
  killed_obj=0;
  player = new Player(width/2, height-30);
  objs = new ArrayList<Obj>();
  gifts = new ArrayList<Gift>();
  loop=true;
}

void draw() {
  if (loop) {
    background(128,128,128);
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
    
  } else {
    // game over
    print("game over\n");
    fill(0);
    rect(0, 0, width, height);
    fill(255);
    textFont(font80);
    text(gameover, width/2-gameover.length()*25, height/2);
    textFont(font30);
    text(gameoverinfo, width/2-gameoverinfo.length()*7, height/2+40);
  }
}



void keyPressed() {
  //print(byte(key));
  if (key == 'a') {
    //left
    player.left();
  }
  if (key == 'd') {
    //right
    player.right();
  }
  if (key == ' ') {
    //space
    player.fire();
  }
  if (key == 's') {
    //stop
    player.stop();
  }
  if (key == 'r') {
    //space
    init();
  }
}
