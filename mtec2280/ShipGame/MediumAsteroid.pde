class MediumAsteroid extends Asteroid {
  
    MediumAsteroid(){
    super();
  }
  
  MediumAsteroid(float x, float y, int a){
    super(x, y, a);
  }
  
  MediumAsteroid(float x, float y, int a, int s, int h, float sp){
    super(x, y, a, s, h, sp);
  }
  
    void destroy(){
          SmallAsteroid Chunk1 = new SmallAsteroid(this.xPos, this.yPos, (int)this.angle + 45, (int)this.size/2, (int)this.maxHP/2, this.speed * 2);
          SmallAsteroid Chunk2 = new SmallAsteroid(this.xPos, this.yPos, (int)this.angle - 45, (int)this.size/2, (int)this.maxHP/2, this.speed * 2);
          Asteroids.add(Chunk1);
          Asteroids.add(Chunk2);
          Asteroids.remove(this);
          super.destroy();
  }
}
