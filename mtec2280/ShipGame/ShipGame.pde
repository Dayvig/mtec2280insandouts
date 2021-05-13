float playerX = 1000;
float playerY = 1000;

int staticObjectX = 2000;
int staticObjectY = 2000;

boolean moveNorth = false;
boolean moveEast = false;
boolean moveWest = false;
boolean moveSouth = false;

float vThrust = 0;
float hThrust = 0;

int FRAMERATE = 60;
float MOVESPEED = 0.08;
float FRICTION = 0.008;
int destructionCtr = 0;

ArrayList<Asteroid> Asteroids = new ArrayList<Asteroid>();
ArrayList<Asteroid> Temp = new ArrayList<Asteroid>();

void setup(){
  size(1200, 800);
  println(MOVESPEED);
  background(255);
  frameRate(FRAMERATE);
  //setupAsteroids();
  Asteroid next = new LargeAsteroid(1000, 1000, 45, 400, 20, 2);
  Asteroids.add(next);
}

void draw(){
    background(255);
    translate(width/2, height/2);
    updateShipMovement();
    drawStaticObjects();
    updateObjectMovement();
    fill(0, 255, 0);
    noStroke();
    ellipseMode(CENTER);  // Set ellipseMode to CENTER
    ellipse(0, 0, 20, 20);
}

void keyPressed(){
    if (key == 'W' || key == 'w'){
      moveNorth = true;
    }
    if (key == 'D' || key == 'd'){
      moveEast = true;
    }
    if (key == 'A' || key == 'a'){
      moveWest = true;
    }
    if (key == 'S' || key == 's'){
      moveSouth = true;
    }
}

void mouseClicked(){
   for (Asteroid a : Asteroids){
     a.markForDestruction = true;
   }
}

void keyReleased(){
    if (key == 'W' || key == 'w'){
      moveNorth = false;
    }
    if (key == 'D' || key == 'd'){
      moveEast = false;
    }
    if (key == 'A' || key == 'a'){
      moveWest = false;
    }
    if (key == 'S' || key == 's'){
      moveSouth = false;
    }
}

void updateShipMovement(){
 
  //Apply thrust in the movement directions
  if (moveNorth){ 
    if (vThrust > -5){
    vThrust -= (MOVESPEED);
    }
  }
  if (moveSouth){     
    if (vThrust < 5){
    vThrust += (MOVESPEED);
    }
  }
  if (moveEast){     
    if (hThrust < 5){
    hThrust += (MOVESPEED);
    } 
  }
  if (moveWest){     
    if (hThrust > -5){
    hThrust -= (MOVESPEED);
    } 
  }
  
  //Slowly reduce horizontal to 0
  if (hThrust < 0.05 && hThrust > -0.05){
    hThrust = 0;
  }
  else {
  if (hThrust > 0.05){
    hThrust -= FRICTION;
  }
  else if (hThrust < -0.05){
    hThrust += FRICTION;
    }
  }
  
  //slowly reduce vertical to 0
  if (vThrust < 0.05 && vThrust > -0.05){
    vThrust = 0;
  }
  else {
  if (vThrust > 0.05){
    vThrust -= FRICTION;
  }
  else if (vThrust <-0.05){
    vThrust += FRICTION;
    }
  }
  
  //update position
      playerY += vThrust; 
      playerX += hThrust;
  
}

void updateObjectMovement(){
  
  fill(0, 0, 0);
  noStroke();
  for (Asteroid a : Asteroids){
  a.move();
  a.render();
  if (a.markForDestruction){
    Temp.add(a);
    }
  }
  for (Asteroid a : Temp){
    a.destroy();
  }
  Temp.clear();
}

void setupAsteroids(){
  
  for (int i = 0; i < 200; i++){
    Asteroid next;
    float x = random(-4000, 4000);
    float y = random(-4000, 4000);
    int s = (int)random(1, 3);
    float sp = random(1, 4);
    //int angl = (int)random(0, 180);
    int angl = 90;
    switch (s){
      case 1:
          next = new LargeAsteroid(x, y, angl, 400, 20, s);
              Asteroids.add(next);
          break;
       case 2:
          next = new MediumAsteroid(x, y, angl, 200, 10, s*2);
              Asteroids.add(next);
          break;
        case 3:
          next = new SmallAsteroid(x, y, angl, 100, 5, s*4);
              Asteroids.add(next);
          break;
        default:
          break;
    }
  }
}

void collision(){



}

void drawStaticObjects(){
  
  stroke(255, 0, 0);
  strokeWeight(500);
  noFill();
  quad(
  -5000 - playerX, -5000 - playerY, 
  5000 - playerX, -5000 - playerY, 
  5000 - playerX, 5000 - playerY, 
  -5000 - playerX, 5000 - playerY
  );
  //ellipse(staticObjectX - playerX, staticObjectY - playerY, 400, 400);
  
}
