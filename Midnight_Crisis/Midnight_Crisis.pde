Player player;
ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;

float visionRadius = 100;
int score = 0;

int spawnInterval = 100;
int minSpawnInterval = 40;
int timeCounter = 0;

boolean isGameOver = false;

void setup() {
  size(400, 400);

  player = new Player(width / 2, height / 2, 3);  // Initialize player object
  bullets = new ArrayList<Bullet>();  // Initialize bullet list
  enemies = new ArrayList<Enemy>();  // Initialize enemy list
  bullets = new ArrayList<Bullet>();
}

void draw() {
  if (isGameOver) {
    gameOver();
    return;
  }
  background(255);
  drawMask();  // Draw the black mask
  player.update();  // Update player position
  player.display();  // Draw the player

  // Update and draw all enemies
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy e = enemies.get(i);
    e.move(player.position);
    e.display();

    // Check enemy and player
    float distance = dist(e.position.x, e.position.y, player.position.x, player.position.y);
    if (distance < 13) {
      enemies.remove(i);
      player.reduceHealth();
    }
  }

  // Update and draw all bullets
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();

    if (b.isOutOfBounds()) {
      bullets.remove(i);  // Remove bullet if out of bounds
      continue;
    }

    // Check if bullet hits any enemy
    for (int j = enemies.size() - 1; j >= 0; j--) {
      Enemy e = enemies.get(j);
      float distance = dist(b.position.x, b.position.y, e.position.x, e.position.y);
      if (distance < 12) {
        e.takeDamage();
        bullets.remove(i);
        break;
      }
    }
  }

  // Spawn enemies based on spawnInterval
  if (frameCount % spawnInterval == 0) {
    spawnEnemy();
  }

  // Adjust spawnInterval dynamically
  timeCounter++;
  if (timeCounter % 600 == 0 && spawnInterval > minSpawnInterval) {
    spawnInterval -= 10;  // Decrease spawn interval every 600 frames
  }

  mouseCenter();  // Draw mouse center

  // Display score and player's health
  fill(255, 0, 0);
  textSize(20);
  text("Score: " + score, 10, 30);  // Display score
  text("Health: " + player.health, 10, 60);  // Display player's health
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
void mouseCenter() {
  stroke(255, 0, 0);
  strokeWeight(2);
  line(mouseX - 10, mouseY, mouseX + 10, mouseY);
  line(mouseX, mouseY - 10, mouseX, mouseY + 10);
}

void gameOver() {
   background(0);
   fill(255, 0, 0);
   textSize(40);
   textAlign(CENTER, CENTER);
   text("Game Over", width / 2, height / 2 - 60);
   textSize(30);
   text("Score: " + score, width / 2, height / 2 - 5);
   
   fill(255);
   rectMode(CENTER);
   rect(width / 2, height / 2 + 70, 120, 40);
   
   fill(0);
   textSize(25);
   text("Try Again", width / 2, height / 2 + 70);
   isGameOver = true;
   
   noLoop();
}

void resetGame() {
  player.health = 3;
  score = 0;
  enemies.clear();
  bullets.clear();
  spawnInterval = 100;
  timeCounter = 0;
  isGameOver = false;
  rectMode(CORNER);
  textAlign(CORNER, CORNER);
  
  loop();
}

void mousePressed() {
  Bullet newBullet = new Bullet(player.position.x, player.position.y, mouseX, mouseY);
  bullets.add(newBullet);
  if(isGameOver){
    if(mouseX > 140 && mouseX < 260 && mouseY > 250 && mouseY < 290){
      resetGame();
    }
  }
}

void keyPressed() {
  player.move(key);  // Call player's move method
}

void keyReleased() {
  player.speed.set(0, 0);  // Stop player's movement
}
