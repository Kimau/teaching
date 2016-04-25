void setup() {
  size(640, 480);   // Set Size of Screen
  rectMode(CENTER); // Makes Rectangles centered
 
}

void draw() {
  background(50,50,50); // Make Background Grey  
  
  // Draw Face
  fill(200,200,200);
  rect(320, 240, 150, 250);
  
  // Draw Eyes
  fill(mouseX,mouseY,255);  
  rect(280, 200, 20, 40); 
  rect(360, 200, 20, 40);
  
  // Draw Mouth
  rect(320, 290, 80, 20);
  rect(280, 300, 20, 40);
  rect(360, 300, 20, 40);

}