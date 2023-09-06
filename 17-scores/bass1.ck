<<< "bass1.ck" >>>;

SqrOsc osc1 => LPF filter1 => ADSR env1 => dac;

36 => int offset;
0.5::second => dur beat;

beat / 4 => dur sixteenth;

0.1 => osc1.gain;
1000 => filter1.freq;
(1::ms, beat /4, 0, 1::ms) => env1.set;

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

while(true)
{
    PlayBassFigure(0);
    PlayBassFigure(0);
    PlayBassFigure(8);
    PlayBassFigure(5);
}