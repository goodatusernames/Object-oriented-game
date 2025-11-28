Ship ship;
Gun gun;

int squareX;
int squareY;
//boolean hell
boolean w = false;
boolean a = false;
boolean d = false;
boolean s = false;
boolean shift = false;
//end boolean hell
void setup() {
  size(800, 800);
  rectMode(CENTER);
  ship = new Ship(width/2, height/2);
  gun = new Gun();
}//end setup

void draw() {

  background(0);
  ship.move();
  gun.display();


  //camera movement
  if (w) {
    squareY = -200;
  } else if ((!s)&&(!w)) {
    squareY = 0;
  }
  if (a) {
    squareX = -200;
  } else {
    if ((!d)&&(!a))
      squareX = 0;
  }
  if (s) {
    squareY = 200;
  } else if ((!s)&&(!w)) {
    squareY = 0;
  }
  if (d) {
    squareX = 200;
  } else if ((!d)&&(!a)) {
    squareX = 0;
  }
  //draw box

  fill(0);
  noStroke();
  rect((-100 + squareX), (400 + squareY), 500, 1400);
  rect((900 + squareX), (400 + squareY), 500, 1400);
  rect((400 + squareX), (900 + squareY), 1400, 500);
  rect((400 + squareX), (-100 + squareY), 1400, 500);
  noFill();
  stroke(102, 255, 100);
  rect((400 + squareX), (400 + squareY), 500, 500);
  //end movement section
}//end draw

void keyPressed() {

  //ship movement
  if (key == 'w') {
    ship.moving = true;
  }
  if (key == 's') {
    ship.slowing = true;
  }
  if (key == 'a') {
    ship.rotationLeft = true;
  }
  if (key == 'd') {
    ship.rotationRight = true;
  }
  //end ship movement

  //camera movement
  if (key == 'W') {
    w = true;
  }

  if (key == 'A') {
    a = true;
  }

  if (key == 'S') {
    s = true;
  }

  if (key == 'D') {
    d = true;
  }
  //end camera movement
}//end keyPressed

void keyReleased() {

  //ship movement
  if (key == 'w') {
    ship.moving = false;
  }
  if (key == 's') {
    ship.slowing = false;
  }
  if (key == 'a') {
    ship.rotationLeft = false;
  }
  if (key == 'd') {
    ship.rotationRight = false;
  }
  //end ship movement


  if (key == 'W') {
    w = false;
  }

  if (key == 'A') {
    a = false;
  }

  if (key == 'S') {
    s = false;
  }

  if (key == 'D') {
    d = false;
  }
}//end released
