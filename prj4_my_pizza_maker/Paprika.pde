class Paprika {
  float size;
  float x, y;
  float posX, posY;
  int rgb;

  Paprika(float _size, float _x, float _y, int _rgb) {
    size=_size;
    x=_x;
    y=_y;
    posX=_x;
    posY=_y;
    rgb=_rgb;
  }
  void update(float curr) {
    size=curr/6;
    posX=x*(curr/600);
    posY=y*(curr/600);
  }
  void draw() {
    stroke(0, 100);
    arc(1+posX, 1+posY, size, size, 0, HALF_PI*1.2);
    if (rgb==1) stroke(194, 39, 0);
    else if (rgb==2) stroke(0, 138, 37);
    else stroke(245, 102, 0);
    strokeWeight(size/12);
    arc(posX, posY, size, size, 0, HALF_PI*1.2);
  }
}
