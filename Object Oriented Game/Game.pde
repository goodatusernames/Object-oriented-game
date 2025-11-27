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
}//end setup

void draw() {

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
  background(0);
  fill(0);
  noStroke();
  rect((-100 + squareX), (400 + squareY), 500, 1400);
  rect((900 + squareX), (400 + squareY), 500, 1400);
  rect((400 + squareX), (900 + squareY), 1400, 500);
  rect((400 + squareX), (-100 + squareY), 1400, 500);
  noFill();
  stroke(255);
  rect((400 + squareX), (400 + squareY), 500, 500);

  //end movement section

  println(squareX);
}//end draw

void keyPressed() {

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
}//end keyPressed

void keyReleased() {

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
