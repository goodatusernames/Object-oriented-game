class Grid {
  float v;
  float r;
  float gx;
  float gy;
  PVector velo;
  PVector position;
  PVector gridPosition;
  Grid(float gridX, float gridY) {
    gx = gridX;
    gy = gridY;
    position = new PVector(0, 0);
    gridPosition = new PVector(gx, gy);
    position.add(gridPosition);
  }//end constructor

  void update(float velocity, float rotation) {
    v = velocity/6;
    r = rotation;
    velo = new PVector(0, v);
    velo.rotate(r);
    position.add(velo);
  }//end update


  void display() {
    strokeWeight(1);
    stroke(102, 255, 100, 80);
    line(-1000, position.y, 1000, position.y);
    line(position.x, -1000, position.x, 1000);
  }//end display
}//end class
