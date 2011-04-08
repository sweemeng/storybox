import serial

class DataLoader:
    def __init__(self):
        self.header = ''
        self.words = {}
        self.s = serial.Serial(2)
        self.data = ''
    
    def create_category(category):
        self.words[category] = []
    
    def add_word(category,word):
        self.words[category].append(word)
    
    def write(self):
        to_write = self.header + self.data
        for i in to write:
            s.write(i)
    
    def prepare(self):
        for i in words:
            temp = ':'.join(words[i])
            length = len(temp)
            b = int_to_byte(length)
            self.header = self.header + b
            self.data = self.data + temp
        
    def int_to_byte(self,no):
        pass
    
   
    
