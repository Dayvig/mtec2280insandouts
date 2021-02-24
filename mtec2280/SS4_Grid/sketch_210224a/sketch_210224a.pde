  int[] xcoords = new int[64];
  int[] ycoords = new int[64];
  int offsetX = width/8;
  int offsetY = height/8;
  
void setup(){
  int cursorX;
  int cursorY;
  size(800,800);
   offsetX = width/8;
   offsetY = height/8;
  cursorX = 0;
  cursorY = 0;
  for (int i = 0; i<8;i++){
    for (int k = 0; k<8; k++){
      xcoords[(i*8)+k] = cursorX;
      ycoords[(i*8)+k] = cursorY;
      cursorX += offsetX;
      println((i*8)+k);
    }
    cursorX = 0;
    cursorY += offsetY;
  }
}

void draw(){
  for (int i = 0; i < 64; i++){
    strokeWeight(5);
    if ((mouseX > xcoords[i]) && (mouseX < xcoords[i] + offsetX) && (mouseY > ycoords[i]) && (mouseY < ycoords[i] + offsetY)){
      fill (255, 0, 0);
    }
    else {
      fill (255, 255, 255);
    }
    rect(xcoords[i], ycoords[i], 100, 100);
  }
}
