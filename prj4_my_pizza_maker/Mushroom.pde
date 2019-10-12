class Mushroom {
  color color1=color(255, 234, 199);
  color color2=color(0, 150);
  color shadow=color(0, 30);
  float size;
  float x, y;

  Mushroom(float _size, float _x, float _y) {
    size=_size;
    x=_x;
    y=_y;
  }
  void update(float _size, float _x, float _y) {
    size=_size;
    x=_x;
    y=_y;
  }

  void draw() {
    // drawing shadow
    fill(shadow);
    ellipse(x+3, y-size*0.6+3, size*2.2, size*1.6);
    rect(x+3, y+3, size, size*1.2, 10);
    // drawing mushroom
    fill(color1);
    ellipse(x, y-size*0.6, size*2.2, size*1.6);
    fill(color2);
    ellipse(x-size/2, y-size/3.5, size/2.5, size/2.5);
    ellipse(x+size/2, y-size/3.5, size/2.5, size/2.5);

    fill(color1);
    rect(x, y, size, size*1.2, 10);
  }
}
