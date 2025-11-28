class Gun {
  float turretAngle;
  float turretX;
  float turretY;
  PVector position;
  Gun() {
    ellipseMode(CENTER);
    fill(0);
    stroke(102, 255, 100);
    turretX = width / 2;
    turretY = height / 2;
    position = new PVector(turretX, turretY);
  }//end constructor

  void display() {
    turretAngle = atan2(mouseY - turretY, mouseX - turretX);
    pushMatrix();
    translate(position.x, position.y);
    rotate(turretAngle);
    drawGun();
    popMatrix();
  }//end display

  void drawGun() {
    rect(8, 0, 20, 5);
    ellipse(position.x, position.y, 10, 10);
  }//end drawGun
}//end gun
