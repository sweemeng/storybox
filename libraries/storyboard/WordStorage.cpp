#include "WProgram.h"
#include "WordStorage.h"

WordStorage::WordStorage(){
    this->deviceaddress = 0x50;
    Wire.begin();
}

char WordStorage::read(unsigned int eeaddress){
    byte rdata = this->read_byte(eeaddress);
    return (char) rdata;
}

void WordStorage::write(unsigned int eeaddress,int data){
    byte rdata = byte(data);
    Wire.beginTransmission(this->deviceaddress);
    Wire.send((int)(eeaddress >> 8)); // MSB
    Wire.send((int)(eeaddress & 0xFF)); // LSB
    Wire.send(rdata);
    Wire.endTransmission();
    delay(20);
}

int WordStorage::read_int(unsigned int eeaddress){
    byte rdata = this->read_byte(eeaddress);
    return (int)rdata;
}

byte WordStorage::read_byte(unsigned int eeaddress){
    byte rdata = 0xFF;
    Wire.beginTransmission(this->deviceaddress);
    Wire.send((int)(eeaddress >> 8)); // MSB
    Wire.send((int)(eeaddress & 0xFF)); // LSB
    Wire.endTransmission();
    Wire.requestFrom(this->deviceaddress,1);
    if (Wire.available()){
        rdata = Wire.receive();
    }
    return rdata;

}
