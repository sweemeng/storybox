#include <LCD4Bit_mod.h> 
#include <Wire.h>

#include <WordStorage.h>
#include <TrueRandom.h>
#include <Bounce.h>
#include <WordGenerator.h>

#define button1 2
#define lcdBacklit 3
#define buzzer 10
#define statusLed 13

LCD4Bit_mod lcd = LCD4Bit_mod(2); 
Bounce bouncer = Bounce(button1,50);

WordGenerator generator(7);
int storage_size = 0;
void setup() { 
  pinMode(13, OUTPUT);  //we'll use the debug LED to output a heartbeat

  lcd.init();
  lcd.clear();
  randomSeed(analogRead(0));
  Serial.begin(9600);

  pinMode(statusLed,OUTPUT);
  pinMode(buzzer,OUTPUT);
  pinMode(button1,INPUT);
  pinMode(lcdBacklit,OUTPUT);
}

void loop(){
  char *s_word;
  bouncer.update();
  int value = bouncer.read();
  lcd.clear();
  data_load();
  analogWrite(lcdBacklit,10);
  if(value == HIGH){
        int segment = TrueRandom.random(0,7);
	digitalWrite(statusLed,HIGH);
        digitalWrite(buzzer,HIGH);
        generator.get_segment(segment);
        s_word = generator.word_select();
        lcd.printIn(s_word);
        Serial.println(s_word);
        delay(500);
        
  }else{
	digitalWrite(statusLed,LOW);
        digitalWrite(buzzer,LOW);
  }
}

void data_load(){
  storage_size = 0;
  while(Serial.available() > 0){
      int value = Serial.read();
      digitalWrite(13,HIGH);
      generator.put_storage(storage_size,value);
      storage_size++;
  } 
}
