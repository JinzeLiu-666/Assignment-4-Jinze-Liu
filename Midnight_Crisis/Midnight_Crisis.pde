Player player;
float visionRadius = 100;

void setup() {
  size(400, 400);
  player = new Player(width / 2, height / 2, 3);  // Initialize player object
}

void draw() {
  background(255);

  drawMask();  // Draw the black mask

  player.update();   // Update player position
  player.display();  // Draw the player
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

void keyPressed() {
  player.move(key);  // Call player's move method
}

void keyReleased() {
  player.speed.set(0, 0);  // Stop player's movement
}