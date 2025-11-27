class Ship {
  boolean moving;
  boolean slowing;
  boolean rotationLeft;
  boolean rotationRight;
  PVector position;
  float fakeVelocity; 
  float fakeAcceleration = .3;
  float rotation = 0;
  float rotationAmount = 0.02;

  Ship(float x, float y) {
    position = new PVector(x, y);
  }
  void move() {
    
    //give the illusion that things are moving
    fakeVelocity = constrain(fakeVelocity,0,15);
 
     if (moving == true) {
      fakeVelocity += fakeAcceleration;
    } 
    if(slowing == true && fakeVelocity >0) {
      fakeVelocity -= fakeAcceleration*.9;
    }
    
    if (rotationLeft == true) {
      rotation -= rotationAmount;
    }
    if (rotationRight == true) {
      rotation += rotationAmount;
    }
 
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
    rect(0,10,20,20);
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

  }//end drawShip
}//end class
