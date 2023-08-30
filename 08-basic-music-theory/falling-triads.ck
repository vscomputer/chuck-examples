TriOsc osc =>  dac;

0.5 => osc.gain;

[0,4,7] @=> int major[];
[0,3,7] @=> int minor[];

48 => int offset;
int position;

25::ms => dur eighth;
0 => position;

while(true)
{
    
    for(48 => int i; i > 0; i--)
    {
        i => position;
        for(0 => int j; j < 3; j++)
        {
            Std.mtof(major[j] + offset + position) => osc.freq;
            eighth => now;
        }
    }

}