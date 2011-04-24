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
char *s_word;
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

  bouncer.update();
  int value = bouncer.read();
  lcd.clear();
  data_load();
  if(value == HIGH){
        int segment = TrueRandom.random(0,7);
	digitalWrite(statusLed,HIGH);
        digitalWrite(buzzer,HIGH);
        generator.get_segment(0);
        free(s_word);
        *s_word = NULL;
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
  int value;
  value = Serial.read();
  //Serial.write(value);
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
  if(storage_size > 0){
    Serial.println(" ");
    for(int i=0;i<storage_size;i++){
      Serial.print((char)generator.get_storage(i));
    }
  }

}
