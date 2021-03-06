import processing.serial.*;
Serial myPort; //creating object from Serial class
boolean firstContact = false;

int score = 0;

float playerX = 1000;
float playerY = 1000;

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
int blastTimer = 0;
boolean canCollect = true;

ArrayList<Asteroid> Asteroids = new ArrayList<Asteroid>();
ArrayList<Asteroid> Temp = new ArrayList<Asteroid>();

ArrayList<Blast> Blasts = new ArrayList<Blast>();
ArrayList<Blast> DestroyedBlasts = new ArrayList<Blast>();
ArrayList<Blast> BlastQueue = new ArrayList<Blast>();

ArrayList<Capsule> Capsules = new ArrayList<Capsule>();
ArrayList<Capsule> DestroyedCapsules = new ArrayList<Capsule>();
ArrayList<Capsule> CapsulesToAdd = new ArrayList<Capsule>();

private float redStationX = 2000;
private float redStationY = 200;
private float blueStationX = -400;
private float blueStationY = 2400;
private float greenStationX = -1800;
private float greenStationY = -3000;

int inByte;

int [] serialInArray = new int[3];
int serialCount = 0;


void setup() {
  size(1200, 800);
  println(MOVESPEED);
  background(255);
  frameRate(FRAMERATE);
  String[] portList = Serial.list();
  String portName = portList[0];
  myPort = new Serial(this, portName, 9600);


  setupAsteroids();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  updateShipMovement();
  updateObjectMovement();
  drawStaticObjects();
  fill(0, 255, 0);
  noStroke();
  ellipseMode(CENTER);  // Set ellipseMode to CENTER
  ellipse(0, 0, 20, 20);
  textSize(32);
  text(score, 0, -20);
}

void keyPressed() {
  if (key == 'W' || key == 'w') {
    moveNorth = true;
  }
  if (key == 'D' || key == 'd') {
    moveEast = true;
  }
  if (key == 'A' || key == 'a') {
    moveWest = true;
  }
  if (key == 'S' || key == 's') {
    moveSouth = true;
  }
}


void keyReleased() {
  if (key == 'W' || key == 'w') {
    moveNorth = false;
  }
  if (key == 'D' || key == 'd') {
    moveEast = false;
  }
  if (key == 'A' || key == 'a') {
    moveWest = false;
  }
  if (key == 'S' || key == 's') {
    moveSouth = false;
  }
}

void updateShipMovement() {

  //resets collection

  //Apply thrust in the movement directions
  if (moveNorth) { 
    if (vThrust > -5) {
      vThrust -= (MOVESPEED);
    }
  }
  if (moveSouth) {     
    if (vThrust < 5) {
      vThrust += (MOVESPEED);
    }
  }
  if (moveEast) {     
    if (hThrust < 5) {
      hThrust += (MOVESPEED);
    }
  }
  if (moveWest) {     
    if (hThrust > -5) {
      hThrust -= (MOVESPEED);
    }
  }

  //Slowly reduce horizontal to 0
  if (hThrust < 0.05 && hThrust > -0.05) {
    hThrust = 0;
  } else {
    if (hThrust > 0.05) {
      hThrust -= FRICTION;
    } else if (hThrust < -0.05) {
      hThrust += FRICTION;
    }
  }

  //slowly reduce vertical to 0
  if (vThrust < 0.05 && vThrust > -0.05) {
    vThrust = 0;
  } else {
    if (vThrust > 0.05) {
      vThrust -= FRICTION;
    } else if (vThrust <-0.05) {
      vThrust += FRICTION;
    }
  }

  //update position
  playerY += vThrust; 
  playerX += hThrust;

  //add Blasts
  if (mousePressed && blastTimer >= 10) {
    float ratio = (float)(mouseY - (height/2)) / (mouseX - (width/2));
    if ((mouseX - (width/2)) <= 0) {
      ratio = ( radians(180) - (atan(ratio) * -1) );
    } else {
      ratio = atan(ratio);
    }
    Blast laser = new Blast(playerX, playerY, ratio, 20);
    BlastQueue.add(laser);
    blastTimer = 0;
  }
  blastTimer++;
}

void updateObjectMovement() {

  fill(0, 0, 0);
  noStroke();
  for (Asteroid a : Asteroids) {
    a.move();
    a.render();
    if (a.markForDestruction) {
      Temp.add(a);
    }
  }

  for (Asteroid a : Temp) {
    if (a instanceof SmallAsteroid) {
      SmallAsteroid temp = (SmallAsteroid)a;
      temp.destroy(temp.destructionByPlayer);
    } else {
      a.destroy();
    }
  }
  Temp.clear();

  for (Blast b : Blasts) {
    b.update();
    b.render();
    if (b.markForDestruction) {
      DestroyedBlasts.add(b);
    }
  }
  for (Blast b : DestroyedBlasts) {
    Blasts.remove(b);
  }
  DestroyedBlasts.clear();
  for (Blast b : BlastQueue) {
    Blasts.add(b);
  }
  BlastQueue.clear();

  for (Capsule c : Capsules) {
    c.render();
    c.move();
    if (dist(c.xPos, c.yPos, redStationX, redStationY) < 1000) {
      if (c.type == 0) {
        score++;
      } else {
        score--;
      }
      c.markForDestruction = true;
    }

    if (dist(c.xPos, c.yPos, greenStationX, greenStationY) < 1000) {
      if (c.type == 2) {
        score++;
      } else {
        score--;
      }
      c.markForDestruction = true;
    }

    if (dist(c.xPos, c.yPos, blueStationX, blueStationY) < 1000) {
      if (c.type == 1) {
        score++;
      } else {
        score--;
      }
      c.markForDestruction = true;
    }
    if (c.markForDestruction) {
      DestroyedCapsules.add(c);
    }
  }
  for (Capsule c : CapsulesToAdd) {
    Capsules.add(c);
  }
  CapsulesToAdd.clear();

  for (Capsule c : DestroyedCapsules) {
    Capsules.remove(c);
  }
  DestroyedCapsules.clear();
}

void setupAsteroids() {

  for (int i = 0; i < 200; i++) {
    Asteroid next;
    float x = random(-4000, 4000);
    float y = random(-4000, 4000);
    int s = (int)random(1, 3);
    float sp = random(1, 4);
    int angl = (int)random(0, 180);
    switch (s) {
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

//0- Asteroid
//1- Capsule
void collision() {
}

void drawStaticObjects() {

  stroke(255, 0, 0);
  strokeWeight(500);
  noFill();
  quad(
    -5000 - playerX, -5000 - playerY, 
    5000 - playerX, -5000 - playerY, 
    5000 - playerX, 5000 - playerY, 
    -5000 - playerX, 5000 - playerY
    );
  fill(255, 0, 0);
  stroke(0);
  strokeWeight(32);
  ellipse(redStationX - playerX, redStationY - playerY, 400, 400);
  fill(0, 255, 0);
  ellipse(greenStationX - playerX, greenStationY - playerY, 400, 400);
  fill(0, 0, 255);
  ellipse(blueStationX - playerX, blueStationY - playerY, 400, 400);
  noStroke();

  //ellipse(staticObjectX - playerX, staticObjectY - playerY, 400, 400);
}

void serialEvent(Serial myPort) {
  inByte = myPort.read();

  if (!firstContact) {
    if (inByte == 'C') {
      myPort.clear();
      firstContact = true;
      myPort.write('C');
      return;
    }
  }
  if (inByte == 'A') {
    canCollect = false;
    return;
    
  } 
  
    else if (inByte == 'N') {
    canCollect = true;
    return;
  }
    if (serialCount >= 2) {
      boolean d = false;
      if (serialInArray[1] == 1) {
        d = true;
      }
      Capsule c = new Capsule(playerX, playerY + 200, d, serialInArray[0]);
      CapsulesToAdd.add(c);
      serialCount = 0;
    } else {
      serialInArray[serialCount] = inByte;
      serialCount++;
    }
}
