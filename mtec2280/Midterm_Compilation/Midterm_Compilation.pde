PImage lArrow;
PImage rArrow;
float panTimer = 0;
boolean panningLeft = false;
boolean panningRight = false;

float r = 255;
float g = 255;
float b = 255;
float timer = 0;
float interval = 8;

float currentX;
float currentY;
float angle = 45;

float offset = 0;

int state = 0;

void setup(){
  
  size(1600, 900);
  lArrow = loadImage("larrow.png");
  rArrow = loadImage("rarrow.png");
  ellipseMode(CENTER);
  currentX = width/2;
  currentY = height/2;
  size(1600, 900);
  background(0, 172, 255);
  frameRate(60);
}

void draw(){

updateGraphics();

if (state == 0 || state == 1){

fill(0, 172, 255);
rect(0, 0, 1600, 900);
//rays
noStroke();
fill(253, 92, 109);
triangle(0, 0, 800, (mouseY - 20), 0, 400);
fill(255,  166,  104);
quad(0, 400, 0, 800, 450, 600, 800, (mouseY - 20));
fill(206,  145,  249);
triangle(450, 600, 800, (mouseY - 20), 900, 600);
fill(255,  65,  151);
triangle(900, 600, 800, (mouseY - 20), 1450, 600);
fill(   113,  42,  255);
quad(1450, 600, 800, (mouseY - 20), 1600, 0, 1600, 600);

//sun
noStroke();
fill(255,  200,  115);
ellipse((800), (mouseY), 400, 400);

//mountains
//base
noStroke();
fill(51,  40,  23);
quad(0, 600, 1600, 600, 1600, 950, 0, 950);
//peaks
triangle(0, 450, 0, 600, 300, 600);
triangle(300, 600, 400, 500, 600, 600);
triangle(600, 600, 900, 550, 1000, 600);
triangle(1000, 600, 1200, 450, 1350, 600);
triangle(1350, 600, 1600, 300, 1600, 600);
}

if (state == 1 || state == 2){
  noStroke();
  fill(r, g, b);
  
  if (state == 1){
  ellipse(1600 + currentX, currentY, 40, 40);
  }
  else {
      ellipse(currentX, currentY, 40, 40);
  }
    
  if (angle < -360){
    angle += 360;
  }
  if (angle > 360){
    angle -= 360;
  }

  if (currentX > width){

    if (angle < 0){
      angle -= 90;
    }
    else if (angle > 0){
      angle += 90;
    }
      
    currentX = width - 20 + offset;
    println("BounceRight");
    
  }
  if (currentX < 0){
    
    if (angle > 0){
      angle -= 90;
    }
    else if (angle < 0){
      angle += 90;
    }

      
    currentX = 20 + offset;
    println("BounceLeft");
    
  }
  if (currentY > height){
    
    angle = -angle;
    
    
    currentY = height - 20;
    println("BounceBottom");

  }
  
  if (currentY < 0){

    angle = -angle;
        
    currentY = 20;
    println("BounceTop");

  }

  
  r = random(0, 256);
  g = random(0, 256);
  b = random(0, 256);
  timer++;
  currentX += (cos(radians(angle)) * 10);
  currentY += (sin(radians(angle)) * 10);
  
  if (timer > interval){
    fill (r, g, b);
    if (state == 2){
          rect(0, 0, 1600, 900);
    }
    else {
          rect(1600, 0, 1600, 900);
    }
    timer = 0;
  }
}

//arrows
imageMode(CENTER);
float rightArrowX = 1560;
float leftArrowX = 40;
if (panTimer <= 60 && panTimer > 0){
      rightArrowX = 1540 + (60-panTimer)*26.666666666;
      leftArrowX = 20 + (60-panTimer)*26.66;
      }
      if (panTimer <= 0){
        rightArrowX = 1560;
        leftArrowX = 40;
      }
image(rArrow, rightArrowX, 450, 100, 200);
image(lArrow, leftArrowX, 450, 100, 200);
}

void mousePressed(){
 
  /*
  if (state == 0){
    state = 2;
  }else { state = 0; }
  */
    
 if ((mouseX < 100 && mouseX > 0) && (mouseY > 250 && mouseY < 650)){
   panLeft();
 }
 if ((mouseX < 1600 && mouseX > 1500) && (mouseY > 250 && mouseY < 650)){
   println("Pan Right");
   panRight();
 }
}

void panLeft(){
  if (!panningLeft){
  panningLeft = true;
  state = 1;
  println("Panning Left");
  panTimer = 60;
  }
}

void panRight(){
  
}

void updateGraphics(){
    if (panningLeft){
          offset = (60-panTimer)*26.66666;
          println("offset: "+offset);
      if (panTimer <= 60 && panTimer > 0){
      translate(-offset, 0);
      }
      if (panTimer <= 0){
        translate(0, 0);
        panningLeft = false;
        offset = 0;
        state = 2;
      }
    }
    if (panTimer > 0){
    panTimer--;
    }
    else {
      panTimer = 0;
      offset = 0;
    }
}
