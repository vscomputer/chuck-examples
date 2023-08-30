TriOsc osc =>  dac;

0.5 => osc.gain;

[0,4,7] @=> int major[];
[0,3,7] @=> int minor[];

48 => int offset;
int position;

150::ms => dur eighth;
0 => position;

while(true)
{
    0 => position;
    for(0 => int i; i < 4; i++)
    {        
        for(0 => int j; j < 3; j++)
        {
            Std.mtof(major[j] + offset + position) => osc.freq;
            eighth => now;
        }
    }

    -3 => position;
    for(0 => int i; i < 4; i++)
    {        
        for(0 => int j; j < 3; j++)
        {
            Std.mtof(minor[j] + offset + position) => osc.freq;
            eighth => now;
        }
    }

    5 => position;
    for(0 => int i; i < 4; i++)
    {        
        for(0 => int j; j < 3; j++)
        {
            Std.mtof(major[j] + offset + position) => osc.freq;
            eighth => now;
        }
    }

    7 => position;
    for(0 => int i; i < 4; i++)
    {        
        for(0 => int j; j < 3; j++)
        {
            Std.mtof(major[j] + offset + position) => osc.freq;
            eighth => now;
        }
    }
}