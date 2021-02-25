class BigHeart {
  float radius;
  float angle;
  float x, y, r;
  float alpha;

  BigHeart(boolean fill) {

    if (fill) {
      radius=10;
      angle=0;

      update();
      calc(angle);

      if (random(1) > 0.3) {
        r = random(13);
      } else {
        r = random(7);
      }

      alpha=random(200);
    } else {
      radius=4;
      angle=0;
      r=random(2, 4);
      update2();
      calc(angle);
      alpha=200;
    }
  }
  void shrink() {
    if (radius>0.5) radius -=0.5;
    else
    radius=0.1;
    calc(angle);
  }

  void explode() {
    radius += 1;
    radius=random(radius*0.7, radius*1.3);
    calc(angle);
    if (alpha>0) alpha-=5;
  }
  void explode2() {
    radius += 0.2;
    calc(angle);
    if (alpha>0) alpha-=5;
  }
  void heartDraw2() {
    noStroke();
    fill(200, 50, 50, alpha/3);
    ellipse(x, y, r, r);
  }
  void heartDraw() {
    noStroke();
    fill(200, 50, 50, alpha);
    ellipse(x, y, r, r);
  }

  void calc(float rot) {
    x = radius *(16 * sin(rot) * sin(rot) * sin(rot));
    y = -1 * radius * (13 * cos(rot) - 5 * cos(2*rot) - 2 * cos(3 * rot) - cos(4 * rot) );
  }

  void update() {
    radius = 10 - pow(random(1), 1) * 10;
    angle = random(TWO_PI);
  }
  void update2() {
    radius = 2 - pow(random(1), 2) * 2;
    angle = random(TWO_PI);
  }
}
