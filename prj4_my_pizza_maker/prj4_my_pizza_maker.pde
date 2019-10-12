/*
  Project #4 by Sehyun Hwang
 
 * name : My Pizza Maker (Customizing Pizza Game)
 * description : MPM(my pizza maker) is a mini game to make your own customizing pizza.
                 You can customize your own pizza by controlling 6 sliders below the screen.
                 
                 These are the ingredients that you can choose.
                 1. Pizza size 2. Pepperoni 3. Mushroom 4. Potato 5. Olives 6. Paprika
                 
                 If you complete making pizza, you can click "BAKE" button on the right side of screen.
 */

import controlP5.*;
ControlP5 cp5;
Slider sl, sl2, sl3, sl4, sl5, sl6;

// slider variables 
int sliderValue = 300;
int sliderValue2 = 0;
int sliderValue3 = 0;
int sliderValue4 = 0;
int sliderValue5 = 0;
int sliderValue6 = 0;
int sliderWidth=240;
int sliderHeight=16;

// variables for ingredient numbers
int pNum=5;
int mNum=15;
int oNum=20;
int paNum=40;
int poNum=8;

// variables for movement (rotation, pop up)
int rg=140;
boolean rot=false;
float angle=0;
float op=0;
float op2=0;

// Ingredient classes
Mushroom []mushroom;
Olive []olive;
Paprika []paprika;
Potato []potato;

void setup() {
  size(900, 900); 
  ellipseMode(CENTER);
  rectMode(CENTER);
  background(255, 247, 227);
  noStroke();

  // 1. size of pizza
  cp5 = new ControlP5(this);
  sl = cp5.addSlider("sliderValue");
  sl.setPosition(width/2-sliderWidth/2, height/1.3);
  sl.setSize(sliderWidth, sliderHeight);
  sl.setRange(350, 550);
  sl.setColorCaptionLabel(color(0));
  sl.setCaptionLabel("Pizza Size");

  // 2. # of pepperoni
  sl2 = cp5.addSlider("sliderValue2");
  sl2.setPosition(width/2-sliderWidth/2, height/1.3+sliderHeight*2);
  sl2.setSize(sliderWidth, sliderHeight);
  sl2.setRange(0, 8);
  sl2.setColorCaptionLabel(color(0));
  sl2.setCaptionLabel("Number of Pepperoni");

  // 3. # of mushrooms
  sl3 = cp5.addSlider("sliderValue3");
  sl3.setPosition(width/2-sliderWidth/2, height/1.3+sliderHeight*4);
  sl3.setSize(sliderWidth, sliderHeight);
  sl3.setRange(0, 10);
  sl3.setColorCaptionLabel(color(0));
  sl3.setCaptionLabel("Number of Mushroom");

  // 6. # of Potato
  sl6 = cp5.addSlider("sliderValue6");
  sl6.setPosition(width/2-sliderWidth/2, height/1.3+sliderHeight*6);
  sl6.setSize(sliderWidth, sliderHeight);
  sl6.setRange(0, 8);
  sl6.setColorCaptionLabel(color(0));
  sl6.setCaptionLabel("Number of Potato");


  // 4. # of olives
  sl4 = cp5.addSlider("sliderValue4");
  sl4.setPosition(width/2-sliderWidth/2, height/1.3+sliderHeight*8);
  sl4.setSize(sliderWidth, sliderHeight);
  sl4.setRange(0, 20);
  sl4.setColorCaptionLabel(color(0));
  sl4.setCaptionLabel("Number of Olive");

  // 5. # of Paprika
  sl5 = cp5.addSlider("sliderValue5");
  sl5.setPosition(width/2-sliderWidth/2, height/1.3+sliderHeight*10);
  sl5.setSize(sliderWidth, sliderHeight);
  sl5.setRange(0, 40);
  sl5.setColorCaptionLabel(color(0));
  sl5.setCaptionLabel("Number of Paprika");

  // set button GUI
  cp5.addButton("RESET")
    .setPosition(750, 730)
    .setSize(100, 30)
    .setId(1);
  cp5.addButton("BAKE")
    .setPosition(750, 790)
    .setSize(100, 30)
    .setId(1);

  // Initialize pizza ingredients
  mushroom=new Mushroom[mNum];
  for (int i=0; i<mNum; i++) {
    mushroom[i]=new Mushroom(sliderValue/10, 0, 0);
  }

  olive=new Olive[oNum];
  for (int i=0; i<oNum; i++) {
    olive[i]=new Olive(sliderValue/12, random(-200, 200), random(-rg, rg));
  }

  paprika=new Paprika[paNum];
  for (int i =0; i<paNum; i++) {
    paprika[i]=new Paprika(sliderValue/10, random(-200, 200), random(-rg*0.8, rg*0.8), (int)(random(0, 3)+1));
  }

  potato=new Potato[poNum];
  for (int i=0; i<poNum; i++) {
    potato[i]=new Potato(sliderValue/10, 0, 0);
  }
}

void draw() {
  background(255, 247, 227);
  pushMatrix();

  translate(width/2, height/2.5);
  rotate(radians(22.5));

  if (rot) {
    rotate(radians(angle)); 
    angle+=1;
  }

  // pizza dough
  fill(0, 100);
  ellipse(4, 4, sliderValue, sliderValue);
  fill(232, 143, 0);
  ellipse(0, 0, sliderValue, sliderValue);
  fill(0, 40);
  ellipse(-4, -4, sliderValue*0.9, sliderValue*0.9);
  fill(255, 207, 102);
  ellipse(0, 0, sliderValue*0.9, sliderValue*0.9);

  // Olive
  oNum=(int)sliderValue4;
  for (int i=0; i<oNum; i++) {
    olive[i].update(sliderValue);
    olive[i].draw();
  }

  // pepperoni
  pNum=(int)sliderValue2;
  for (int i=0; i<pNum; i++) {
    fill(140, 32, 0);
    ellipse((sliderValue/2.8)*cos(radians((360/pNum)*i))+3, (sliderValue/2.8)*sin(radians((360/pNum)*i))+3, sliderValue/8, sliderValue/8);
    fill(186, 43, 0);
    ellipse((sliderValue/2.8)*cos(radians((360/pNum)*i)), (sliderValue/2.8)*sin(radians((360/pNum)*i)), sliderValue/8, sliderValue/8);
  }

  // Mushroom
  mNum=(int)sliderValue3;
  for (int i=0; i<mNum; i++) {
    pushMatrix();
    translate((sliderValue/3.5)*cos(radians((360/mNum)*i)), (sliderValue/3.5)*sin(radians((360/mNum)*i)));
    rotate(radians(45*i));
    mushroom[i].update(sliderValue/18, 0, 0);
    mushroom[i].draw();
    popMatrix();
  }

  // Paprika
  noFill();
  strokeCap(SQUARE);
  paNum=(int)sliderValue5;
  for (int i=0; i<paNum; i++) {
    pushMatrix();
    rotate(20*i);
    paprika[i].update(sliderValue);
    paprika[i].draw();
    popMatrix();
  }
  noStroke();

  //Potato
  poNum=(int)sliderValue6;
  for (int i=0; i<poNum; i++) {
    pushMatrix();
    translate((sliderValue/3.5)*cos(radians((360/poNum)*i)), (sliderValue/3.5)*sin(radians((360/poNum)*i)));
    rotate(radians(i*45));
    potato[i].update(sliderValue/4, 0, 0);
    potato[i].draw();

    popMatrix();
  }

  // 8 pieces pizza line
  /*
  float currR=sliderValue/2;
  rotate(radians(-22.5));
  strokeCap(ROUND);
  stroke(204, 126, 0, op2);
  strokeWeight(4);

  for (int i=0; i<4; i++) {
    line(-currR*cos(radians(45*i)), -currR*sin(radians(45*i)), currR*cos(radians(45*i)), currR*sin(radians(45*i)));
  }

  noStroke();
  */
  
  popMatrix();

  // Program title
  textSize(40);
  fill(0);
  text("My", 100, 740);
  text("Pizza", 100, 790);
  text("Maker", 100, 840);

  // "YUM!" text -> appear on screen when clicking 'BAKE' button
  fill(0, op);
  text("YUM!", 400, 60);
}

// Belows are button click methods
void RESET() {
  sliderValue = 350;
  sliderValue2 = 0;
  sliderValue3 = 0;
  sliderValue4 = 0;
  sliderValue5 = 0;
  sliderValue6 = 0;
  rot=false;
  angle=0;
  op=0;
  //op2=0;
}

void BAKE() {
  rot=true;
  op=255;
  //op2=255;
}
