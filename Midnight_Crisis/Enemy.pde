class Enemy {
  PVector position;
  float speed = 2;
  
  int health = 2;
  boolean isHit = false;
  int hitTimer = 0;
  
  Enemy(float x, float y) {
    position = new PVector(x, y);
  }

  void display() {
    // darw enemy hit
    if (isHit && hitTimer > 0) {
      fill(255, 0, 0);
      stroke(255, 0, 0);
      hitTimer--;  // decrease timer
    } else {
      fill(0);
      stroke(0);
      isHit = false;  // reset hit status
    }
    ellipse(position.x, position.y, 12, 12);
    
    line(position.x, position.y, position.x + 9, position.y - 5);
    line(position.x + 9, position.y - 5, position.x + 12, position.y - 2);
    line(position.x, position.y + 5, position.x + 9, position.y);
    line(position.x + 9, position.y, position.x + 12, position.y + 3);

    line(position.x, position.y, position.x - 9, position.y - 5);
    line(position.x - 9, position.y - 5, position.x - 12, position.y - 2);
    line(position.x, position.y + 5, position.x - 9, position.y);
    line(position.x - 9, position.y, position.x - 12, position.y + 3);
    
    stroke(255, 0, 0);
    line(position.x - 2, position.y - 3, position.x - 2, position.y + 1);
    line(position.x + 2, position.y - 3, position.x + 2, position.y + 1);
  }
  
  // take damage when hit by bullet
  void takeDamage() {
    health--;
    isHit = true;
    hitTimer = 10;
  }

  // enemy chase player
  void move(PVector playerPosition) {
    PVector direction = PVector.sub(playerPosition, position);  // direction vector
    direction.setMag(speed);
    position.add(direction);
  }
}
