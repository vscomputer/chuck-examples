SinOsc osc1 => ADSR env1 => NRev rev1 => dac;

0.5::second => dur beat;

0.15 => osc1.gain;
(1::ms, beat / 4, 0, 1::ms) => env1.set;
0.1 => rev1.mix;

60 => int offset;
0 => int position;

[0,4,7,12] @=> int major[];

while(true)
{
    for(0 => int i; i < major.cap(); i++)
    {
        Std.mtof(major[i] + offset + position) => osc1.freq;
        1 => env1.keyOn;
        beat /4 => now;
    }
}