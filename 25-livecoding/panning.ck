//<<< "Panning and Randomization" >>>;

SinOsc osc => ADSR env1 => NRev rev => Pan2 pan => dac;

0.05 => rev.mix;

-1.0 => pan.pan;

0.5::second => dur beat;
beat - (now % beat) => now;
//T - (now % T) => now;
( 1::ms , beat/8, 0, 1::ms) => env1.set;
0.1 => osc.gain;

[0,4,7, 11] @=> int major[];
[0,3,7] @=> int minor[];

48 => int offset;
int position;

// <<< "TriOsc channels: ", osc.channels()>>>;
// <<< "ADSR channels: ",   env1.channels()>>>;
// <<< "Reverb channels: ", rev.channels()>>>;
// <<< "Pan channels: ",    pan.channels()>>>;
// <<< "DAC channels",      dac.channels()>>>;

while(true)
{
    for(-1.0 => float j; j < 1.0; 0.1 +=> j)
    {
        beat / Math.random2(1, 16) => env1.decayTime;
        Math.random2(0,3) * 12 => position;
        Math.random2f(-1.0, 1.0) => float panValue;
        Math.random2(0, major.cap() -1) => int note;
        panValue => pan.pan;
        //<<< "pan:", panValue >>>;
        Std.mtof(major[note] + offset + position) => osc.freq;
        1 => env1.keyOn;
        beat / 2 => now;
    }
}
4::beat => now;

