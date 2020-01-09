import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class crab2 extends PApplet {

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
public void setup() {
  screen = new Screen();
  //font80 = createFont(PFont.list()[2], 80);
  //font30 = createFont(PFont.list()[2], 30);
  font80=createFont("SourceSansPro-Light.ttf", 80);
  font30=createFont("SourceSansPro-Light.ttf", 30);
  fill(0);
  
  //size(displayWidth,displayHeight);
  ellipseMode(CENTER);
  imageMode(CENTER);
  screen.ready();
  //bg = loadImage("bg.jpeg");
}

public void init() {
  killed_obj=0;
  player = new Player(width/2, height-50);
  objs = new ArrayList<Obj>();
  gifts = new ArrayList<Gift>();
  loop=true;
  pause=false;
}

public void draw() {
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



public void keyPressed() {
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
class Fire {
  PImage img;
  float x, y;
  float speed=0.5f;
  float size=32;
  boolean die=false;
  Fire(float x, float y) {
    this.x=x;
    this.y=y;
    img = loadImage("fire.png");
  }
  public void update() {
    y-=speed;
    speed+=0.1f;
    if (y<=0) {
      die=true;
    }
    //fill(255,0,0);
    //ellipse(x, y, size, size);
    image(img, x, y, size, size);
  }
  public boolean isDie() {
    return die;
  }
}
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
    maxsize = size*1.2f;
    tosize = maxsize;
    type = types[(int)random(0, 3)];

    this.x=x;
    this.y=y;
    img = loadImage(type+".png");
  }
  public void update(Player player) {
    y+=speed;
    if (y>=height) {
      die=true;
    }

    if (abs(x-player.x)<(player.size+size)/2.5f && abs(y-player.y)<(player.size+size)/2.5f) {
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
        size+=0.5f;
      }
      if (size<=tosize) {
        tosize=maxsize;
      } else {
        size-=0.5f;
      }
      
      strokeWeight(0);
      fill(255, 255, 255,80);
      ellipse(x, y, size*1.2f, size*1.2f);
      //fill(255, 255, 255,10);
      ellipse(x, y, size*1.5f, size*1.5f);
      image(img, x, y, size, size);
    }
  }
  public boolean isDie() {
    return die;
  }
}
class Obj {
  int life;
  PImage img;
  float x, y;
  float speed=(int)random(1, 5);
  float size;
  boolean die=false;
  int[] types={0, 1, 2};
  Obj(float x, float y) {
    life=(int)random(1, 5);
    resize();
    this.x=x;
    this.y=y;
    int type = types[(int)random(0, 3)];
    img = loadImage("spider"+type+".png");
  }
  public void resize() {
    size=life*30;
  }
  public void update(Player player) {
    y+=speed;
    if (y>=height*2) {
      y = -200;
    }
    if (abs(x-player.x)<(player.size+size)/2.5f && abs(y-player.y)<(player.size+size)/2.5f) {
      if (player.life>=1) {
        player.life--;
        fill(255, 0, 0);
        rect(0, 0, width, height);
      }
      if (player.life==0) {
        loop=false;
        screen.gameover();
      }
      if (player.life>0) {
        if (life>1) {
          life--;
          resize();
        } else {
          die=true;
        }
      }
    }
    for (int j=0; j<player.fires.size(); j++) {
      Fire f = player.fires.get(j);
      if (abs(x-f.x)<size/2 && abs(y-f.y)<size/2) {
        f.die=true;
        if (life>1) {
          life--;
          resize();
        } else {
          die=true;
        }
      }
    }
    if (!die) {
      //strokeWeight(0);
      //fill(255, 255, 255, 80);
      //ellipse(x, y, size*1.2, size*1.2);
      fill(255, 0, 0);
      strokeWeight(size/50);
      stroke(169, 169, 169);
      line(x, 0, x, y);
      image(img, x, y, size, size);
    } else {
      killed_obj+=1;
    }
  }
  public boolean isDie() {
    return die;
  }
}

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
  public void up() {
    to = "up";
  }
  public void down() {
    to = "down";
  }
  public void left() {
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
  public void right() {
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
  public void stop() {
    to = "stop" ;//stop
  }
  public void fire() {
    if (firesnum>0) {
      fires.add(new Fire(x, y));
      firesnum--;
    }
  }
  public void update() {
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

class Screen {
  String gameover = "GAME OVER";
  String gametitle = "Crab 2";
  String gameoverinfo = "press key 'R' to Restart";
  String pause = "PAUSE";
  String gameinfo = "press key 'R' to Start\n press key 'A' to left\n preee key 'D' to right\n press key 'Space' to fire";
  Screen() {
  }
  public void gameover() {
    fill(0);
    rect(0, 0, width, height);
    fill(255);
    textFont(font80);
    text(gameover, width/2-gameover.length()*25, height/2);
    textFont(font30);
    text(gameoverinfo, width/2-gameoverinfo.length()*7, height/2+40);
  }
  public void ready() {
    fill(0);
    rect(0, 0, width, height);
    fill(255);
    textFont(font80);
    text(gametitle, width/2-gametitle.length()*25, height/2);
    textFont(font30);
    text(gameinfo, 30, height/2+40);
  }
  public void pause() {
    fill(0,0,0,2);
    rect(0, 0, width, height);
    fill(255);
    textFont(font80);
    text(pause, width/2-gametitle.length()*25, height/2);
  }
}
  public void settings() {  size(1000, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "crab2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
