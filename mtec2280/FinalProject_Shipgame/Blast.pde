class Blast {
  
  float xPos;
  float yPos;
  float angle;
  float speed;
  boolean markForDestruction = false;
  int damage = 2;
  
  Blast(){
    xPos = playerX;
    yPos = playerY;
    angle = 90;
    speed = 10;
  }
  
  Blast(float x, float y, float a, float sp){
    xPos = x;
    yPos = y;
    angle = a;
    speed = sp;
  }
  
    Blast(float x, float y, float a, float sp, int d){
    xPos = x;
    yPos = y;
    angle = a;
    speed = sp;
    damage = d;
  }
  
  void update(){
    xPos += (cos(angle) * speed);
    yPos += (sin(angle) * speed);
    if (xPos > 5000 || xPos < -5000 || yPos > 5000 || yPos < - 5000){
      markForDestruction = true;
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
        fill(255, 0, 0);
        ellipseMode(CENTER);  // Set ellipseMode to CENTER
        ellipse(xPos - playerX, yPos - playerY, 40, 40);
      }
  }
}
