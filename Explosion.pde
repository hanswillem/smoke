class Explosion {
  float x, y, r, rot;
  PVector ploc, loc, vel, acc;
  color c;
  int life, maxLife;


  Explosion(float _x, float _y, color _c) {
    x = _x;
    y = _y;
    c = _c;
    if (random(10) < 1) {
      c = color(0, 0, 255);
    }
    r = random(2, 15);
    life = 0;
    maxLife = int(random(50));
    ploc = new PVector(x, y);
    loc = new PVector(x + random(-25, 25), y + random(-25, 25));
    vel = loc.copy();
    vel.sub(ploc);
    vel.normalize();
    vel.mult(2);
    acc = new PVector(0, 0);
  }


  void show() {
    fill(c);
    noStroke();
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(rot);
    rect(0, 0, r, r);
    rot += 0.25;
    popMatrix();
  }


  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    life ++;
    if (r > 0) {
      r -= .5;
    }
  }


  void applyForce(PVector f) {
    acc.add(f);
  }
}