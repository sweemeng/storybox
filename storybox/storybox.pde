#include <LiquidCrystal.h> 
#include <Wire.h>

#include <WordStorage.h>
#include <TrueRandom.h>
#include <Bounce.h>
#include <WordGenerator.h>

#define button1 2
#define lcdBacklit 3
#define buzzer 10
#define statusLed 13

LiquidCrystal lcd(12,11,7,6,5,4);
Bounce bouncer = Bounce(button1,50);

WordGenerator generator(7);
int storage_size = 0;
char *s_word;
void setup() { 
  pinMode(13, OUTPUT);  //we'll use the debug LED to output a heartbeat

  lcd.begin(16,2);
  randomSeed(analogRead(0));
  Serial.begin(9600);
  lcd.print("ping");
  pinMode(statusLed,OUTPUT);
  pinMode(buzzer,OUTPUT);
  pinMode(button1,INPUT);
  pinMode(lcdBacklit,OUTPUT);
  digitalWrite(lcdBacklit,HIGH);
}

void loop(){

  bouncer.update();
  int value = bouncer.read();

  data_load();
  
  //analogWrite(lcdBacklit,15);
  if(value == HIGH){
    Serial.print('ping');
    lcd.clear();
    int segment = TrueRandom.random(0,7);
    digitalWrite(statusLed,HIGH);
    digitalWrite(buzzer,HIGH);

    generator.get_segment(segment);

    free(s_word);
    *s_word = NULL;
    s_word = generator.word_select();

    int s_start = generator.get_word_begin();
    int s_end = generator.get_word_end();
        
    int l_cursor = 0;
        
    for(int i = s_start+1;i<s_end;i++){
      lcd.setCursor(l_cursor,0);
      char letter = generator.get_storage(i);
      lcd.print(letter);
      Serial.write(letter);
      l_cursor++;
    }
    
    Serial.println(" ");
    
  }else{
    digitalWrite(statusLed,LOW);
    digitalWrite(buzzer,LOW);
  }
}

void data_load(){
  storage_size = 0;
  int value;
  value = Serial.read();

  if(value == 60){
    while(value != 62){
      value = Serial.read();
      Serial.write(value);
      if(value == 62){
        break;
      }
      generator.put_storage(storage_size,value);
      storage_size++;
    }
  }
  generator.put_storage(0,0);  
  for(int i=0;i<storage_size;i++){
    Serial.print(generator.get_storage(i));
  }  
}
