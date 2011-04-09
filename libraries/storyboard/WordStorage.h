#ifndef WORDSTORAGE_H
#define WORDSTORAGE_H
#include "WProgram.h"
#include <EEPROM.h>
 
class WordStorage{
    public:
        WordStorage();
        char read(int);
        void write(int,int); 
};

#endif

