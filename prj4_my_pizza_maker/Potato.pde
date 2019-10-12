class Potato {
  float size;
  float x, y;
  Potato(float _size, float _x, float _y) {
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
    fill(0,30);
    arc(x, y-1, size, size/3, 0, PI);
    fill(179, 119, 0);
    arc(x, y, size, size/2, 0, PI);
    fill(255, 232, 186);
    arc(x, y, size, size/3, 0, PI);
  }
}
