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
