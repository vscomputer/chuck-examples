TriOsc osc => ADSR env1 => dac;
TriOsc osc2 => ADSR env2 => dac;

1::second => dur beat;
(beat /2, beat /2, 0, 1::ms) => env1.set;
(1::ms, beat / 8, 0, 1::ms) => env2.set;

0.2 => osc.gain;
0.1 => osc2.gain;

[0,4,7,12] @=> int major[];
[0,3,7,12] @=> int minor[];

48 => int offset;
int position;

fun void playTwoBars(int position, int chord[])
{
    for(0 => int i; i < 4; i++)
    {
        Std.mtof(chord[0] + offset + position) => osc.freq;
        1 => env1.keyOn;
        for(0 => int j; j < 4; j++)
        {
            Std.mtof(chord[j] + offset + position + 12) => osc2.freq;
            1 => env2.keyOn;
            beat / 8 => now;
        }
    }
}

while(true)
{
    playTwoBars(0, minor);
    playTwoBars(-4, major);
    playTwoBars(-2, major);
    playTwoBars(-5, major);
    
    playTwoBars(-7, minor);
    playTwoBars(-2, major);
    playTwoBars(3, major);
    playTwoBars(-5, major);  
}

