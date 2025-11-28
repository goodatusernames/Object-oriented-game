Ship ship;
Gun gun;
ArrayList<EnemyShip> enemyships = new ArrayList<EnemyShip>();//array of ships
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();//array of ships
int squareX;
int squareY;
float fakeVelocity;
float fakeAcceleration = .3;
float rotation = 0;
float rotationAmount = 0.02;
int maxAsteroids = 25;
//boolean hell
boolean moving;
boolean slowing;
boolean rotationLeft;
boolean rotationRight;
boolean w = false;
boolean a = false;
boolean d = false;
boolean s = false;
boolean shift = false;
//end boolean hell
void setup() {
  size(800, 800);
  rectMode(CENTER);
  ship = new Ship(width/2, height/2, fakeVelocity, rotation);
  gun = new Gun();
}//end setup

void draw() {
  background(0);
  //draw ship
  ship.move();
  //display gun
  gun.display();

  //SHIP LAND//
  /////////////

  //initialize enemies
  for (int i =0; i<enemyships.size(); i++) {
    EnemyShip s = enemyships.get(i);
    s.update(fakeVelocity, rotation);
    s.display();
  }

  //create enemy if there are none
  if (1>enemyships.size()) {
    enemyships.add(new EnemyShip());
  }
  /////////////
  //SHIP LAND//

  //ASTEROID LAND//
  /////////////////

  //initialze asteroids
  for (int i =0; i<asteroids.size(); i++) {
    Asteroid a = asteroids.get(i);
    a.update(fakeVelocity, rotation);
    a.display();
    println(a.position);
    //delete when too far away
    if (asteroids.get(i).offscreen()) {
      asteroids.remove(i);
    }
  }
  //create asteroids until max
  if (maxAsteroids>asteroids.size()) {
    asteroids.add(new Asteroid());
  }

  /////////////////
  //ASTEROID LAND//


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

  //give the illusion that things are moving
  fakeVelocity = constrain(fakeVelocity, 0, 15);

  if (moving == true) {
    fakeVelocity += fakeAcceleration;
  }
  if (slowing == true && fakeVelocity >0) {
    fakeVelocity -= fakeAcceleration*.9;
  }
  if (rotationLeft == true) {
    rotation -= rotationAmount;
  }
  if (rotationRight == true) {
    rotation += rotationAmount;
  }
  //end movement section
}//end draw

void keyPressed() {

  //ship movement
  if (key == 'w') {
    moving = true;
  }
  if (key == 's') {
    slowing = true;
  }
  if (key == 'a') {
    rotationLeft = true;
  }
  if (key == 'd') {
    rotationRight = true;
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
    moving = false;
  }
  if (key == 's') {
    slowing = false;
  }
  if (key == 'a') {
    rotationLeft = false;
  }
  if (key == 'd') {
    rotationRight = false;
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
