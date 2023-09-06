<<< "pad.ck" >>>;

SawOsc osc[3] => LPF filter[3] => ADSR env[3];
env[0] => dac;
env[1] => dac.left;
env[2] => dac.right;

0.5::second => dur beat;
60 => int offset;
2.5 => filter[0].Q => filter[1].Q => filter[2].Q;
for(0 => int i; i < osc.cap(); i++)
{
    0.05 => osc[i].gain;
}

(1::ms, beat /4, 0.05, 1::ms) => env[0].set;
(1::ms, beat /4, 0.05, 1::ms) => env[1].set;
(1::ms, beat /4, 0.05, 1::ms) => env[2].set;

spork ~ SweepFilter();

function void SweepFilter()
{
    while(true)
    {
        for(1000 => int i; i> 300; i--)
        {
            i => filter[0].freq => filter[1].freq => filter[2].freq;
            5::ms => now;
        }
        for(300 => int i; i< 1000; i++)
        {
            i => filter[0].freq => filter[1].freq => filter[2].freq;
            5::ms => now;
        }
    }
}

[[0,2,7],[0,3,7]] @=> int pitches[][];

while(true)
{
    for(0 => int i; i < pitches.cap(); i++)
    {
        for(0 => int j; j <pitches[i].cap();j++)
        {
            Std.mtof(offset + pitches[i][j]) => osc[j].freq;
        }
        for(0 => int k; k < 8; k++)
        {
            1 => env[0].keyOn => env[1].keyOn => env[2].keyOn;
            beat / 2 => now;
        }
    }
}