OscOut oscOut;

oscOut.dest("localhost", 9000);

[-12,0,3,7,10,12,14] @=> int notes[];

while(true)
{
    oscOut.start("/myOsc/Hello");
    notes[Math.random2(0, notes.cap()-1)] + 60 => int note;
    note => oscOut.add;

    oscOut.send();
    150::ms => now;
}