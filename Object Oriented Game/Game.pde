/*CONTROLS
 W = Throttle up
 S = Throttle down
 A = Turn left
 D = Turn right
 
 SHIFT + WASD = move camera to respective cardinal direction (you can move diagonally)
 Click = Shoot
 
 */

Ship ship;
Gun gun;
ArrayList<EnemyShip> enemyships = new ArrayList<EnemyShip>();//array of ships
ArrayList<Bullet> bullets = new ArrayList<Bullet>();//make array of bullets
ArrayList<AsteroidX> asteroidsX = new ArrayList<AsteroidX>();//array of asteroids
ArrayList<AsteroidY> asteroidsY = new ArrayList<AsteroidY>();
ArrayList<Grid> grids = new ArrayList<Grid>();//grid background
int squareX;
int squareY;
float gridX;
float gridY;
float fakeVelocity;
float fakeAcceleration = .3;
float rotation = 0;
float rotationAmount = 0.02;
int maxAsteroids = 40;
int gridSize = 0;
int gridMax = 500;
int life = 5;
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
boolean dead = false;
//end boolean hell

void setup() {
  size(800, 800);
  rectMode(CENTER);
  ship = new Ship(width/2, height/2, fakeVelocity, rotation);
  gun = new Gun();
}//end setup

void draw() {

  background(0);


  //check if dead
  if (life <=0) {
    dead = true;
  }

  if (!dead) {//turn off the entire game if you're dead

    //GRID LAND//
    /////////////

    for (int i =0; i<grids.size(); i++) {
      Grid g = grids.get(i);
      gridX = -25000 + i * 100;
      gridY = -25000 + i * 100;
      g.update(fakeVelocity, rotation);
      g.display();
    }
    //create grid lines
    if (gridMax>grids.size()) {
      grids.add(new Grid(gridX, gridY));
    }

    /////////////
    //GRID LAND//

    //BULLET LAND//
    ///////////////

    for (int i =0; i<bullets.size(); i++) {
      Bullet b = bullets.get(i);
      b.update(fakeVelocity, rotation);
      b.display();
      b.bulletHitBox();
    }

    if ( bullets.size() >= 1) {
      if (bullets.get(0).offscreen()) {
        bullets.remove(0);
      }
    }

    //BULLET LAND//
    ///////////////

    //draw ship
    ship.move();
    //display gun
    gun.display();
    gun.drawGun();

    //SHIP LAND//
    /////////////

    //initialize enemies
    for (int i =0; i<enemyships.size(); i++) {
      EnemyShip s = enemyships.get(i);
      s.update(fakeVelocity, rotation);
      s.display();
      println(s.position);
    }

    //create enemy if there are none
    if (1>enemyships.size()) {
      enemyships.add(new EnemyShip());
    }
    /////////////
    //SHIP LAND//

    //ASTEROID LAND//
    /////////////////

    //initialze asteroids for X
    for (int i =0; i<asteroidsX.size(); i++) {
      AsteroidX ax = asteroidsX.get(i);
      ax.update(fakeVelocity, rotation);
      ax.display();

      //delete when too far away
      if (asteroidsX.get(i).offscreen()) {
        asteroidsX.remove(i);
      }
    }
    //create asteroids until max
    if (maxAsteroids>asteroidsX.size()) {
      asteroidsX.add(new AsteroidX());
    }
    //initialize for Y
    for (int i =0; i<asteroidsY.size(); i++) {
      AsteroidY ay = asteroidsY.get(i);
      ay.update(fakeVelocity, rotation);
      ay.display();
      //delete when too far away
      if (asteroidsY.get(i).offscreen()) {
        asteroidsY.remove(i);
      }
    }
    //create asteroids until max
    if (maxAsteroids>asteroidsY.size()) {
      asteroidsY.add(new AsteroidY());
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
    //draw box around screen
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

    //ASTEROID DELETER 9000//
    /////////////////////////

    //start collision AsteroidX
    if ( bullets.size() >= 1 && asteroidsX.size() >=1) {
      for (int i =0; i<bullets.size(); i++) {
        for (int u =0; u<asteroidsX.size(); u++) {
          if (collision(bullets.get(i), asteroidsX.get(u))) {
            //delete ship that was collided with
            asteroidsX.remove(u);
            bullets.remove(i);
            //make the ships on screen move faster when their friends are killed
            break;
          }
        }
      }
    }//end collision AsteroidX

    //start collision AsteroidY
    if ( bullets.size() >= 1 && asteroidsY.size() >= 1) {
      for (int i =0; i<bullets.size(); i++) {
        for (int y =0; y<asteroidsY.size(); y++) {
          if (collision(bullets.get(i), asteroidsY.get(y))) {
            //delete ship that was collided with
            asteroidsY.remove(y);
            bullets.remove(i);
            //make the ships on screen move faster when their friends are killed
            break;
          }
        }
      }
    }//end collision AsteroidY

    //Ship AsteroidY
    if (asteroidsY.size() >= 1) {
      for (int y =0; y<asteroidsY.size(); y++) {
        if (shipCollision(ship, asteroidsY.get(y))) {
          asteroidsY.remove(y);
          life = life -1;
          break;
        }
      }
    }//end Ship AsteroidY

    //Ship AsteroidY
    if (asteroidsX.size() >= 1) {
      for (int u =0; u<asteroidsX.size(); u++) {
        if (shipCollision(ship, asteroidsX.get(u))) {
          asteroidsX.remove(u);
          life = life -1;
          break;
        }
      }
    }//end Ship AsteroidY



    //ASTEROID DELETER 9000//
    /////////////////////////
  } else { //if dead end
    //clear everything
    asteroidsX.clear();
    asteroidsY.clear();
    bullets.clear();
    grids.clear();
    //death screen
    fill(102, 255, 100);
    textSize(100);
    text("You died", 200, 300);
    textSize(20);
    text("press 'r' to restart!", 300, 600);
  }//else end
}//end draw

//COLLISION DETECTOR//
//////////////////////

//AsteroidX collision
boolean collision(Bullet b, AsteroidX ax) {
  float bx = b.position.x;
  float by = b.position.y;
  float br = b.radius;
  float axx = ax.position.x;
  float axy = ax.position.y;
  float axr = ax.radius;
  float distanceX = dist (bx, by, axx, axy);
  if (distanceX < (br-10) + (axr-10)) { //checks if bullet collides with asteroid
    return true;
  } else {
    return false;
  }
}//end AsteroidX

//AsteroidY collison
boolean collision(Bullet b, AsteroidY ay) {
  float bx = b.position.x;
  float by = b.position.y;
  float br = b.radius;
  float ayx = ay.position.x;
  float ayy = ay.position.y;
  float ayr = ay.radius;
  float distanceX = dist (bx, by, ayx, ayy);
  if (distanceX < (br-10) + (ayr-10)) { //checks if bullet collides with asteroid
    return true;
  } else {
    return false;
  }
}//end AsteroidY

//Ship AsteroidY
boolean shipCollision(Ship s, AsteroidY ay) {
  float sx = s.position.x;
  float sy = s.position.y;
  float sr = s.radius;
  float ayx = ay.position.x;
  float ayy = ay.position.y;
  float ayr = ay.radius;
  float distanceX = dist (sx, sy, ayx, ayy);
  if (distanceX < (sr-10) + (ayr-10)) { //checks if bullet collides with asteroid
    return true;
  } else {
    return false;
  }
}//end Ship AsteroidY

//Ship AsteroidX
boolean shipCollision(Ship s, AsteroidX ax) {
  float sx = s.position.x;
  float sy = s.position.y;
  float sr = s.radius;
  float axx = ax.position.x;
  float axy = ax.position.y;
  float axr = ax.radius;
  float distanceX = dist (sx, sy, axx, axy);
  if (distanceX < (sr-10) + (axr-10)) { //checks if bullet collides with asteroid
    return true;
  } else {
    return false;
  }
}//end Ship AsteroidX

//////////////////////
//COLLISION DETECTOR//

void mousePressed() {
  //shoot bullet when click
  bullets.add(new Bullet());
}//end mousePressed

void keyPressed() {

  //restart game
  if (key == 'r') {
    dead = false;
    life = 5;
  }

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

  //camera movement
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

  //end camera movement
}//end released
