class Screen {
  String gameover = "GAME OVER";
  String gametitle = "Crab 2";
  String gameoverinfo = "press key 'R' to Restart";
  String gameinfo = "press key 'R' to Start\n press key 'A' to left\n preee key 'D' to right\n press key 'Space' to fire";
  Screen() {
  }
  void gameover() {
    fill(0);
    rect(0, 0, width, height);
    fill(255);
    textFont(font80);
    text(gameover, width/2-gameover.length()*25, height/2);
    textFont(font30);
    text(gameoverinfo, width/2-gameoverinfo.length()*7, height/2+40);
  }
  void ready() {
    fill(0);
    rect(0, 0, width, height);
    fill(255);
    textFont(font80);
    text(gametitle, width/2-gametitle.length()*25, height/2);
    textFont(font30);
    text(gameinfo, 30, height/2+40);
  }
}
