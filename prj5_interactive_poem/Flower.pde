class Flower {
  int num = 50;

  float ox = random(10, width-10);
  float oy = random(10, 360-10);
  float x, y, a;
  float r1 = 0, r2=0;
  float t1 = 0.2, t2=1.0;
  float h2 = 0.8;

  float r1_goal = r1 + t1;
  float r2_goal = r2 + t2;

  float curve_r = 0;
  float curve_r_deltaBig = random(0.6, 1);
  float curve_r_deltaSmall = random(0.2, 0.5); //the size of flower
  
  float lifespan = 30;
  float hue = random(255);
  float alp1 = 255;
  float alp2 = 255;
  boolean fill_flg = false;

  float theta = random(TWO_PI);
  int theta_sign;
  
  PVector loc;
  PVector accel;
  PVector vel;
  
  boolean soundFlag=false;

  Flower() {
    if (random(1) >= 0.5) {
      theta_sign = 1; // turn right
    } else {
      theta_sign = -1; // turn left
    }
    
    loc = new PVector(ox, oy);
    vel = new PVector(0, 1.5);
    accel = new PVector(0, 0.05);
  }

  void anime() {
    if (isFinished) {
      curve_r += curve_r_deltaBig;      // after a name called, draw big flowers
      theta += theta_sign * 0.02;
    }
    else {
      curve_r = 10;               // before a name called, draw small flowers
      lifespan -=0.5;
      vel.add(accel);
      loc.add(vel);
    }
    
    alp2 -= 4;
    alp1 --;
  //  if (isSound ) theta += theta_sign * 0.06;       // after a name called, make flowers rotate lively
  }

  void display() {
    
  
    pushMatrix();
    translate(loc.x, loc.y);
    //translate(ox, oy);
    rotate(theta);
    noStroke();
    fill(hue, alp1);                                // before a name called, show only gray flowers
    
    if (isFinished) fill_flg = true;                  // after a name called, make flowers have vivid colors
    if (fill_flg) fill(hue, 50, 100, alp2);
   
    beginShape();

    for (int i = 0; i < num; i++) {
      a = sin(r2) * h2 + 1;

      x = curve_r * a * sin(r1);
      y = curve_r * a * cos(r1);

      r1 += t1;
      r2 += t2;

     // curveVertex(x, y);
     rect(x,y,2.5,2.5);
    }
    endShape();
    r1 = r1_goal;
    r2 = r2_goal;

    popMatrix();
  }

  boolean isDead(){
    if (loc.y + 100 >= height){
      return true;
    }
    else return false;
  }
  
  void stop(){
    if(alp1>160) soundFlag=true; //only vivid flower can have falling sound effect
    if(alp1>0) alp1-=2;
    vel = new PVector(0, 0);
    accel = new PVector(0, 0);
  }
}
