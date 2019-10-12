/*
  Project #1 by Sehyun Hwang
  
  * name : Blinking dots
  * description : When you run the process, you can see many dots blinking at different speed.
                  If you click the mouse, then the color of dots are changing in order of "yellow -> red -> blue -> green".
                  You can change the size of dots if you want, by using 'size' variable which located at the top of the code.
 */
 
int rs = 100;    // random seed
int size=40;     // size of ellipse
int num_x,num_y; // number of ellipse in x-axis, y-axis
Dot[] dots;      // array of dots

void setup() {
  //fullScreen();
  size(1000, 1000);
  background(255);
  ellipseMode(CORNER);
  stroke(255);
  
  num_x=width/size;
  num_y=height/size;
  
  // initialization of dots 
  dots=new Dot[num_x*num_y];
  int idx=0; 
   for (int i=0; i<num_y; i+=1) {
    for (int j=0; j<num_x; j+=1) {
      float r=random(40)+215;
      float g=random(80)+150;
      float b=random(100)+40;
      float speed=random(1);
      dots[idx++]=new Dot(r,g,b,i*size,j*size,size,speed);
    }
  }
}

void draw() {
  randomSeed(rs);  

  for(int i=0;i<num_x*num_y;i++)
    dots[i].dotDraw();
}

int count=0;  // variable that needs for color changing

//if you click the mouse, then dots' colors will change. (In yellow -> red -> blue -> green order)
void mouseClicked(){
   rs = 10;
   count += 1;
   int idx=0; 
  
   for (int i=0; i<num_y; i+=1) {
    for (int j=0; j<num_x; j+=1) {
      float r,g,b;
      if(count == 1){      //red
        r=random(30)+225;
        g=random(80)+130;
        b=random(80)+80;
      }
      else if(count ==2){  //blue
        b=random(70)+165;
        g=random(70)+140;
        r=random(80)+100;
      }
      else if(count==3){   //green
        r=random(70)+145;
        g=random(60)+150;
        b=random(100)+50;
      }    
      else{                //yellow 
        r=random(40)+215;
        g=random(80)+150;
        b=random(100)+40;
      }  
      float speed=random(1);
      dots[idx++]=new Dot(r,g,b,i*size,j*size,size,speed);
    }
  }
  
  if(count>=4) count=0;
}

class Dot{
 float x,y;
 float speed;
 float currnt;
 color from,to;
 int size;
 
 //Dot constructor
 Dot(float _r,float _g,float _b,float _y,float _x,int _size,float _speed){
  from=color(_r,_g,_b);
  to=color(255,255,255);
  x=_x; y=_y;
  size=_size;
  speed=_speed*0.1;
  currnt=0;
 }
 
 //Dot drawing method
 void dotDraw(){
  color newColor=lerpColor(from,to,currnt);
  fill(newColor);
  ellipse(x,y,size,size);
  
  currnt += speed;
  
  //Dot blink (color change)
  if(currnt>1){
   color temp=from;
   from=to;
   to=temp;
   currnt=0;
  }
 }
}
