float r = 255;
float g = 255;
float b = 255;
float timer = 0;
float interval = 8;

float currentX;
float currentY;
float angle = 45;
boolean bouncedTB = false;

void setup() {
  size(1600,900);
  background(r, g, b);
  ellipseMode(CENTER);
  currentX = width/2;
  currentY = height/2;
  frameRate(60);
}

void draw(){
  noStroke();
  fill(r, g, b);
  
  ellipse(currentX, currentY, 40, 40);
    
  if (angle < -360){
    angle += 360;
  }
  if (angle > 360){
    angle -= 360;
  }
  println("Angle: "+angle);

  if (currentX > width){

    if (angle < 0){
      angle -= 90;
    }
    else if (angle > 0){
      angle += 90;
    }
      
    currentX = width - 20;
    println("BounceRight");
    
  }
  if (currentX < 0){
    
    if (angle > 0){
      angle -= 90;
    }
    else if (angle < 0){
      angle += 90;
    }

      
    currentX = 20;
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
  currentX += cos(radians(angle)) * 10;
  currentY += sin(radians(angle)) * 10;

  if (timer > interval){
    background(r, g, b);
    timer = 0;
  }

                                                                                                                                                                                                                        
}
