class Bullet {
  PVector position;
  PVector velocity;
  
  // create a bullet at the starting position, aimed at a target position
  Bullet(float startX, float startY, float targetX, float targetY) {
    position = new PVector(startX, startY);
    PVector target = new PVector(targetX, targetY);
    velocity = PVector.sub(target, position);
    velocity.setMag(6);  // bullet speed
  }

  void update() {
    position.add(velocity);
  }

  void display() {
    fill(255, 0, 0);
    noStroke();
    ellipse(position.x, position.y, 5, 5);
  }

  // if the bullet is out of bounds
  boolean isOutOfBounds() {
    return position.x < 0 || position.x > width || position.y < 0 || position.y > height;
  }
}
