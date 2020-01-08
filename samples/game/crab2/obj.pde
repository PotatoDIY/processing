class Obj {
  int life;
  PImage img;
  float x, y;
  float speed=(int)random(1, 5);
  int size;
  boolean die=false;
  Obj(float x, float y) {
    life=(int)random(1, 5);
    resize();
    this.x=x;
    this.y=y;
    img = loadImage("spider.png");
  }
  void resize() {
    size=life*30;
  }
  void update(Player player) {
    y+=speed;
    if (y>=height) {
      life=0;
      die=true;
    }

    if (abs(x-player.x)<(player.size+size)/2.5 && abs(y-player.y)<(player.size+size)/2.5) {
      die=true;
      if (player.life>0) {
        player.life--;
        fill(255, 0, 0);
        rect(0, 0, width, height);
        if (life>0) {
          life--;
          resize();
        } else {
          die=true;
        }
      } else {
        loop=false;
      }
    } else {
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
          killed_obj+=1;
        }
      }
    }
    if (!die) {
      fill(255,0,0);
      strokeWeight(size/50);
      stroke(169,169,169);
      line(x, 0, x, y);
      image(img, x, y, size, size);
    }
  }
  boolean isDie() {
    return die;
  }
}
