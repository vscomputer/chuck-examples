<<< "bass2.ck" >>>;

SqrOsc osc1 => BPF filter1 => ADSR env1 => dac;
env1 => Delay leftDelay => dac.left;
Delay rightDelay => dac.right;

0.5::second => dur beat;
beat / 4 => dur sixteenth;

beat => leftDelay.max => rightDelay.max;
leftDelay => rightDelay;
rightDelay => leftDelay;
beat /2 => leftDelay.delay => rightDelay.delay;
0.35 => leftDelay.gain => rightDelay.gain;


36 => int offset;




0.2 => osc1.gain;
2000 => filter1.freq;
6 => filter1.Q;
(1::ms, beat , 0, 1::ms) => env1.set;

function void PlayBassFigure(int position)
{
    Std.mtof(offset + position) => osc1.freq;
    1 => env1.keyOn;
    sixteenth * 3 => now;
    1 => env1.keyOn;
    sixteenth * 3 => now;
    1 => env1.keyOn;
    sixteenth * 2 => now;
    Std.mtof(offset + position + 12) => osc1.freq;
    1 => env1.keyOn;
    sixteenth * 3 => now;
    1 => env1.keyOn;
    sixteenth * 3 => now;
    1 => env1.keyOn;
    Std.mtof(offset + position) => osc1.freq;
    sixteenth * 2 => now;
}
spork ~ SweepFilter();

function void SweepFilter()
{
    while(true)
    {
        for(2500 => int i; i> 800; i--)
        {
            i => filter1.freq;
            1::ms => now;
        }
        for(800 => int i; i< 2500; i++)
        {
            i => filter1.freq;
            1::ms => now;
        }
    }
}

while(true)
{
    PlayBassFigure(0);
    PlayBassFigure(0);
    PlayBassFigure(8);
    PlayBassFigure(5);
}