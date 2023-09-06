<<< "Filters and Shreds" >>>;

SqrOsc osc1 => ADSR env1 => BPF filter => dac;
SawOsc osc2 => env1 => filter => dac;
filter => Delay d1 => dac.right;
filter => Delay d2 => dac.left;

0.6::second => dur beat;

//set delay timing
2::second => d1.max => d2.max;
beat /2 => d1.delay;
beat => d2.delay;
0.75 => d1.gain => d2.gain;
d1 => d2;
d2 => d1;

//set pitch collection
[0,7,12,16,19,24, 5, 28, 31] @=> int pitches[];
36 => int offset;

//set default for envelope and filter
(1::ms, beat * 4, 0, 1::ms) => env1.set;
10000 => filter.freq;
8 => filter.Q;
0.025 => osc1.gain => osc2.gain;

spork ~ SweepFilter();
//play some random stuff
while(true)
{
    pitches[Math.random2(0,pitches.cap() -1)] => int randomPitch;
    Std.mtof(randomPitch + offset) => osc1.freq;
    Std.mtof(randomPitch + offset + 7) => osc2.freq;
    1 => env1.keyOn;

    beat / 3 => now;
}



fun void SweepFilter()
{
    while(true)
    {
        for(3000 => int i; i > 250; i--)
        {
            i => filter.freq;
            0.5::ms => now;            
        }        
        for(250 => int j; j < 3000; j++)
        {
            j => filter.freq;
            0.5::ms => now;            
        }
    }
}