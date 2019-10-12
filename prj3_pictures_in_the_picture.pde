/*
  Project #3 by Sehyun Hwang
 
 * name : Pictures in the picture
 * description : There are two images in this program : Big one & Small one. They contains 
                 same image but in a different size. Below are steps of the algorithm.
                
                 1. Pick a pixel color from big Image.
                 2. Make a rectangle which has same size with small image and colored it.
                 3. Display the rectangle in front of small image and change the opacity value of rectangle
                    as 50% so that people can feel as if they are watching colored small picture.
                 4. Display all of small pictures in the canvas.
                 5. Reduce the size of small pictures and continue the step 1.
 */

PImage smallImg;
PImage bigImg;
int num=10;      // number of small pictures in the canvas. 10*10=100 pictures at first.
int rs=10;       // random seed value
float count=0;   // value for controlling speed
float fps=3;     // variable for controlling frame rate

void setup() {
  size(100, 100);
  frameRate(fps);
  background(0);
  noStroke();
  randomSeed(rs);
  
  /* you can use another image in "prj3_img" folder */
  bigImg=loadImage("prj3_img/bigImg.jpg");
  smallImg=loadImage("prj3_img/smallImg.png");
  /* you can use another image in "prj3_img" folder */

  surface.setSize(bigImg.width, bigImg.height);
}

void draw() {
  
  frameRate(fps);
  
  for (float y=0; y<bigImg.height; y+=bigImg.height/num) {
    for (float x=0; x<bigImg.width; x+=bigImg.width/num) {
      float p=random(0, 1.0);
      color pixel=bigImg.pixels[int(y*bigImg.width+x)];
  
      // with 50% of possibility, some of pictures will be rotated random degree.
      if (p>0.5) {
        pushMatrix();  // preserve current status
        translate(x, y);
        rotate(radians(random(0, 360)));
        image(smallImg, 0, 0, smallImg.width/(num/10), smallImg.height/(num/10));
        fill(pixel, 160);
        rect(0, 0, smallImg.width/(num/10), smallImg.height/(num/10));
        popMatrix();
      } else {      
        rotate(HALF_PI);
        image(smallImg, x, y, smallImg.width/(num/10), smallImg.height/(num/10));
        fill(pixel, 160);
        rect(x, y, smallImg.width/(num/10), smallImg.height/(num/10));
      }

    }
  }

  count += 0.1;

  if (count>1) {
    if (num<100) {
      num += 3;
      fps += 1;
    } else {
      num += 5;
      fps=70;
    }
    count=0;
  }
  println(num);
  if (num>200) {
    num=10;
    fps=3;
    delay(3000);
    background(0);
  }
}
