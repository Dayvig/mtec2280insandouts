class SmallAsteroid extends Asteroid {
  
  boolean destructionByPlayer = false;
  
    SmallAsteroid(){
    super();
  }
  
  SmallAsteroid(float x, float y, int a){
    super(x, y, a);
  }
  
  SmallAsteroid(float x, float y, int a, int s, int h, float sp){
    super(x, y, a, s, h, sp);
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
      destructionByPlayer = true;
      markForDestruction = true;
    }

  }
  
    void destroy(boolean destroyedByPlayer){
          //discharge materials
          Asteroids.remove(this);
          if (destroyedByPlayer){
          boolean damaged = false;
          if ((int)random(0, 10) == 9){
            damaged = true;
          }
          Capsule c = new Capsule(xPos + random(-100, 100), yPos + random(-100, 100), damaged, (int)random(0, 3));
          Capsules.add(c);
          }
          super.destroy();
  }
}
