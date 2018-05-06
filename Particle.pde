//this is the particle object belonging to the smoke generator

class Particle {
  float x, y, r, life, maxLife, op;
  PVector loc, vel, acc;
  boolean e;
  color c;


  Particle(float _x, float _y) {
    x = _x;
    y = _y;
    r = random(5, 10);
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    life = 0;
    maxLife = random(25, 100);
    if (random(100) < 15) {      
      c = color(255, 0, 100);
    } else {
      c = color(255);
    }
    op = 255;
    if (random(10) < 2) {
      e = true;
    } else {
      e = false;
    }
  }


  void show() {
    if (!e) {
      if (life < maxLife / 3) {
        fill(c, op);
        noStroke();
      } else {
        fill(0);
        stroke(255, op);
      }
    } else {
      fill(c, op);
      noStroke();
    }
    ellipse(loc.x, loc.y, r, r);
  }


  void update() {
    vel.add(acc);
    loc.add(vel);
    vel.limit(1);
    acc.mult(0);
    r += 0.5;
    life += 1;
    if (op > 0) {
      op -= .75;
    }
  }


  void applyForce(PVector f) {
    acc.add(f);
  }
}