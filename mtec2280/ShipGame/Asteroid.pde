abstract class Asteroid {
  
  float xPos;
  float yPos;
  int size;
  int angle;
  int hp;
  float speed;
  int maxHP;
  boolean markForDestruction = false;
  /*state:
   3- Largest
   2- Medium
   1- Smallest (Destroying will yield);
  */
  
  Asteroid(){
    xPos = 2000;
    yPos = 2000;
    size = 400;
    angle = 45;
    maxHP = 20;
    hp = 20;
    speed = 2;
  }
  
  Asteroid(float x, float y, int a){
    xPos = x;
    yPos = y;
    angle = a;
    size = 400;
    maxHP = 3;
    hp = 3;
    speed = 2;
  }
  
  Asteroid(float x, float y, int a, int s, int h, float sp){
    xPos = x;
    yPos = y;
    angle = a;
    size = s;
    maxHP = h;
    hp = h;
    speed = sp;
  }
  
  void move(){
    xPos += (cos(radians(angle)) * speed);
    yPos += (sin(radians(angle)) * speed);
    if (xPos > 5000 || xPos < -5000 || yPos > 5000 || yPos < - 5000){
      markForDestruction = true;
    }
    if (dist(xPos, yPos, playerX, playerY) < size/2){
        collision();
    }
    for (Blast b : Blasts){
       if (dist(xPos, yPos, b.xPos, b.yPos) < size/2){
        hp -= b.damage;
        b.markForDestruction = true;
      }
    }
    if (hp <= 0){
      markForDestruction = true;
    }

  }
  
  void destroy(){
    destructionCtr++;
    println(destructionCtr);
    if (destructionCtr >= 8){
    Asteroid next;
    int spawning = (int)random(1, 4);
    float x;
    float y;
    int angl;
    switch (spawning){
        case 1:
            x = random(-4000, 4000);
            y = -4000;
            angl = (int)random(0, 180);
            break;
        case 2:
            x = random(-4000, 4000);
            y = 4000;
            angl = (int)random(180, 360);
            break;
         case 3:
            x = -4000;
            y = random(-4000, 4000);
            angl = (int)random(270, 450);
            break;
         case 4:
            x = 4000;
            y = random(-4000, 4000);
            angl = (int)random(90, 270);
            break;
          default:
                  x = random(-4000, 4000);
                  y = -4000;
                  angl = (int)random(0, 180);
          break;
    }
    int s = (int)random(1, 3);
    //int angl = (int)random(-180, 180);
    float sp = random(1, 4);
    switch (s){
      case 1:
          next = new LargeAsteroid(x, y, angl, 400, 20, s);
              Asteroids.add(next);
                  destructionCtr = 0;
          break;
       case 2:
          next = new MediumAsteroid(x, y, angl, 200, 10, s*2);
              Asteroids.add(next);
                  destructionCtr = 4;
          break;
        case 3:
          next = new SmallAsteroid(x, y, angl, 100, 5, s*4);
              Asteroids.add(next);
                  destructionCtr = 8;
          break;
        default:
          break;
    }
  }
  }
  
  void render(){
    if (
    (xPos - playerX > -width &&
    xPos - playerX < width &&
    yPos - playerY < height &&
    yPos - playerY > -height) &&
    !markForDestruction
    )
      {
        ellipseMode(CENTER);  // Set ellipseMode to CENTER
        ellipse(xPos - playerX, yPos - playerY, size, size);
      }
  }
  
}
