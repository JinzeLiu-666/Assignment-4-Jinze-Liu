Player player;
ArrayList<Enemy> enemies;
float visionRadius = 100;

void setup() {
  size(400, 400);
  player = new Player(width / 2, height / 2, 3);  // Initialize player object
  enemies = new ArrayList<Enemy>();  // Initialize enemy list
}

void draw() {
  background(255);

  drawMask();  // Draw the black mask

  player.update();   // Update player position
  player.display();  // Draw the player
  
for (int i = 0; i < enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.move(player.position);
    e.display();
    
    // Remove enemy
    if (e.health <= 0) {
      enemies.remove(i);
    }
}
  // Spawn enemies periodically
  if (frameCount % 120 == 0) {
    spawnEnemy();
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

// Spawn enemies randomly at screen edges
void spawnEnemy() {
  float x = 0, y = 0;
  // Randomly choose to spawn the enemy on a screen edge
  int edge = int(random(4));
  if (edge == 0) {
    x = 0;
    y = random(height);
  } else if (edge == 1) {
    x = width;
    y = random(height);
  } else if (edge == 2) {
    x = random(width);
    y = 0;
  } else if (edge == 3) {
    x = random(width);
    y = height;
  }
  // Add new enemy to the list
  enemies.add(new Enemy(x, y));
}

void mousePressed() {
  for (int i = enemies.size() - 1; i >= 0; i--) {
    if (enemies.get(i).takeDamage(mouseX, mouseY)) {
      enemies.remove(i);
    }
  }
}

void keyPressed() {
  player.move(key);  // Call player's move method
}

void keyReleased() {
  player.speed.set(0, 0);  // Stop player's movement
}
