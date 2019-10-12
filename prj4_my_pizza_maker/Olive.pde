class Olive {
  float size;
  float x, y;
  float posX,posY;

  Olive(float _size, float _x, float _y) {
    size=_size;
    x=_x;
    y=_y;
    posX=x;
    posY=y;
  }
  void update(float curr) {
    size=curr/14;
    posX=x*(curr/600);
    posY=y*(curr/600);
  }
  void draw() {
    fill(0);
    ellipse(posX, posY, size, size);
    fill(255, 207, 102);
    ellipse(posX, posY, size*0.3, size*0.3);
    noFill();
    strokeCap(ROUND);
    stroke(255,120);
    strokeWeight(size/10);
    arc(posX+3,posY+3,size*0.3,size*0.3,0,HALF_PI);
    noStroke();
  }
}
