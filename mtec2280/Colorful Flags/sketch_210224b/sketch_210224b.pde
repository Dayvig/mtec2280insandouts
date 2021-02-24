void setup(){
  size(800, 800);
}

void draw(){

}

void drawFlag(int xc, int yc, int r, int g, int b){
   
  line(xc, yc, xc, yc - 60);
  fill(r, g, b);
  quad(xc, yc-60, xc-40, yc - 60, xc-40, yc-40, xc, yc-40);
 
}

void mousePressed(){
  int randomR = (int)random(0, 255);
  int randomG = (int)random(0, 255);
  int randomB = (int)random(0, 255);
  drawFlag (mouseX, mouseY, randomR, randomG, randomB);
}
