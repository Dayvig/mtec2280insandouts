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

PImage bee;
PImage flower;
int flowerHeight = 50;
boolean held = false;
int hitboxX;
int hitboxY;
int beeX;
int beeY;
float ctr = 0;
float spacing = 30;
int xMove = 0;
int yMove = 0;

int caught = 0;

void setup(){
  
  size(1600, 900);
  lArrow = loadImage("larrow.png");
  rArrow = loadImage("rarrow.png");
  bee = loadImage("bee.png");
  flower = loadImage("sunflower.png");
  ellipseMode(CENTER);
  currentX = width/2;
  currentY = height/2;
  size(1600, 900);
  background(0, 172, 255);
  frameRate(60);
  beeX = (int)random(0, width);
  beeY = (int)random(0, height/2);
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
    
  }
  if (currentX < 0){
    
    if (angle > 0){
      angle -= 90;
    }
    else if (angle < 0){
      angle += 90;
    }

      
    currentX = 20 + offset;    
  }
  if (currentY > height){
    
    angle = -angle;
    
    
    currentY = height - 20;

  }
  
  if (currentY < 0){

    angle = -angle; 
    currentY = 20;
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
  if (state == 3 || state == 4){
     fill(255);
     if (state == 3){
  rect(1600, 0, 1600, 900);
     }
     else {
  rect(0, 0, 1600, 900);
     }
  
    //flower
    if (held && flowerHeight > -height/2){
    flowerHeight -= 2;
  }
  else if (!held && flowerHeight < 50){
    flowerHeight += 2;
  }
  else if (!held && flowerHeight >= 50){
    flowerHeight = 50;
  }
  if (state == 3){
    image(flower, mouseX+1600, height + flowerHeight, 500, 1000);
  }
  else {
    image(flower, mouseX, height + flowerHeight, 500, 1000);
  }
  hitboxX = mouseX - 40;
  hitboxY = height + flowerHeight - 240;
  
  
  //bee
  if (ctr >= spacing){
    xMove = (int)random(-6, 6);
    yMove = (int)random(-6, 6);
    
    if (beeY < 0){
      yMove = 6;
    }
    if (beeX < 0){
      xMove = 6;
    }
    if (beeY > height){
      yMove = -6;
    }
    if (beeX > width){
      xMove = -6;
    }
    ctr = 0;
  }
  else {
    ctr++;
  }
  beeX += xMove;
  beeY += yMove;
  if (state == 3){
  image(bee, beeX+1600, beeY, 80, 80);
  }
  else {
  image(bee, beeX, beeY, 80, 80);
  }
  textSize(48);
  fill(0, 0, 0);
  if (state == 3){
  text(""+caught, width/2+1600, height/4 *3);
  }
  else {
  text(""+caught, width/2, height/4 *3);
  }
  
  if ((beeX > (hitboxX - 100) && beeX < (hitboxX + 100) && (beeY > (hitboxY - 100) && beeY < (hitboxY + 100)))){
    caught++;
    beeX = (int)random(0, width);
    beeY = (int)random(0, height);
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

void mouseReleased(){
  held = false;
}


void mousePressed(){
    held = true;
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
  state++;
  println("State: " + state);
  panTimer = 60;
  }
}

void panRight(){
  
}

void updateGraphics(){
    if (panningLeft){
          offset = (60-panTimer)*26.66666;
      if (panTimer <= 60 && panTimer > 0){
      translate(-offset, 0);
      }
      if (panTimer <= 0){
        translate(0, 0);
        panningLeft = false;
        offset = 0;
        state++;
        println("State: " + state);
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
