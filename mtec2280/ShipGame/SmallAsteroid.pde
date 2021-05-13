class SmallAsteroid extends Asteroid {
  
    SmallAsteroid(){
    super();
  }
  
  SmallAsteroid(float x, float y, int a){
    super(x, y, a);
  }
  
  SmallAsteroid(float x, float y, int a, int s, int h, float sp){
    super(x, y, a, s, h, sp);
  }
  
    void destroy(){
          //discharge materials
          Asteroids.remove(this);
          super.destroy();
  }
}
