class Ship {
  boolean moving;
  boolean rotationLeft;
  boolean rotationRight;
  PVector position;
  float fakeVelocity; 
  float fakeAcceleration = .1;
  float rotation = 0;
  float rotationAmount = 0.02;

  Ship(float x, float y) {
    position = new PVector(x, y);
  }
  void move() {
    
    fakeVelocity = constrain(fakeVelocity,0,15);
    
    if (rotationLeft == true) {
      rotation -= rotationAmount;
    }
    if (rotationRight == true) {
      rotation += rotationAmount;
    }
    if (moving == true) {
      fakeVelocity += fakeAcceleration;
    } else if(moving == false && fakeVelocity >0) {
      fakeVelocity -= fakeAcceleration*1.7;
    }
   
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    drawShip();
    popMatrix();
  }//end move

  void drawShip() {

    //draw ship
    noFill();
    stroke(102, 255, 100);
    beginShape();
    vertex(0, -20);
    vertex(-10, 0);
    vertex(-10, 20);
    vertex(10, 20);
    vertex(10, 0);
    vertex(0, -20);
    endShape(CLOSE);

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
  }//end drawShip
}//end class
