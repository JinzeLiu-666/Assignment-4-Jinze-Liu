class Player {
  PVector position;
  PVector speed;
  int health = 3;
  
  Player(float x, float y) {
    position = new PVector(x, y);
    speed = new PVector(0, 0);
  }
  
  void update() {
    position.add(speed);
    position.x = constrain(position.x, 0, width);
    position.y = constrain(position.y, 0, height);
  }
  
  void display() {
    ellipseMode(CENTER);
    noStroke();
    fill(0);
    ellipse(position.x, position.y, 13, 13);
    rect(position.x - 6.5, position.y, 10.5, 10);
    rect(position.x - 6.5, position.y, 3, 12);
    rect(position.x + 3.5, position.y, 3, 12);
    stroke(255);
    line(position.x - 3, position.y - 2, position.x - 3, position.y);
    line(position.x + 2, position.y - 2, position.x + 2, position.y);
  }
  
  // player move
  void move(char direction) {
    float moveSpeed = 3;
    if (direction == 'w' || direction == 'W') {
      speed.set(0, -moveSpeed);
    } else if (direction == 's' || direction == 'S') {
      speed.set(0, moveSpeed);
    } else if (direction == 'a' || direction == 'A') {
      speed.set(-moveSpeed, 0);
    } else if (direction == 'd' || direction == 'D') {
      speed.set(moveSpeed, 0);
    }
  }
  void reduceHealth() {
    health--;
    if(health <= 0){
      print("Game Over");
      isGameOver = true;
    }
  }
}
