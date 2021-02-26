String [] nameList = {"Paola", "Zarina", "Mamadou", "Paolo", "Harrison", "Arash", "Sahan", "Steven", "Mohammed", "Camille", "Karla", "Cody", "Shanice", "Max", "Ling Mei"};
String [] chosenNames = new String[15];

int trueLength;

void setup(){
  size(1000, 1000);
  background(0, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(36);
  trueLength = nameList.length-1;
}

void draw(){
}

void mousePressed(){
  
      if (trueLength < 0){
      for (int i = 0; i< nameList.length;i++){
        nameList[i] = chosenNames[i];
        chosenNames[i] = "You shouldn't see this";
      } 
      trueLength = nameList.length-1;
      }
      
    int r = (int)random(0, trueLength);
    background(0, 0, 0);
    text(nameList[r], width/2, height/2);
    text(trueLength, width/2, height/4 * 3);
    chosenNames[trueLength] = nameList[r];
    println(chosenNames[trueLength]);
    nameList[r] = nameList[trueLength];
    trueLength--;
    
}
