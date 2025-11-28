class Ship {
  PVector position;

  Ship(float x, float y, float fakeVelocity, float rotation) {
    position = new PVector(x, y);
  }
  void move() {

    //place the ship at the center of the screen
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    drawShip();
    popMatrix();
  }//end move

  void drawShip() {

    //draw flame
    if (moving == true||fakeVelocity >0) {
      for (int i = 1; i < 5; i++) {
        fill(102, 255, 100, random(100, 255));
        noStroke();
        circle(0, (i * 5)+fakeVelocity, 8 / i);
        circle(5, (i * 5)+fakeVelocity+2, 8 / i);
        circle(-5, (i * 5)+fakeVelocity+2, 8 / i);
      }
    }

    //draw ship
    fill(0);
    noStroke();
    rectMode(CENTER);
    rect(0, 10, 20, 20);
    stroke(102, 255, 100);
    strokeWeight(1);
    beginShape();
    vertex(0, -20);
    vertex(-10, 0);
    vertex(-10, 20);
    vertex(10, 20);
    vertex(10, 0);
    vertex(0, -20);
    endShape(CLOSE);
  }//end drawShip
}//end class
