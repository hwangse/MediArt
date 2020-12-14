/*
  Project #7 by Sehyun Hwang
 
 * name : Blooming your smile
 * description : Before the start, you have to execute face OSC. 
                 You can download the program at  https://github.com/kylemcdonald/ofxFaceTracker/releases
                 When you run the program, the text "Bloom flowers with your smile" appears.
                 And if you smile, the flowers start to bloom. 
                 The number of flower depends on how big your smile is.
 */


import oscP5.*;
OscP5 oscP5;

int found;
float smileThreshold = 14.5;
float mouthWidth,mouthMax=16;

PFont font;
Flower[] flowers = new Flower[30];
int numFlower;

void setup() {
  size(500, 500);
  frameRate(30);
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  
  textSize(15);
  textAlign(CENTER);

  for (int i = 0; i < flowers.length; i++) {
    flowers[i] = new Flower();
  }

}

void draw() {
  noStroke();
  fill(255, 20);
  rect(0, 0, 500, 500);

  if (found > 0) {
    noStroke();

    if ( mouthWidth > smileThreshold) {
      if(mouthWidth>mouthMax) mouthWidth=mouthMax;
      numFlower=(int)map(mouthWidth,smileThreshold,mouthMax,0,flowers.length);
      for (int i = 0; i < numFlower; i++) {
        flowers[i].display();
        flowers[i].anime();
      }
    } else {
      fill(100,100,100);
      textSize(20);
      text("Bloom flowers with your", width/2, height/2-30); 
      textSize(25);
      text("Smile", width/2, height/2+10); 
    }
    //  previousMouthWidth = mouthWidth;
  }
}

public void found(int i) {
  found = i;
}

public void mouthWidthReceived(float w) {
  mouthWidth = w;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if (m.isPlugged() == false) {
  }
}