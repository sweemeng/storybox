import serial

word_list = [
                ['rock','stone','brick','sand'],
                ['sea','river','lake','waterfall'],
                ['boat','ship','raft','submarine'],
                ['me','you','I','he','she'],
                ['on','in','out','inside','outside'],
                ['the','a','that','this'],
                ['eating','sleeping','walking']
            ]

def build_data():
    header = ''
    body = ':'
    size = 28
    for i in word_list:
        tmp = ':'.join(i)
        body = body + tmp + ':'
        t_size = size + len(body)
        print t_size
        b = int_to_byte(t_size)
        header = header + b
    return (header,body)       
 
def send_data(data):
    tmp = '<'+data+'>'
    s = serial.Serial('/dev/ttyUSB0',9600)
    for i in tmp:
        s.write(i)
        v = s.read()
        if i != v: 
            if(ord(v) in range(0,10)):
                if(ord(i) in range(0,10)):
                    print '%s:%s' % (str(ord(i)),str(ord(v)))
                else:
                    print '%s:%s' % (i,str(ord(v)))
            else:
                print '%s:%s' % (i,v)
    s.close()


def int_to_byte(val):
    t = ''
    v = val
    while v:
        r = v % 10
        t = chr(r) + t
        v = int(v/10)
    while len(t) < 4:
        t = '\x00' + t
    return t
    
def run():
    t = build_data()
    send_data(t[0]+t[1])

def byte_to_int(val):
    tn = 1000
    t = 0
    for i in val:
        t = ord(i) * tn + t
        tn = tn / 10
    return t
