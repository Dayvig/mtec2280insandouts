float grow = 0.2;
boolean growing = true;

void setup(){
  
  size(1600, 900);
  
}

void draw(){

if (growing){
grow += 1;
}
else {
  grow -= 1;
}
if (grow > 200 || grow < 0){
  growing = !growing;
}

println("Grow: "+grow);
  
//canvas
size(1600, 900);
background(0, 172, 255);



//rays
noStroke();
fill(253, 92, 109);
triangle(0, 0, mouseX, (mouseY - 20), 0, (400 + grow));
fill(255,  166,  104);
quad(0, 400, 0, 800, 450, 600, mouseX, (mouseY - 20));
fill(206,  145,  249);
triangle(450, 600, mouseX, (mouseY - 20), 900, 600);
fill(255,  65,  151);
triangle(900, 600, mouseX, (mouseY - 20), 1450, 600);
fill(   113,  42,  255);
quad(1450, 600, mouseX, (mouseY - 20), 1600, 0, 1600, 600);

//sun
noStroke();
fill(255,  200,  115);
ellipse((mouseX), (mouseY), 400, 400);

//mountains
//base
noStroke();
fill(51,  40,  23);
quad(0, 600, 1600, 600, 1600, 950, 0, 950);
//peaks
triangle(0, 450, 0, 600, 300, 600);
triangle(300, 600, 400, 500, 600, 600);
triangle(600, 600, 900, 550, 1000, 600);
triangle(1000, 600, 1200, 450, 1350, 600);
triangle(1350, 600, 1600, 300, 1600, 600);

}
