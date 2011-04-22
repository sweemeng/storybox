#include "WProgram.h"
#include "WordStorage.h"
#include "WordGenerator.h"

WordGenerator::WordGenerator(int segment_no){
   this->lookup_segment = segment_no * 4;
}

int WordGenerator::byte_to_int(byte *header){
    int result = 0;
    result += (int)header[0] * 1000;
    result += (int)header[1] * 100;
    result += (int)header[2] * 10;
    result += (int)header[3];
    return result;
}

void WordGenerator::get_segment(int pos){
    int begin = 0 + (4 * pos);
    int mid = begin + 4;
    int end = mid + 4;
    byte s_start[4];
    byte s_end[4];
    if(begin == this->lookup_segment || mid == this->lookup_segment){
        begin = 0;
        mid = begin + 4;
        end = mid + 4;
    }
    int count = 0;
    for(int i = begin;i<mid;i++){
        s_start[count] = storage.read(i);
        count++;
   }
   count = 0;
   for(int i = mid;i<end;i++){
       s_end[count] = storage.read(i);
       count++;
   }
   this->segment_begin = this->byte_to_int(s_start);
   this->segment_end = this->byte_to_int(s_end);
}

int WordGenerator::get_delimiter(int pos){
    int p = pos;
    char check;
    char delimiter = ':';
    if(p == this->segment_end){
        return p;
    }
    if(p == this->segment_begin){
       p = p + 1;
    }
    check = this->storage.read(p);
    //Serial.println(p);
    //Serial.println(delimiter);
    while(check != ':'){
        if(p > this->segment_end){
            p = this->begin + 1;
        }
        p++;
        check = this->storage.read(p);
    }
    //Serial.println(check);
    return p;
}

void WordGenerator::word_select(char *word_selected){
    free(word_selected);
    int word_start = TrueRandom.random(this->segment_begin,this->segment_end);
    word_start = this->get_delimiter(word_start);
    if(word_start == this->segment_end){
        word_start = this->segment_begin;
    }
    
    this->begin = word_start;
    int word_end = this->get_delimiter(word_start+1);
    //Serial.println(this->storage.read(word_start));
    //Serial.println(this->storage.read(word_end));
    word_start = word_start + 1;
    word_end = word_end;
    this->end = word_end;
    int word_size = word_end - word_start;
    //Serial.println(word_size);
    char *s_word;
    s_word = (char *)malloc(word_size * sizeof(char));
    for(int i = word_start;i < word_end;i++){
        *s_word = storage.read(i);
        //Serial.println(*s_word);
        s_word++;
        //delay(500);
    }
    word_selected = s_word;
    Serial.println(word_selected);
}

int WordGenerator::get_segment_begin(){
    return this->segment_begin;
}

int WordGenerator::get_segment_end(){
    return this->segment_end;
}

void WordGenerator::put_storage(int pos,int data){
    this->storage.write(pos,data);
}

char WordGenerator::get_storage(int pos){
    return this->storage.read(pos);
}
