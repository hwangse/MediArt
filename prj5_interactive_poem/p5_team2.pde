import processing.sound.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
int Audio_flag=0;

Minim minim;
AudioPlayer song_front;
AudioPlayer song_back;

Amplitude amp;
AudioIn in;
int vol=0;
boolean isFinished = false;
boolean isSound = false;

ArrayList<FlowerSystem> systems = new ArrayList<FlowerSystem>();
int fSystemNum = 1;

PFont myFont;
int textAlp = 255;

int opa = 255;
int opa2 = 0;

float cam1Z = 0;
int cam2Z = 0;
boolean cam2Flag = false;
float sleep = 0;

PImage img;        // The back part source image
PImage txtImg;
int cellsize = 2; // Dimensions of each cell in the grid
int cols, rows;   // Number of columns and rows in our system
int imgPixZDis = 0;

int textImagOpa=0;

float startT=11000;
float addT=3000;

void setup() {
  size(640, 560, P3D);
  minim = new Minim(this);

  //background music
  song_front=minim.loadFile("music/falling.mp3");
  song_front.setGain(10);
  song_back = minim.loadFile("music/yoyo.mp3");
  song_back.setGain(-10+Audio_flag);

  for (int i = 0; i < fSystemNum; i ++) {
    systems.add(new FlowerSystem(1));
  }
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);

  myFont = createFont("font/나눔손글씨 안쌍체.ttf", 32);
  textFont(myFont);
  textAlign(CENTER, CENTER);

  //back part image processing
  img = loadImage("f5.jpg"); // Load the image
  txtImg = loadImage("txt2.JPG");
  cols = img.width/cellsize;              // Calculate # of columns
  rows = img.height/cellsize;             // Calculate # of rows

  noStroke();
  rectMode(CENTER);
}

void draw() {
  background(255);
  if (!isSound) {
    song_front.play();
  }

  if (!cam2Flag) {
    // use the first camera until it reaches to the hidden wall
    camera(width/2, height/2, (height/2) / tan(PI/6) - cam1Z, width/2, height/2, -cam1Z, 0, 1, 0);
    if ( (height/2) / tan(PI/6) - cam1Z < 0) {
      cam2Flag = true;
    }
  } else {
    // use the second camera for the back part
    camera(width/2, height/2, -cam2Z, width/2, height/2, -820, 0, 1, 0);
    backDisplay();

    if ( cam2Z < 1350 ) { 
      imgPixZDis += 5;
      cam2Z += 8;
    } else {
      sleep++;
      if ( sleep > 2) {
        //draw final flowers and text at the back part
        pushMatrix();

        pushMatrix();
        translate(0, 0, -850);
        for (FlowerSystem fs : systems) {
          fs.run();
        }
        popMatrix();

        fill(0);
        translate((width - txtImg.width) / 2, height - 60, -850);
        tint(255, textImagOpa); 
        image(txtImg, 0, 0);
        textImagOpa+=4;
        popMatrix();
      }
    }
  }

  fill(0, opa);
  pushMatrix();
  translate(width/2, height /2, -1);
  rect(0, 0, 800, 800);                  //hidden wall
  popMatrix();

  for (FlowerSystem fs : systems) {
    fs.run();
    fs.addFlower();
  }

  /* After calling the name */
  if (isSound) {
    // to make background brighter to express how important to call a name 
    // check if the user finishes calling a name. If does, move the camera
    if (amp.analyze() * 100 < 0.5) {
      isFinished = true;
    }
  }
  if (isFinished) {
    cam1Z += 2;                  //move the camera
    song_front.pause();
    song_back.play();
    opa -= 3;
  }                             

  // show the part of the poem on the screen
  fill(255, textAlp);
  textSize(35);
  if (millis() < startT) fadeOut("내가 그의 이름을 불러주기 전에는");
  else if (millis() < startT+addT) fadeIn("그는 다만 하나의 몸짓에 지나지 않았다");
  else if ( millis() < startT+addT*2) fadeOut("그는 다만 하나의 몸짓에 지나지 않았다");
  else if ( millis() < startT+addT*3)fadeIn("그러나");
  else if ( millis() < startT+addT*4)fadeOut("그러나");
  else if ( millis() < startT+addT*5)fadeIn("내가 그의 이름을 불러 주었을 때");
  else if ( millis() < startT+addT*6)fadeOut("내가 그의 이름을 불러 주었을 때");
  else {
    if (!isSound) {
      if (opa2<120)
        opa2+=6;
    } else {
      if (opa2>0) opa2-=10;
    }

    fill(0, opa2);
    rect(width / 2, height / 2, 800, 800);
    fill(255, textAlp);
    pushMatrix();
    translate(0, -height/2.5, 0);
    if (!isSound)
      fadeIn("이름을 불러주세요.");
    else 
    fadeOut("이름을 불러주세요.");
    popMatrix();

    // check if the user call a name
    if (amp.analyze() * 100 > 20) {        
      isSound = true;
    }
  }
}

void fadeOut(String s) {
  if ( millis() > 10000) {
    if ( textAlp > 2) textAlp -= 5;
  }
  text(s, width/2, height - 70, 10);
}

void fadeIn(String s) {
  text(s, width/2, height - 70, 10);
  if (textAlp < 255) textAlp += 5;
}

void backDisplay() {
  // display the back part
  img.loadPixels();

  pushMatrix();
  translate((width-img.width)/2, 0);
  // Begin loop for columns
  for (int i = 0; i < cols; i++ ) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++ ) {
      int x = i*cellsize + cellsize/2; // x position
      int y = j*cellsize + cellsize/2; // y position
      int loc = x + y* img.width;           // Pixel array location
      color c = img.pixels[loc];       // Grab the color
      fill(c);
      float z = map(brightness(img.pixels[loc]), 0, 255, 1-imgPixZDis, -850 );
      pushMatrix();
      translate(x, y, z); 
      rect(0, 0, cellsize, cellsize);
      popMatrix();
    }
  }
  popMatrix();
}
