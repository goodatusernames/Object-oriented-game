class Bullet {
  PVector position;
  PVector velo;
  PVector bulletVelo;
  float v;
  float r;
  float speed = 5;
  float bulletY = height/2;
  float bulletX = width/2;
  float radius = 10;
  float turretAngle;
  float turretX;
  float turretY;

  Bullet() {
    position = new PVector(bulletX, bulletY);
    turretX = width / 2;
    turretY = height / 2;
    turretAngle = atan2(mouseY - turretY, mouseX - turretX);
  }

  void update(float velocity, float rotation) {
    v = velocity/6;
    r = rotation;
    velo = new PVector(0, v);
    bulletVelo = new PVector(speed, 0);
    bulletVelo.rotate(turretAngle);
    velo.rotate(r);
    position.add(velo);
    position.add(bulletVelo);
  }//end update

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(turretAngle);
    drawBullet();
    popMatrix();
  }

  //draw the bullet at the ships current position
  void drawBullet() {
    fill(102, 255, 100);
    rectMode(CENTER);
    rect(0, 0, 8, 4);
  }

  //checker to see if bullet is off screen
  boolean offscreen() {
    if (position.y < 0||position.y > 800|| position.x < 0|| position.y >800) {
      return true;
    } else {
      return false;
    }
  }

  //hitbox for the bullet
  void bulletHitBox() {
    noFill();
    noStroke();
    ellipseMode(CENTER);
    ellipse(position.x, position.y, radius, radius);
  }
}
