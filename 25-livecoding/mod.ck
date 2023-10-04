SinOsc osc => dac;

0.5 => osc.gain;

while(true)
{
    for(0 => int i; i < 16; i++)
    {
        Std.mtof(48 + ((i % 4) * 12)) => osc.freq;
        .25::second => now;
    }
    
    
}
