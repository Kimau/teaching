
PImage colourSpaceImg;
PImage rgbImg;

void setup() {
  size(540, 540);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);


  colourSpaceImg = loadImage("colourspace.png");
  rgbImg = loadImage("rgb.png");
  rgbImg.loadPixels();
}

int tapStep = 0;
float timer = 0;

void drawRainbow(float x, float y, float w, float h, 
  float start, float stop, float thickness, int steps) {

  float step = thickness / steps ;

  noFill();
  strokeWeight(step*0.7);

  colorMode(HSB, 255);

  for (int c=0; c < steps; c += 1) {
    stroke(220 - (c* 220 / steps), 255, 255);
    arc(x, y, w-step*c, h-step*c, start, stop);
  }

  colorMode(RGB, 255);
}

void drawColourBand(float x, float y, float x2, float y2, float thickness, int steps) {
  float step = thickness / steps ;

  noFill();
  strokeWeight(step);
  PVector perp = new PVector(x-x2, y-y2);
  perp.rotate(PI);
  perp.normalize();

  colorMode(HSB, 255);
  for (int c=0; c < steps; c += 1) {
    stroke((c* 220 / steps), 255, 255);
    line(x+1.0*step*c, y+0*step*c, 
      x2+1.0*step*c, y2+0*step*c);
  }
  colorMode(RGB, 255);
}

void drawShadowText(String _t, float _x, float _y, float _dist) {
  drawShadowText(_t, _x, _y, _dist, 1.0);
}

void drawShadowText(String t, float x, float y, float dist, float alpha) {
  fill(0, 0, 0, alpha * 0.2);
  text(t, x + dist*(x - mouseX), y + 0.1*(y -mouseY));
  fill(0, 0, 0, alpha*255);
  text(t, x, y);
}

void drawIntro() {

  float[] x = {width/2, -width*1.5, -width*49.5};
  float[] y = {height*0.75, height/2, height/2};
  float[] w = {width*0.9, width*4, width*100};
  float[] h = {height*0.9, height*4, height*100};
  float[] s = {PI, PI*1.5, PI*1.5};
  float[] e = {PI*2, PI*2.5, PI*2.5}; 

  int c = tapStep;
  float l = timer;

  drawRainbow(
    lerp(x[c], x[c+1], l), 
    lerp(y[c], y[c+1], l), 
    lerp(w[c], w[c+1], l), 
    lerp(h[c], h[c+1], l), 
    lerp(s[c], s[c+1], l), 
    lerp(e[c], e[c+1], l), 
    150, 32);
}

void drawSpectrum(float alpha) {
  stroke(0, 0, 0, alpha);
  strokeWeight(5.0);
  line(0, height*0.5, width, height*0.5);

  drawShadowText("Radio", width*0.2, height*0.5-50, alpha);
  drawShadowText("XRay", width*0.8, height*0.5-50, alpha);

  strokeWeight(2.0);
  stroke(150);

  float px = width*(1.0-alpha);
  float py = height*0.5;
  for (float x=px; x<width; x+= 1) {
    float y = height*0.2*sin(pow((x+5)*0.04, 1.5));

    y = height*0.75 + y*alpha;

    line(px, py, x, y);
    px = x;
    py = y;
  }
}

void fullBox(float timer) {
  rectMode(CORNER);
  noStroke();
  fill(255, 255, 255, timer*255);
  rect(0, 0, width, height);
}

void drawHSB(float alpha) {
  // Draw In
  int bigAlpha = int((1.0 - alpha)*width*height);
  int sx = int(bigAlpha) % width;
  int sy = int(bigAlpha) / height;

  rectMode(CORNER);
  noStroke();

  colorMode(HSB, width, 255, height);
  int xStep = (width / 50);
  int yStep = (height / 50);
  for (int y=sy; y<height; y+=yStep) {
    for (int x=sx; x<width; x+=xStep) {
      fill(x, (sin((millis()+x*10+y*10)*0.002)+1.0) * 255, y);
      rect(x, y, xStep, yStep);
    }  
    sx = 0;
  }

  colorMode(RGB);
  fill(0);
  if (alpha > 0.9) { 
    strokeWeight(2.0);
    stroke(255);
    text("HSB", width*0.5, height*0.5);
  }
}

void drawRGB(float alpha) {
  // Draw In
  int bigAlpha = int((1.0 - alpha)*width*height);
  int sx = int(bigAlpha) % width;
  int sy = int(bigAlpha) / height;

  rectMode(CORNER);
  noStroke();

  colorMode(RGB, width, 255, height);
  int xStep = (width / 50);
  int yStep = (height / 50);
  for (int y=sy; y<height; y+=yStep) {
    for (int x=sx; x<width; x+=xStep) {
      fill(x, y, (sin((millis()+x*10+y*10)*0.002)+1.0) * 255);
      rect(x, y, xStep, yStep);
    }  
    sx = 0;
  }

  colorMode(RGB);
  fill(0);
  if (alpha > 0.9) {
    strokeWeight(2.0);
    stroke(255);
    text("RGB", width*0.5, height*0.5);
  }
}

void drawRGBVenn() {

  float chunky = constrain((sin(millis()*0.001) + 0.5), 0, 1)*200 + 20;

  float xStep = (width / chunky);
  float yStep = (height / chunky);
  float xStepSML = xStep / 3.0;
  noStroke();
  background(0);

  for (float y=0; y<height; y+=yStep) {
    for (float x=0; x<width; x+=xStep) {
      int ix = int(float(rgbImg.width) * x/width);
      int iy = int(float(rgbImg.height) * y/height);
      color b = rgbImg.pixels[ix+iy*rgbImg.width];

      fill(red(b), 0, 0);
      rect(x, y, xStepSML, yStep);
      fill(0, green(b), 0);
      rect(x+xStepSML, y, xStepSML, yStep);
      fill(0, 0, blue(b));
      rect(x+2*xStepSML, y, xStepSML, yStep);
    }
  }
}

boolean test = false;

void draw() {
  background(255);

  if (test) {
    return;
  }


  if (timer == 0) {
    if (mousePressed && (mouseButton == LEFT)) {
      timer = 0.01;
    }
  } else {
    timer += 0.01;
    if (timer >= 1.0) {
      timer = 0;
      tapStep += 1;
    }
  }

  switch(tapStep) {
  case 0:
    drawIntro();
    // Title
    textSize(64);
    drawShadowText("Colour", width*0.5, 50, 0.1, 1.0-(timer*2));

    // Rainbow
    textSize(32);
    drawShadowText("Rainbow", width*0.5, height-100, 0.1, 1.0-(timer*2));

    break;

  case 1:
    if (timer == 0) { 
      timer = 0.01;
    }
    drawSpectrum(timer);
    drawIntro();    
    break;

  case 2:
    drawSpectrum(1.0 - timer);
    drawColourBand(    lerp(200, width*0.1, timer), 0, 
      lerp(200, width*0.1, timer), height, 
      int(lerp(80, width*0.8, timer)), int(lerp(32, 100, timer)));
    break;

  case 3:
    drawColourBand(width*0.1, 0, width*0.1, height, int(width*0.8), 100);
    fullBox(timer);
    image(colourSpaceImg, -width*(1.0-timer), 0, width, height);
    break;

  case 4:
    image(colourSpaceImg, width*timer, 0, width, height);
    fullBox(timer);
    drawHSB(timer);
    break;

  case 5:
    drawHSB(1.0-timer);
    drawRGB(timer);
    break;

  case 6:
    drawRGB(1.0-timer);
    image(rgbImg, -width*(1.0-timer), 0, width, height);
    break;

  case 7:
    image(rgbImg, 0, 0, width, height);
    break;

  case 8:
    drawRGBVenn();
    break;

  default:
    tapStep = 0;
  }
}