// Assignment Title: Midnight Crisis
// Programmer: Jinze Liu
// Date: December 3, 2024
// Programming Language: Java
/* Purpose: The purpose of this program is for the user to control the character's movement
            using the WASD keys on the keyboard and to shoot bullets by moving and clicking
            the mouse, thereby achieving the gameplay objective.*/

// ------------------------ Global Variables ------------------------ //
Player player;
ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;

// vision radius
float visionRadius = 100;
int score = 0;

// Enemy spawn settings
int spawnInterval = 100;   // stare spawning time 
int minSpawnInterval = 40;  // Minimum spawning time
int timeCounter = 0;

boolean isGameOver = false;
int healthColor1 = 255;
int healthColor2 = 255;
int healthColor3 = 255;

// ----------------------------- Setup ----------------------------- //
void setup() {
  size(400, 400);
  
  // Create the player
  player = new Player(width / 2, height / 2);
  
  // Initialize lists bullets and enemies
  bullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
}

// ----------------------------- Draw ----------------------------- //
void draw() {
  // If the game is over, show the game over screen
  if (isGameOver) {
    gameOver();
    return;
  }
  background(255);
  drawMask();  // player's vision
  player.update();  //update player position
  player.display();

  // all enemies
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy e = enemies.get(i);
    e.move(player.position);
    e.display();

    // enemy touches player check
    float distance = dist(e.position.x, e.position.y, player.position.x, player.position.y);
    if (distance < 13) {
      enemies.remove(i);
      player.reduceHealth();
    }
  }

  // all bullets
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();
    
    // remove bullet if out
    if (b.isOutOfBounds()) {
      bullets.remove(i);
      continue;
    }

    // check bullet hits enemy
    for (int j = enemies.size() - 1; j >= 0; j--) {
      Enemy e = enemies.get(j);
      float distance = dist(b.position.x, b.position.y, e.position.x, e.position.y);
      if (distance < 12) {
        e.takeDamage();
        bullets.remove(i);
        break;
      }
    }
    // remove enemy if health is 0
    for (int j = enemies.size() - 1; j >= 0; j--) {
      Enemy e = enemies.get(j);
      if (e.health <= 0) {
        enemies.remove(j);  // 移除敌人
        score += 10;  // 加分
      }
    }
  }
  // spawn enemies time
  if (frameCount % spawnInterval == 0) {
    spawnEnemy();
  }

  // spawn enemies faster by time
  timeCounter++;
  if (timeCounter % 300 == 0 && spawnInterval > minSpawnInterval) {
    spawnInterval -= 10;
  }
  
  // mouse center
  mouseCenter(); 
  
  if(player.health <= 2){
    healthColor3 = 0;
  }
  if(player.health <= 1){
    healthColor2 = 0;
  }
  if(player.health <= 0){
    healthColor1 = 0;
  }
  
  // score and health
  fill(255, 0, 0);
  textSize(20);
  text("Score: " + score + "                                                        R restart", 10, 30);
  fill(255, 0, 0, healthColor1);
  rect(15, 50, 8, 8);
  fill(255, 0, 0, healthColor2);
  rect(35, 50, 8, 8);
  fill(255, 0, 0, healthColor3);
  rect(55, 50, 8, 8);
}

// ----------------------------- Draw Vision ----------------------------- //
void drawMask() {
  fill(0);
  noStroke();
  rect(0, 0, width, height);

  // gradient circle
  for (float r = visionRadius; r > 0; r -= 2) {
    float alpha = map(r, 0, visionRadius, 255, 0);
    fill(255, 255, 255, alpha);
    ellipse(player.position.x, player.position.y, r * 2, r * 2);
  }
}

// ----------------------------- Spawn Enemies ----------------------------- //
void spawnEnemy() {
  float x = 0;
  float y = 0;
  
  // Pick a random edge
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
  // add new enemy
  enemies.add(new Enemy(x, y));
}

// ----------------------------- Mouse Center ----------------------------- //
void mouseCenter() {
  stroke(255, 0, 0);
  strokeWeight(2);
  line(mouseX - 10, mouseY, mouseX + 10, mouseY);
  line(mouseX, mouseY - 10, mouseX, mouseY + 10);
}

// ------------------------------ Game Over ------------------------------ //
void gameOver() {
  background(0);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("Score: " + score, width / 2, height / 2 - 30);

  fill(255);
  rectMode(CENTER);
  rect(width / 2, height / 2 + 70, 120, 40);
  
  isGameOver = true;
  noLoop();
}

// ----------------------------- Reset Game ----------------------------- //
void resetGame() {
  isGameOver = false;
  player.health = 3;
  score = 0;
  enemies.clear();
  bullets.clear();
  spawnInterval = 100;
  timeCounter = 0;
  player.position = new PVector(width / 2, height / 2);
  rectMode(CORNER);
  textAlign(CORNER, CORNER);
  healthColor1 = 255;
  healthColor2 = 255;
  healthColor3 = 255;
  loop();
  
}

// ----------------------------- Mouse Pressed ----------------------------- //
void mousePressed() {
  Bullet newBullet = new Bullet(player.position.x, player.position.y, mouseX, mouseY);
  bullets.add(newBullet);  // new bullet
  
  // button is clicked
  if (isGameOver) {
    if (mouseX > 140 && mouseX < 260 && mouseY > 250 && mouseY < 290) {
      resetGame();
    }
  }
}

// ------------------------------ Key Pressed ------------------------------ //
void keyPressed() {
  player.move(key);
  if (key == 'R' || key == 'r') {
    isGameOver = true;
  }
}

// ------------------------------ Key Released ------------------------------ //
void keyReleased() {
  player.speed.set(0, 0);
}
