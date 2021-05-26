 
 
 class Capsule {
   
   boolean isDamaged;
   int type;
   //0- Red
   //1- Blue
   //2- Green
   //3- Orange
   float xPos;
   float yPos;
   boolean markForDestruction = false;
   
   public Capsule(float x, float y){
     isDamaged = false;
     type = 0;
     xPos = x;
     yPos = y;
     markForDestruction = false;
   }
   
   public Capsule(float x, float y, boolean d, int t){
     isDamaged = d;
     type = t;
     xPos = x;
     yPos = y;
     markForDestruction = false;
   }
   
   void move(){
    if (dist(xPos, yPos, playerX, playerY) < 100){
      if (canCollect){
        sendCapsuleData();
      }
    }
   }
   
   void sendCapsuleData(){
     //send capsule data
     myPort.clear();
     int damageData = 0;
     if (isDamaged){damageData = 1;}
     myPort.write(type);
     myPort.write(damageData);
     myPort.write('B');
     markForDestruction = true;
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
        fill(100, 100, 100);
        ellipse(xPos - playerX, yPos - playerY, 40, 40);
      }
  }
  
}
