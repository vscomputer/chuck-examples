SinOsc osc => ADSR env => Pan2 pan => NRev rev[2] => dac;

FileIO partFile;
partFile.open( "part.txt", FileIO.WRITE );

0.25 => osc.gain;
(1::ms, 100::ms, 0, 1::ms) => env.set;
0.1 => rev[0].mix => rev[1].mix;

[0,3,7,10,12,14] @=> int notes[];
48 => int offset;
0 => int position;

for(0 => int i; i < 256; i++)
{
    Math.random2(0,2) * 12 => position;

    notes[Math.random2(0, notes.cap()-1)] + offset + position => int note;
    note => Std.mtof => osc.freq;
    Math.random2f(-1.0,1.0) => pan.pan;
    Math.random2(1, 500) => int decay;
    decay::ms => env.decayTime;

    1 => env.keyOn;
    partFile <= note <= " " <= pan.pan() <= " " <= decay <= IO.newline();
    125::ms => now;
}

partFile.close();