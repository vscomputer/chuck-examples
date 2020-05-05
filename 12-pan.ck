<<< "Panning and Randomization" >>>;

SinOsc osc => ADSR env1 => dac;

0.25::second => dur beat;
(1::ms, beat/8, 0, 1::ms) => env1.set;
0.25 => osc.gain;

[0,4,7] @=> int major[];
[0,3,7] @=> int minor[];

60 => int offset;
int position;

for(0 => int i; i < 4; i++)
{
    for(0 => int j; j < minor.cap(); j++)
    {
        Std.mtof(minor[0] + offset + position) => osc.freq;
        1 => env1.keyOn;
        beat => now;
    }
}

