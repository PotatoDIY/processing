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
  void resize() {
    size=life*30;
  }
  void update(Player player) {
    y+=speed;
    if (y>=height*2) {
      y = -200;
    }
    if (abs(x-player.x)<(player.size+size)/2.5 && abs(y-player.y)<(player.size+size)/2.5) {
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
  boolean isDie() {
    return die;
  }
}
