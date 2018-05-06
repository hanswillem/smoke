//tiny smoke generator

ArrayList<Particle> p;
ArrayList<PVector> stroke;
ArrayList<Explosion> e;
PVector n;
float x, y, pbx, pby;
boolean playBack, recording, showHud, showExplosion;
int playBackIndex;
int mp;
PFont fnt; 


void setup() {
  size(1280, 720);
  //fullScreen();
  background(0);
  fill(255);
  noStroke();
  p = new ArrayList<Particle>();
  stroke = new ArrayList<PVector>();
  e = new ArrayList<Explosion>();
  x = 200;
  y = 500;
  mp = 5;
  cursor(CROSS);
  playBack = false;
  playBackIndex = 0;
  recording = false;
  showExplosion = true;
  showHud = true;
  fnt = loadFont("Monaco-12.vlw");
  rectMode(CENTER);
}


void draw() {
  background(0);

  //draw or replay
  if (!playBack) {
    if (mousePressed) {
      stroke.add(new PVector(mouseX, mouseY));
    }
  } else {  
    playBackStroke();
  }
  if (mousePressed) {
    for (int i = 0; i < mp; i++) {
      p.add(new Particle(mouseX, mouseY));
    }
  }

  // particles
  for (Particle i : p) {
    n = new PVector(random(-1, 1), random(-1, 1));
    i.show();
    i.update();
    i.applyForce(n);
  }

  // explosions
  if (showExplosion) {
    for (Explosion i : e) {
      n = new PVector(random(-0.5, 0.5), random(-0.5, 0.5));
      i.show();
      i.update();
      i.applyForce(n);
    }
  }

  killParticles();

  if (showHud) {
    hud();
  }

  if (recording) {
    saveFrame("render/smoke_frame_####.png");
  }
}


// kill particles and explosions
void killParticles() {
  //particles
  for (int i = p.size() - 1; i >= 0; i--) {
    if (p.get(i).life > p.get(i).maxLife) {   
      if (showExplosion) {
        for (int j = 0; j < 3; j++) {
          e.add(new Explosion(p.get(i).x, p.get(i).y, p.get(i).c));
        }
      }
      p.remove(i);
    }
  }
  //explosions
  for (int i = e.size() - 1; i >= 0; i--) {
    if (e.get(i).life > e.get(i).maxLife) {      
      e.remove(i);
    }
  }
}


// react to user input
void keyPressed() {
  // r
  if (keyCode == 82) {
    p.clear();
    e.clear();
    background(0);
    playBack = true;
    playBackIndex = 0;
    recording = true;
  }
  // c
  if (keyCode == 67) {
    p.clear();
    stroke.clear();
    e.clear();
    background(0);
  }
  // e
  if (keyCode == 69) {
    showExplosion = !showExplosion;
  }
  // h
  if (keyCode == 72) {
    showHud = !showHud;
  }
}


void mousePressed() {
  stroke.clear();
  recording = false;
}


// playback
void playBackStroke() {
  if (stroke.size() > 0) {
    pbx = stroke.get(playBackIndex).x;
    pby = stroke.get(playBackIndex).y;  
    for (int i = 0; i < mp; i ++) {
      p.add(new Particle(pbx, pby));
    }
  }
  if (playBackIndex < stroke.size() -1) {
    playBackIndex ++;
  } else {
    playBack = false;
  }
}


// draw the hud
void hud() {
  textFont(fnt);
  fill(255, 0, 100);
  text("draw with mouse", 25, 40);
  text("'r' to replay last stroke", 25, 70);
  text("'c' to clear", 25, 100);
  if (showExplosion) {
    text("'e' to hide explosion", 25, 130);
  } else {
    text("'e' to show explosion", 25, 130);
  }
  text("'h' to hide this hud", 25, 160);
}