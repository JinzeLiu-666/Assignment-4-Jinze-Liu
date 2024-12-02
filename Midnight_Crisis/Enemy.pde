class Enemy {
  PVector position;  // Enemy position
  float speed = 2;   // Enemy speed

  Enemy(float x, float y) {
    position = new PVector(x, y);
  }

  void display() {
    noStroke(); 
    fill(0);
    ellipse(position.x, position.y, 12, 12);
    
    stroke(0);
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

  // Enemy chase player
  void move(PVector playerPosition) {
    PVector direction = PVector.sub(playerPosition, position);  // Calculate direction vector
    direction.setMag(speed);
    position.add(direction);
  }
}
