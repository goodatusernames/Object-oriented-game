class AsteroidY {
  float v;
  float r;
  float radius = 40;
  float rockX;
  float rockY;
  PVector velo;
  PVector position;
  AsteroidY() {
    if (random(2)>1) {
      rockY = random(850, 1600);
    } else {
      rockY = random(-800, -50);
    }
    rockX = random(-100,900);
    position = new PVector(rockX, rockY);
  }//end constructor

  void update(float velocity, float rotation) {
    v = velocity/6;
    r = rotation;
    velo = new PVector(0,v);
    velo.rotate(r);
    position.add(velo);
  }//end update

boolean offscreen() {
    if (position.x > 2000||position.x<-1100||position.y>2000||position.y<-1100) {
      return true;
    } else {
      return false;
    }
  }//end offscreen

  void display() {
    noStroke();
    fill(255,0,0);
    ellipse(position.x, position.y, 50, 50);
  }//end display
}//end class
