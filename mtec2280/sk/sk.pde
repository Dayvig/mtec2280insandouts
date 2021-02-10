PImage shuttle;
PImage hand;
PImage beam;

float opacity;
float fade = 1;
float fall = 0;
String quote = "Zip Zoom";
float shoot;

void setup() {
  size(1200, 1200);
  background(255);
  imageMode(CENTER); //Draw image from center point  // Assign image to object using loadImage() method
  textAlign(CENTER);
  textSize(88);
  
  shuttle = loadImage("modular-shuttle-k36.jpg");
  hand = loadImage("hand.png");
  beam = loadImage("beam.png");

}
void draw() {
  background(255);  // display image with image() method, x and y coordinates of center point of its image
  image (shuttle, width/2, height/2); // placing this in the center of the canvas}

  if (mousePressed){
    image(hand, (width/2)-50, fall, 500, 300);
    if (fall < height/2){
      fall += 2;
    }
    else {
      fall = 0;
    }
  }
  fill(opacity);
  text(quote, width/2, height/2);
  opacity = opacity + fade;
  if (opacity > 255 || opacity < 0){
    fade = -fade;
  }
  
  image(beam, ((width/2)-200) - shoot, (height/2)+shoot);
  if (shoot > 600 || shoot < 0){
    shoot = 0;
  }
  shoot++;
  
}
