SinOsc osc1 => ADSR env1 => NRev rev3 => dac;
rev3 => Delay del1 => NRev rev1 => dac.left;
rev3 => Delay del2 => NRev rev2 => dac.right;
del1 => del2;
del2 => del1;
1::second / 2 => dur beat;
(1::ms, beat/8, 0, 1::ms) => env1.set;

0.5 => del1.gain;
0.5 => del2.gain;

beat => del1.max => del2.max;
beat /4 => del1.delay;
beat /2 => del2.delay;
0.2  => rev1.mix => rev2.mix => rev3.mix;

48 => int offset;
int position;
[0,4,7] @=> int major[];
[0,3,7] @=> int minor[];
0.15 => osc1.gain;
[0,12,24] @=> int positions[];


while(true)
{
    for(0 => int i; i < 3; i++)
    {
        for(0 => int j; j < minor.cap(); j++)
        {
            Std.mtof(minor[Math.random2(0,2)] + offset + positions[Math.random2(0,2)]) => osc1.freq;            
            1 => env1.keyOn;
            beat  => now;
        }
        
    }
}
8 * beat => now;