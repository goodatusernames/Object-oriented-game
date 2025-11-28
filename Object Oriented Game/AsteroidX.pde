class AsteroidX {
  float v;
  float r;
  float shipX;
  PVector position;
  AsteroidX() {
    if (random(2)>1) {
      shipX = random(900, 1300);
    } else {
      shipX = random(-400, 0);
    }
  }//end constructor

  void update(float velocity, float rotation) {
    v = velocity;
    r = rotation;
    position = new PVector();
  }//end update

  void display() {
  }//end display
}//end class
