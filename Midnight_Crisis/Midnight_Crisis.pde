Player player;
ArrayList<Enemy> enemies;
float visionRadius = 100;
ArrayList<Bullet> bullets;

int score = 0;

void setup() {
  size(400, 400);
  
  player = new Player(width / 2, height / 2, 3);  // Initialize player object
  bullets = new ArrayList<Bullet>();  // Initialize bullet list
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
  
  // Show score
  fill(255, 0, 0);
  textSize(20);
  text("Score: " + score, 10, 30);
  
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
    
    // Check if bullet hits any enemy
    for (int j = enemies.size() - 1; j >= 0; j--) {
      Enemy e = enemies.get(j);
      float distance = dist(b.position.x, b.position.y, e.position.x, e.position.y);
      if (distance < 12) {  // Bullet hits enemy
        enemies.remove(j);
        bullets.remove(i);
        break;
      }
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
      score += 10;
    }
  }
  // Create a bullet
  Bullet newBullet = new Bullet(player.position.x, player.position.y, mouseX, mouseY);
  bullets.add(newBullet);
}

void mouseCenter(){
  stroke(255, 0, 0);
  strokeWeight(2);
  line(mouseX - 10, mouseY, mouseX + 10, mouseY);
  line(mouseX, mouseY - 10, mouseX, mouseY + 10);
}


void keyPressed() {
  player.move(key);  // Call player's move method
}

void keyReleased() {
  player.speed.set(0, 0);  // Stop player's movement
}
