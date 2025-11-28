class EnemyShip {
  float v;
  float r;
  float shipX;
  float shipY;
  float radius = 25;
  float turretX;
  float turretY;
  float shipAngle;
  float speed = -1;
  PVector velo;
  PVector position;
  PVector shipVelo;

  EnemyShip() {
    //set ship pos randomly
    if (random(2)>1) {
      shipX = random(850, 1600);
    } else {
      shipX = random(-800, -50);
    }

    if (random(2)>1) {
      shipY = random(850, 1600);
    } else {
      shipY = random(-800, -50);
    }

    position = new PVector(shipX, shipY);
    turretX = width / 2;
    turretY = height / 2;
  }

  void update(float velocity, float rotation) {
    shipAngle = atan2(position.y - turretY, position.x - turretX);
    v = velocity/6;
    r = rotation;
    velo = new PVector(0, v);
    shipVelo = new PVector(speed, 0);
    shipVelo.rotate(shipAngle);
    velo.rotate(r);
    position.add(velo);
    position.add(shipVelo);
  }//end update

  void display() {

    pushMatrix();
    translate(position.x, position.y);
    rotate(shipAngle);
    drawShip();
    popMatrix();
  }

  //draw the ships
  void drawShip() {
    fill(0);
    stroke(255, 0, 0);
    strokeWeight(1);
    beginShape();
    vertex(10, 10);
    vertex(10, -10);
    vertex(-10, 0);

    endShape(CLOSE);
  }

  boolean shipOffscreen() {
    if (position.y > 400) {
      return true;
    } else {
      return false;
    }
  }

  //hitbox for the ship
  void shipHitBox() {
    noFill();
    noStroke();
    ellipseMode(CENTER);
    ellipse(position.x, position.y, radius, radius);
  }
}
