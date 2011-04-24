#ifndef WORDSTORAGE_H
#define WORDSTORAGE_H
#include "WProgram.h"
#include <Wire.h>
 
class WordStorage{
    public:
        WordStorage();
        char read(unsigned int);
        void write(unsigned int,int);
        int read_int(unsigned int);
        byte read_byte(unsigned int);
    private:
        int deviceaddress; 
};

#endif

