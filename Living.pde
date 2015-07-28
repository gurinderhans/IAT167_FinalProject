class Living {
  PVector pos, vel, acc;
  int w, h, health;
  boolean alive;
  boolean onBase;

  Living(float x, float y, int w_, int h_, int health_) {
    pos=new PVector(x, y);
    vel=new PVector();
    acc=new PVector();
    w=w_;
    h=h_;
    health=health_;
    alive=true;
  }

  void update() {
    move(GRAVITY);
    vel.add(acc);
    pos.add(vel);
    acc.set(0, 0);
    checkBases();
//    checkRounds();
  }
  void move(PVector force) {
    acc.add(force);
  }
  boolean collision(Living other) {
    return abs(pos.x-other.pos.x)<w/2+other.w/2 && abs(pos.y-other.pos.y)<h/2+other.h/2;
  }
  boolean collision(Lifeless other) {
    return abs(pos.x-other.pos.x)<w/2+other.w/2 && abs(pos.y-other.pos.y)<h/2+other.h/2;
  }
  boolean collision(Circular other) {
    return dist(pos.x, pos.y, other.pos.x, other.pos.y)<w/2+other.diameter/2;
  }

  void decreaseHealth(int damage) {
    health-=damage;
    println(this+" just lost "+damage+" health");
    if (health<0) die();
  }

  void die() {
    println("this should be overriden");
  }

  void checkBases() {
    onBase=false;
    for (int i=0; i<bases.size (); i++) {
      Lifeless d=bases.get(i);
      if (collision(d)) {
        if (d.hit()) return;
        if (vel.y>0 && d.pos.y-pos.y>d.h/2) {
          pos.y=d.pos.y-d.h/2-h/2;
          vel.y=0;
          onBase=true;
        } else if (vel.y<0  && pos.y-d.pos.y>d.h/2) {
          pos.y=d.pos.y+d.h/2+h/2;
          vel.y*=-1;
        }
        if (vel.x<0 && pos.x-d.pos.x>d.w/2) {
          pos.x=d.pos.x+d.w/2+w/2;
          vel.x*=-0.1;
        } else if (vel.x>0 && d.pos.x-pos.x>d.w/2) {
          pos.x=d.pos.x-d.w/2-w/2;
          vel.x*=-0.1;
        }
      }
    }
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(0, 200, 0);
    stroke(0);
    rect(-w/2, -h/2, w, h);
    popMatrix();
  }
}

