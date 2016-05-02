PImage spectrumImg;

void setup() {
  size(540, 540);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);


  spectrumImg = loadImage("spectrum.jpg");
}

int tapStep = 0;
float timer = 0;

void drawRainbow(float x, float y, float w, float h, float start, float stop, float thickness, int steps) {
  float step = thickness / steps ;

  noFill();
  strokeWeight(step*0.7);

  colorMode(HSB, 255);

  for (int c=0; c < steps; c += 1) {
    stroke(240 - (c* 255 / steps), 255, 255);
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
    stroke((c* 255 / steps), 255, 255);
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
}


void draw() {
  background(255);


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
    drawIntro();
    drawSpectrum(timer);
    break;

  case 2:
    drawColourBand(    lerp(200, width*0.1, timer), 0, 
      lerp(200, width*0.1, timer), height, 
      int(lerp(80, width*0.8, timer)), int(lerp(32, 100, timer)));
    drawSpectrum(1.0 - timer);
    break;

  case 3:
  default:
    drawColourBand(width*0.1, 0, width*0.1, height, int(width*0.8), 100);
  }
}