#include <LCD4Bit_mod.h> 
#include <EEPROM.h>
#include <Button.h>

LCD4Bit_mod lcd = LCD4Bit_mod(2); 
Button button = Button(2,PULLDOWN);

long randno;
int EEPROM_SIZE = 512;
int SIZE = 0;

void setup() { 
  pinMode(13, OUTPUT);  //we'll use the debug LED to output a heartbeat

  lcd.init();
  lcd.clear();
  randomSeed(analogRead(0));
  Serial.begin(9600);
  init_word();
}

void loop(){
  lcd.clear();
  char words;
  if(button.isPressed()){
	digitalWrite(13,HIGH);
        digitalWrite(10,HIGH);
        randno = random(SIZE);
        words = get_char(randno);
        Serial.println(randno);
        print_clear();
        get_word(randno);
        delay(500);
  }else{
	digitalWrite(13,LOW);
        digitalWrite(10,LOW);
  }
}

void load_word(int c){
  if(SIZE > EEPROM_SIZE){
    SIZE = EEPROM_SIZE;
  }
  EEPROM.write(SIZE,c);
  SIZE++;
  
}

void print_clear(){
 lcd.clear();  
}

void print_word(char *c,int pos){
  //Just so we can abstract out lcd
  lcd.cursorTo(1,pos);
  lcd.printIn(c);
}

int seek_delimiter(int pos){
  int new_pos = 0;
  char *check;
  char c;
  int input;
  int i = pos;
  //Serial.println("Y");
  while(1){
    if(i > SIZE){
      i = 0;
    }
    c = get_char(i);
    *check = c;
    if(strcmp(check,":")==0){
      new_pos = i + 1;
      break;
    }
    
    i++;
  }
  return new_pos;
}

char get_char(int pos){
  int letter = EEPROM.read(pos);
  return (char)letter;
}

void get_word(int pos){
  pos = seek_delimiter(pos);
  
  int i = 0;
  char *check;
  char c;
  while(1){
    c = get_char(pos);
    *check = c;
    if(strcmp(check,":")==0){
      
      break;
    }
    //Serial.println(check);
    print_word(&c,i);
    i++;
    pos++;
  }
}

void init_word(){
  char words[100] = "I:am:happy:sad:you:are:very:not";
  for(int i=0;i<100;i++){
    load_word((int)words[i]);
  }
}
