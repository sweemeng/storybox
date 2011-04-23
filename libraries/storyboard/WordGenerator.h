#ifndef WORDGENERATOR_H
#define WORDGENERATOR_H
#define LOOKUP_SIZE 20

#include "WProgram.h"
#include "WordStorage.h"
#include <TrueRandom.h>

class WordGenerator{
    public:
        WordGenerator(int);
        int byte_to_int(byte *);
        void get_segment(int);
        int get_delimiter(int);
        char *word_select();
        int get_segment_begin();
        int get_segment_end();
        void put_storage(int,int);
        char get_storage(int);
    private:
        int begin;
        int end;
        int segment_begin;
        int segment_end;
        WordStorage storage;
        char *words;
        int lookup_segment;
};

#endif
