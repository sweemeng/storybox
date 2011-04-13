#include "WProgram.h"
#include "WordStorage.h"

WordStorage::WordStorage(){

}

char WordStorage::read(int pos){
  int letter = EEPROM.read(pos);
  return (char) letter;
}

void WordStorage::write(int pos,int data){
  EEPROM.write(pos,data);
}

int WordStorage::read_int(int pos){
  int letter = EEPROM.read(pos);
  return letter;
}

byte WordStorage::read_byte(int pos){
  int letter = EEPROM.read(pos);
  return byte(letter);

}
