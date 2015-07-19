class Enemy extends Living {
  Player target;
  float angle;
  float speed;
  int scoreAdded;
  float rotationValue, positionOffset;
  int leftBound, rightBound;

  Enemy(float x, float y, int w_, int h_, int health_, float speed_, int scoreAdded_, int leftBound_, int rightBound_) {
    super(x, y, w_, h_, health_);
    speed=speed_;
    scoreAdded=scoreAdded_;
    angle=0;
    rotationValue=PI/(4*w);
    positionOffset=sin(PI/4)*w-w/2;
    leftBound=leftBound_;
    rightBound=rightBound_;
    enemies.add(this);
  }
  void update() {
    vel.x=speed;
    super.update();
    angle+=vel.x*rotationValue;
    checkBound();
    hitPlayer();
  }

  void die() {
    score+=scoreAdded;
    enemies.remove(this);
  }

  void checkBound() {
    if ((vel.x<0 && pos.x<leftBound)||(vel.x>0 && pos.x>rightBound)) speed*=-1;
  }

  void hitPlayer() {
    if (collision(player)) {
      if (pos.y-player.pos.y>h/2) {
        decreaseHealth(1);
        player.vel.y*=-1;
      } else {
        player.decreaseHealth(1);
        player.vel.mult(-1);
      }
    }
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    float val=map(abs(sin(2*angle)), 0, 1, 0, positionOffset);
    translate(0, -val);
    rotate(angle);
    fill(128);
    rect(-w/2, -h/2, w, h);
    popMatrix();
  }
}

