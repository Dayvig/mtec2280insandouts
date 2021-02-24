float r = 255;
float g = 255;
float b = 255;
float timer = 0;
float interval = 8;

float currentX;
float currentY;
float angle = 45;

void setup() {
  size(1200,800);
  background(r, g, b);
  ellipseMode(CENTER);
  currentX = width/2;
  currentY = height/2;
  frameRate(60);
}

void draw(){
  noStroke();
  fill(r, g, b);
  ellipse(currentX, currentY, 200, 200);
  currentX += cos(radians(angle)) * 10;
  currentY += sin(radians(angle)) * 10;
  
  if (currentX > width - 100){
    angle -= 90;
    currentX = width - 100;
    println("BounceRight");
    println("Angle: "+angle);
  }
  else if (currentX < 100){
    angle -= 90;
    currentX = 100;
    println("BounceLeft");
    println("Angle: "+angle);
  }
  else if (currentY > height - 100){
    angle -= 90;
    currentY = height - 100;
    println("BounceBottom");
    println("Angle: "+angle);
  }
  else if (currentY < 100){
    angle -= 90;
    currentY = 100;
    println("BounceTop");
    println("Angle: "+angle);
  }
  
  r = random(0, 256);
  g = random(0, 256);
  b = random(0, 256);
  timer++;
  if (timer > interval){
    background(r, g, b);
    timer = 0;
  }

  
}
