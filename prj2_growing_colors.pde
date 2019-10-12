/*
  Project #2 by Sehyun Hwang
 
 * name : Growing colors
 * description : All dots start from the bottom center of screen.
                 All starts grow with the different color.
                 After they all grow, another colors start to grow with different colors and directions.
 */
 
Dot []dots;
int number=80;
float size = 10;
float offSet;
int rs = 0;

void setup() {
  size(1100, 700); 
  background(50, 50, 50); // dark gray 
  noStroke();
  offSet = radians(3);    // variable for next dots location

  /* Initialization of the dots */
  dots=new Dot[number];
  for (int i=0; i<number; i++) {
    float speed=random(0, 1);
    dots[i]=new Dot(random(255), speed);
  }
}

void draw() {          
  translate(width/2, height);      // starts from the bottom center
  fill(50, 50, 50,10);
  rect(-width/2,-height,1100,700); // this is for background footprints

  /* drawing dots */
  for (int i=0; i<number; i++) {
    dots[i].setRandomSeed();
    dots[i].drawingDot(0, 0, size, radians(random(360)), 1);
    dots[i].changeCount();
  }
}

class Dot {
  int rs;
  float count;
  float speed;
  color dotColor;

  Dot(float _rs, float _speed) {
    rs=(int)_rs;
    count=0; 
    speed=_speed*0.1;

    float r=random(255);
    float g=random(255);
    float b=random(255);
    dotColor=color(r, g, b);
  }

  void drawingDot(float x, float y, float size, float angle, float sign) {
    if (size > 10-count) { 
      float p = random(0, 1.0);  

      fill(dotColor);

      ellipse(x, y, size, size);
      float nx = x + size * cos(angle);
      float ny = y + size * sin(angle);

      if (p >= 0.1) {  
        drawingDot(nx, ny, size * 0.99, angle + sign*offSet, sign);
      } else { 
        drawingDot(nx, ny, size * 0.99, angle - sign*offSet, -sign);
      }
    }
  }

  void changeCount() {
    count += 0.03; // the count variable is for progressive drawing
    if (count>5) {
      rs=(int)random(50);
      float r=random(255);
      float g=random(255);
      float b=random(255);
      dotColor=color(r, g, b);
      count=0;
    }
  }

  void setRandomSeed() {
    randomSeed(rs);
  }
}
