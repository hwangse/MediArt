class Firework {
  ArrayList<BigHeart> bighearts;
  PVector location;
  PVector velocity;
  PVector acceleration;

  float lifespan;
  int txtSize;
  int sec=0;
  boolean seed = false;
  boolean explode=false;

  Firework() {
    bighearts=new ArrayList<BigHeart>();
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, random(-25, -10), 0);
    location =  new PVector(random(-width/2, width/2), height/2, random(100, 300));
    seed = true;
    lifespan = 255.0;
    txtSize=(int)random(15, 35);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  boolean explode() {
    if ( seed&&velocity.y > 0) {
      lifespan = 0;
      return true;
    }
    return false;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    if (!seed) {
      lifespan -= 5;
      velocity.mult(0.9);
    }
    acceleration.mult(0);
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    noStroke();
    fill(200, 50, 50);
    textSize(txtSize);
    text("♥", 0, 0);
    popMatrix();
  }

  void run() {
    sec++;
    if (!explode) {
      applyForce(gravity);
      update();
      display();

      if (explode()) {
        for (int i=0; i<500; i++)
          bighearts.add(new BigHeart(false));
        explode=true;
      }
    } else {
      pushMatrix();
      translate(location.x, location.y, location.z);

      for (int i = bighearts.size()-1; i >= 0; i--) {
        BigHeart tmp=bighearts.get(i);
        tmp.explode2();
        tmp.heartDraw();
      }
      popMatrix();
    }
  }

  boolean done() {
    if (explode && sec>100)
    {
      return true;
    } else {
      return false;
    }
  }
}