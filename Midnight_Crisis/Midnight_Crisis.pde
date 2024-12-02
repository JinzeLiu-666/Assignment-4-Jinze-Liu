Player player;
float visionRadius = 100;
ArrayList<Bullet> bullets;

void setup() {
  size(400, 400);
  player = new Player(width / 2, height / 2, 3);  // Initialize player object
  bullets = new ArrayList<Bullet>();  // Initialize bullet list
}

void draw() {
  background(255);

  drawMask();  // Draw the black mask

  player.update();   // Update player position
  player.display();  // Draw the player
  mouseCenter();  // Draw mouse center
  
  // draw bullets
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();
    
    // if bullet is out of bounds
    if (b.isOutOfBounds()) {
      bullets.remove(i);
      continue;
    }
  }
}

void drawMask() {
  fill(0);
  noStroke();
  rect(0, 0, width, height);

  // Draw gradient transparent circle in the black mask
  for (float r = visionRadius; r > 0; r -= 2) {
    float alpha = map(r, 0, visionRadius, 255, 0);
    fill(255, 255, 255, alpha);
    ellipse(player.position.x, player.position.y, r * 2, r * 2);
  }
}

void mouseCenter(){
  stroke(255, 0, 0);
  strokeWeight(2);
  line(mouseX - 10, mouseY, mouseX + 10, mouseY);
  line(mouseX, mouseY - 10, mouseX, mouseY + 10);
}

void mousePressed() {
  // Create a bullet
  Bullet newBullet = new Bullet(player.position.x, player.position.y, mouseX, mouseY);
  bullets.add(newBullet);
}

void keyPressed() {
  player.move(key);  // Call player's move method
}

void keyReleased() {
  player.speed.set(0, 0);  // Stop player's movement
}
