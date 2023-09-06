<<< "kick-snare.ck" >>>;

SinOsc kick => ADSR kickEnv => dac;
Noise snare => BPF snareFilter => ADSR snareEnv => dac;
Impulse imp => dac;


0.5::second => dur beat;

60 => kick.freq;
0.2 => kick.gain;
(1::ms, beat /2, 0,1::ms ) => kickEnv.set;

function void kickPitch()
{
    for(160 => int i; i > 55; i--)
    {
        i => kick.freq;
        1::ms => now;
    }
}

function void PlayKick()
{
while (true)
    {
        55 => kick.freq;
        1 => kickEnv.keyOn;
        spork ~ kickPitch();
        0.2 => imp.next;
        beat => now;
    }
}

0.5 => snare.gain;
1750 => snareFilter.freq;
1 => snareFilter.Q;
(1::ms, beat /4, 0.05, 1::ms) => snareEnv.set;

function void PlaySnare()
{
    while(true)
    {
        beat => now;
        1 => snareEnv.keyOn;
        beat  => now;
        1 => snareEnv.keyOff;        
    }
}

spork ~ PlayKick();
spork ~ PlaySnare();

while(true)
{
    beat => now;
}

