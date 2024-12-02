Player player;  // Player object

void setup() {
  size(400, 400);  // Canvas size
  player = new Player(width / 2, height / 2, 3);  // Initialize player
}

void draw() {
  background(255);  // White background
  player.update();   // Update player's position
  player.display();  // Draw player
}

void keyPressed() {
  player.move(key);  // Handle player movement
}

void keyReleased() {
  player.speed.set(0, 0);  // Stop player when key is released
}
