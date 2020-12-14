/*
  Project #6 by Sehyun Hwang
 
 * name : Heart Explosion
 * description : Fill your heart for the person whom you loves.
                 You can fill the heart by hitting any keyboards including space bar and direction keys.
                 If the percentage of heart become 100, then the firework of love will start.
 */

BigHeart []heart;
int cnt=0;
int max=15000;
int sec=0;
int blink=200;
String num="0";

boolean explode=false;
boolean addFlag=false;

ArrayList<Firework> fireworks;
PVector gravity = new PVector(0, 0.5);


void setup() {
  size(700, 700, P3D);
  background(0);
  smooth();
  noStroke();
  textSize(20);
  textAlign(CENTER);

  heart=new BigHeart[max];
  for (int i=0; i<max; i++)
    heart[i]=new BigHeart(true);

  fireworks = new ArrayList<Firework>();
}

void draw() {
  background(0);

  pushMatrix();
  translate(width/2, height/2);

  if (!explode) {
    if (!addFlag) {
      blink-=3;
      if (blink<100) addFlag=true;
    } else {
      blink+=3;
      if (blink>200) addFlag=false;
    }
    fill(200, blink);
    text("Fill your heart", 0, -height/3.5); 

    fill(200);
    if ((cnt/100)%5==0)
      num=str((int)cnt/100);
    text(" "+num+" %", 0, height/3);

    fill(200, 50, 50);
    text("♥", -40, height/3);

    for (int i=0; i<cnt; i++) {
      heart[i].heartDraw2();
    }
    for (int i=0; i<max; i++) {
      if (heart[i].y>170-(cnt/37))
        heart[i].heartDraw();
    }
    if (cnt-10>0)
      cnt-=10;
    if (cnt>max-5000) explode=true;
  } else {
    sec++;
    //println(sec);
    if (sec<62) {
      for (int i=0; i<max; i++) {
        if (sec<22)
          heart[i].shrink();
        else {
          heart[i].explode();
        }
        heart[i].heartDraw();
      }
    } else {
      if (random(1) < 0.2) 
        fireworks.add(new Firework());
      for (int i = fireworks.size()-1; i >= 0; i--) {
        Firework f = fireworks.get(i);
        f.run();
        if (f.done()) {
          fireworks.remove(i);
        }
      }
    }
  }
  popMatrix();
}

void keyPressed() { 
  if (!explode) {
    cnt+=150;
    if (cnt>max) cnt=max;
  }
}