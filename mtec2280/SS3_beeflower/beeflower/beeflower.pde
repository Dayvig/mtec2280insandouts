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
  bee = loadImage("bee.png");
  flower = loadImage("sunflower.png");
  imageMode(CENTER);
  size(800, 800);
  background(255);
  frameRate(60);
  beeX = (int)random(0, width);
  beeY = (int)random(0, height/2);
}

void draw(){
  background(255);
  
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
  image(flower, mouseX, height + flowerHeight, 500, 1000);
  hitboxX = mouseX - 40;
  hitboxY = height + flowerHeight - 240;
  
  
  //bee
  if (ctr >= spacing){
    xMove = (int)random(-4, 4);
    yMove = (int)random(-4, 4);
    
    if (beeY < 0){
      yMove = 4;
    }
    if (beeX < 0){
      xMove = 4;
    }
    if (beeY > height){
      yMove = -4;
    }
    if (beeX > width){
      xMove = -4;
    }
    ctr = 0;
  }
  else {
    ctr++;
  }
  beeX += xMove;
  beeY += yMove;
  
  image(bee, beeX, beeY, 80, 80);
  
  if ((beeX > (hitboxX - 100) && beeX < (hitboxX + 100) && (beeY > (hitboxY - 100) && beeY < (hitboxY + 100)))){
    caught++;
    println(caught);
    beeX = (int)random(0, width);
    beeY = (int)random(0, height);
  }
}

void mousePressed(){
   held = true;
}

void mouseReleased(){
  held = false;
}
