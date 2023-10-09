OscOut xmit;
6449 => int port;
xmit.dest("192.168.1.67", port); //this was my local IP address, it would be something else on your network
[-12,0,4,7,11,12,14] @=> int notes[];

while(true)
{
    xmit.start("/myChuck/OSCNote");
    notes[Math.random2(0, notes.cap()-1)] + 60 => int note;
    Math.random2f(0.1,1.0) => float velocity;
    "Hello from the other PC!" => string message;

    note => xmit.add;
    velocity => xmit.add;
    message => xmit.add;    

    <<< "sending:", note, velocity, message >>>;

    xmit.send();

    1::second / 2 => now;
}