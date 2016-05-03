void setup() {
  size(640, 480);   // Set Size of Screen
  rectMode(CENTER); // Makes Rectangles centered
}

void draw() {
  background(0x76,0x2A,0x2A); // Make Background Black  
  
  fill(255,255,255);      // Change shape FILL colour to WHITE
  rect(310, 240, 40, 20); // Draw Rectangle at 320x240 make it 40 wide and 20 high
  
  fill(255,0,0);                // Change shape FILL colour to RED
  rect(mouseX, mouseY, 20, 40); // Draw Rectangle at Mouse Position that is 20 wide and 40 high
}