class Flower {
  int num = 100;
  int die;

  float ox = random(width);
  float oy = random(height);
  float x;
  float y;
  float a;
  float r1 = 0;
  float t1 = 0.2;
  float r2 = 0;
  float t2 = 0.5;
  float h2 = 0.8;

  float r1_goal = r1 + t1;
  float r2_goal = r2 + t2;

  float curve_r = 0;
  float curve_r_delta = random(0.5, 1);

  float hue = random(360);
  float alp = 255;
  boolean fill_flg;

  float theta = random(TWO_PI);
  int theta_sign;

  Flower() {
    if (random(1) >= 0.5) {
      theta_sign = 1;
    } else {
      theta_sign = -1;
    }

    if (random(1) >= 0.5) {
      fill_flg = true;
    } else {
      fill_flg = false;
    }

    die=(int)random(10, 20);
  }

  void anime() {
    curve_r += curve_r_delta;
    alp -= 4;
    theta += theta_sign * 0.01;

    if (curve_r > die) {
      curve_r = 0;
      alp = 255;
      ox = random(width);
      oy = random(height);
      hue = random(100)+155;
    }
  }

  void display() {
    pushMatrix();
    translate(ox, oy);
    rotate(theta);

    if (fill_flg == true) {
      noStroke();
      fill(hue, 50, 100, alp);
    } else {
      noFill();
      stroke(hue, 50, 100, alp);
    }

    beginShape();

    for (int i = 0; i < num; i++) {
      a = sin(r2) * h2 + 1;

      x = curve_r * a * sin(r1);
      y = curve_r * a * cos(r1);

      r1 += t1;
      r2 += t2;

      curveVertex(x, y);
    }
    endShape();
    r1 = r1_goal;
    r2 = r2_goal;

    popMatrix();

    fill(255,200);
    ellipse(ox, oy,curve_r/1.5, curve_r/1.5);
  }
}