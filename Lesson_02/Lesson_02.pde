void setup() {
  size(640, 480);   // Set Size of Screen
  rectMode(CENTER); // Makes Rectangles centered
}

void draw() {
  background(0);
  for (int x=0; x < width; x++) {
    float noiseVal = noise((mouseX+x)*noiseScale, mouseY*noiseScale);
    stroke(noiseVal*255);
    line(x, mouseY+noiseVal*80, x, height);
  }  
  
  fill(random(255),random(255),random(255));      // Change shape FILL colour to WHITE
  rect(310, 240, 40, 20); // Draw Rectangle at 320x240 make it 40 wide and 20 high
  
  ellipse(200,200,40,40);
  
  fill(255);
  rect(mouseX, mouseY, 20, 40); // Draw Rectangle at Mouse Position that is 20 wide and 40 high
}