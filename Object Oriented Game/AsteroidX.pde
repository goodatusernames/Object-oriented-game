class AsteroidX {
  float v;
  float r;
  float rockX;
  float rockY;
  PVector velo;
  PVector position;
  AsteroidX() {
    if (random(2)>1) {
      rockX = random(700, 1100);
    } else {
      rockX = random(-100,100);
    }
    rockY = random(-100,900);
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
    if (position.x > 1500||position.x<-600||position.y>1500||position.y<-500) {
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
