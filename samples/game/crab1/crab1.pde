Player player;
ArrayList<Obj> objs;
int time=0;
String gameover = "GAME OVER";
String gameoverinfo = "press key 'R' to restart";
PFont font80, font30;
boolean loop=false;
int killed_obj;
void setup() {
  font80 = createFont(PFont.list()[2], 80);
  font30 = createFont(PFont.list()[2], 30);
  //PFont myFont=createFont("SourceCodePro-Regular.ttf", 80);
  fill(0);
  //size(600, 800);
  size(displayWidth,displayHeight);
  ellipseMode(CENTER);
  imageMode(CENTER);
  init();
}

void init() {
  killed_obj=0;
  player = new Player(width/2, height-70);
  objs = new ArrayList<Obj>();
  //for (int i=0; i<5; i++) {
  //  objs.add(new Obj(random(50, width-50), 0-random(10, 200)));
  //}
  loop=true;
}

void draw() {
  if (loop) {
    time+=1;
    //print(time);
    print("\n");
    if (time>=50) {
      objs.add(new Obj(random(50, width-50), 0));
      time=0;
    }

    fill(20, 20, 20);
    background(255);
    for (int i=0; i<objs.size(); i++) {
      Obj o = objs.get(i);
      if (o.isDie()) {
        objs.remove(i);
      } else {
        o.update(player);
      }
    }
    textFont(font30);
    text("killed spider:"+killed_obj, 20, 30);
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
    text(gameoverinfo, width/2-gameoverinfo.length()*6, height/2+40);
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
  if (key == 'r') {
    //space
    init();
  }
}
