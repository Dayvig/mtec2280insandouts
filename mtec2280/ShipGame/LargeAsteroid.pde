
          
class LargeAsteroid extends Asteroid {
  
    LargeAsteroid(){
    super();
  }
  
  LargeAsteroid(float x, float y, int a){
    super(x, y, a);
  }
  
  LargeAsteroid(float x, float y, int a, int s, int h, float sp){
    super(x, y, a, s, h, sp);
  }
  
  void destroy(){
          MediumAsteroid Chunk1 = new MediumAsteroid(this.xPos, this.yPos, (int)this.angle + 45, (int)this.size/2, (int)this.maxHP/2, this.speed * 2);
          MediumAsteroid Chunk2 = new MediumAsteroid(this.xPos, this.yPos, (int)this.angle - 45, (int)this.size/2, (int)this.maxHP/2, this.speed * 2);
          Asteroids.add(Chunk1);
          Asteroids.add(Chunk2);
          Asteroids.remove(this);
          super.destroy();
  }
}
  
  
  
