#define SLIDE A0
#define ANALYZEGREEN 13
#define ANALYZERED 12
#define ANALYZEBLUE 11
#define ANALYZEBUTTON 10
#define EJECTBUTTON 6
#define BAY1 2
#define BAY2 3
#define BAY3 4
#define BADALERT 5

int slideVal = 0;
int inByte = 0;
int serialInArray[3];
int serialCount = 0;
boolean noBayData = true;

float currentTime = 0;
float analyzeTimer = 20;
float grace = 5;
float graceTimer = 0;

int buttonState;
int ejectState;
int analyzingBay;
int activeBay = 0;

boolean establishingContact = true;

int bays[3][2] = {

  {-1, -1 },
  {-1, -1 },
  {-1, -1 }

};
    //No cargo, null damaged;

void setup() {
  // put your setup code here, to run once:
      Serial.begin(9600);
    while(!Serial){
      delay(10);
    }
    pinMode(SLIDE, INPUT);
    pinMode(ANALYZEGREEN, OUTPUT);
    pinMode(ANALYZERED, OUTPUT);
    pinMode(ANALYZEBLUE, OUTPUT);
    pinMode(ANALYZEBUTTON, INPUT_PULLUP);
    pinMode(EJECTBUTTON, INPUT_PULLUP);
    pinMode(BAY1, OUTPUT);
    pinMode(BAY2, OUTPUT);
    pinMode(BAY3, OUTPUT);
    pinMode(BADALERT, OUTPUT);

         establishContact();
}

void loop() {
  // put your main code here, to run repeatedly:
    delay(10);

    if (Serial.available() > 0){
      inByte = Serial.read();
        if (inByte == 'B'){
              fillBays();
              serialCount = 0;
        }
        else {
            serialInArray[serialCount] = inByte;
            serialCount++;
        }
    }
    
    if (bays[0][0] > -1 && bays[0][0] < 3){
      digitalWrite(BAY1, HIGH);
    }
    else {
      digitalWrite(BAY1, LOW);
    }

    if (bays[1][0] > -1 && bays[1][0] < 3){
      digitalWrite(BAY2, HIGH);
    }
    else {
      digitalWrite(BAY2, LOW);
    }

    if (bays[2][0] > -1 && bays[2][0] < 3){
      digitalWrite(BAY3, HIGH);
    }
    else {
      digitalWrite(BAY3, LOW);
    }
    
    slideVal = analogRead(SLIDE);
    activeBay = map(slideVal, 0, 400, 0, 2);
    if (activeBay > 2){ activeBay = 2; }
    if (activeBay < 0) { activeBay = 0; }
    int prevState = buttonState;
    int prevEject = ejectState;
    buttonState = digitalRead(ANALYZEBUTTON);
    ejectState = digitalRead(EJECTBUTTON);
    
    if (ejectState == 0 && prevEject == 1){

      //eject
      if (bays[activeBay][0] != -1){
      Serial.write(bays[activeBay][0]);
      Serial.write(bays[activeBay][1]);
      Serial.write(-1);
      bays[activeBay][0] = -1;
      bays[activeBay][1] = -1;
      }
    }

    if (buttonState == 0){
      if (prevState == 1){ Serial.write('A'); }
      currentTime--;
    }
    else {
      if (prevState == 0){ Serial.write('N'); }
      currentTime = analyzeTimer;
    }
    
    if (currentTime == analyzeTimer){
      digitalWrite(ANALYZEGREEN, HIGH);
      digitalWrite(ANALYZERED, HIGH);
      digitalWrite(ANALYZEBLUE, HIGH);
    }
    else if (currentTime <= 0){
    if (bays[activeBay][0] == 0){
      digitalWrite(ANALYZEGREEN, LOW);
      digitalWrite(ANALYZERED, HIGH);
      digitalWrite(ANALYZEBLUE, HIGH);
    }
    else if (bays[activeBay][0] == 1){
      digitalWrite(ANALYZEGREEN, HIGH);
      digitalWrite(ANALYZERED, LOW);
      digitalWrite(ANALYZEBLUE, HIGH);
      }
     else if (bays[activeBay][0] == 2){
       digitalWrite(ANALYZEGREEN, HIGH);
      digitalWrite(ANALYZERED, HIGH);
      digitalWrite(ANALYZEBLUE, LOW);
     }
    }
    if (currentTime <= -200){
      if (bays[activeBay][1] == 1){
        digitalWrite(BADALERT, HIGH);
      }
      else {
        digitalWrite(BADALERT, LOW);
        }
    }
    else {
       digitalWrite(BADALERT, LOW);
    }
    //Serial.println(bay);
}

void establishContact(){

  while(Serial.available() <= 0){
    Serial.print('C');
    delay(300);
  }

  establishingContact = false;
  
}

void fillBays(){
  for (int i = 0; i<3; i++){
  if (bays[i][0] == -1){
    bays[i][0] = serialInArray[0];
    bays[i][1] = serialInArray[1];
    break;
    }
  }
}
