#define SLIDE A0
#define ANALYZEGREEN 13
#define ANALYZERED 12
#define ANALYZEBLUE 11
#define ANALYZEBUTTON 10

int slideVal = 0;
int inByte = 0;


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

          establishContact();
}

void loop() {
  // put your main code here, to run repeatedly:
    delay(10);
    //slideVal = analogRead(SLIDE);
    //int bay = map(slideVal, 0, 1023, 0, 3);
    int buttonState = digitalRead(ANALYZEBUTTON);

    if (Serial.available() > 0){
      inByte = Serial.read();
    }

    if (buttonState == 0){
    if (inByte == 0){
      digitalWrite(ANALYZEGREEN, LOW);
      digitalWrite(ANALYZERED, HIGH);
      digitalWrite(ANALYZEBLUE, HIGH);
    }
    else if (inByte == 1){
      digitalWrite(ANALYZEGREEN, HIGH);
      digitalWrite(ANALYZERED, LOW);
      digitalWrite(ANALYZEBLUE, HIGH);
      }
     else if (inByte == 2){
       digitalWrite(ANALYZEGREEN, HIGH);
      digitalWrite(ANALYZERED, HIGH);
      digitalWrite(ANALYZEBLUE, LOW);
     }
     else {
      digitalWrite(ANALYZEGREEN, HIGH);
      digitalWrite(ANALYZERED, HIGH);
      digitalWrite(ANALYZEBLUE, HIGH);
     }
    }
    else {
      digitalWrite(ANALYZEGREEN, HIGH);
      digitalWrite(ANALYZERED, HIGH);
      digitalWrite(ANALYZEBLUE, HIGH);
    }
    //Serial.println(bay);
}

void establishContact(){

  while(Serial.available() <= 0){
    Serial.print('A');
    delay(300);
  }

}
