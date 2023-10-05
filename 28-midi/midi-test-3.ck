MidiOut gma;
gma.open(2);
MidiMsg msg;

48 => int offset;
[0,4,7,11] @=> int chord[];

fun void PlayGma(int note)
{
    <<< note >>>;
    144 => msg.data1;
    note => msg.data2;
    127 => msg.data3;
    gma.send(msg);
    50::ms => now;
    
    128 => msg.data1;
    note => msg.data2;
    127 => msg.data3;
    gma.send(msg);
    50::ms => now;
}

while(true)
{
    Math.random2(0,3) * 12 => int position;    
    Math.random2(0, chord.cap() -1) => int note;
    PlayGma(chord[note] + position + offset);
}