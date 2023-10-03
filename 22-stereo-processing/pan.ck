<<< "Panning and Randomization" >>>;

SinOsc osc => ADSR env1 => Pan2 pan => NRev rev[2] => Dyno limiter[2] => dac;

1 => limiter[0].op => limiter[1].op;
5 => limiter[0].ratio => limiter[1].ratio;
0.2 => limiter[0].thresh => limiter[1].thresh;
0::ms => limiter[0].attackTime => limiter[1].attackTime;
3 => limiter[0].gain => limiter[1].gain;

1 => rev[0].op => rev[1].op;
0.05 => rev[0].mix => rev[1].mix;

0.5::second => dur beat;

1 => env1.op;
(1::ms, beat/4, 0, 1::ms) => env1.set;

0.25 => osc.gain;

[0,4,7] @=> int major[];
[0,3,7] @=> int minor[];

36 => int offset;
int position;

for(0 => int i; i < 4; i++)
{
    for(-1 => float j; j <= 1; 0.1 + j => j)
    {
        Math.random2(0,4) * 12 => position;
        Math.random2f(-1,1) => float panValue;
        panValue => pan.pan;
        
        Math.random2(0,2) => int note;
        beat/Math.random2(2,16) => env1.decayTime;
        <<< "pan:", panValue, "position", position, "note:", note>>>;
        
        
        Std.mtof(minor[note] + offset + position) => osc.freq;
        1 => env1.keyOn;
        beat / 2 => now;
        // 1 => env1.keyOff;
        // beat / 4 => now;
        // 1 => env1.keyOn;
        // beat / 4 => now;              
    }
}

