<<< "Panning and Randomization" >>>;

SinOsc osc => ADSR env1 => NRev rev => Pan2 pan => dac;
env1 => Delay delay => rev;
0.02 => rev.mix;
0.5::second => dur beat;
(1::ms, beat/4, 0, 1::ms) => env1.set;
0.25 => osc.gain;
beat => delay.max;
beat /4 => delay.delay;
0.5 => delay.gain;
delay => delay;

[0,4,7] @=> int major[];
[0,3,7] @=> int minor[];

48 => int offset;
int position;

while(true){
    for(0 => int i; i < 4; i++)
    {
        for(-1 => float j; j <= 1; 0.1 + j => j)
        {
            Math.random2(0,4) * 12 => position;
            Math.random2f(-1,1) => float panValue;
            panValue => pan.pan;
            
            Math.random2(0,2) => int note;
            beat/Math.random2(2,16) => env1.decayTime;         
            
            Std.mtof(minor[note] + offset + position) => osc.freq;
            1 => env1.keyOn;
            beat / 2 => now;            
        }
    }
}
