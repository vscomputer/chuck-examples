SinOsc osc => dac;
0.25 => osc.gain;

[60,62,64,65,67,69,71,72] @=> int pitches[];

while(true)
{
    for(0 => int i; i < pitches.cap(); i++)
    {
        Std.mtof(pitches[i]) => osc.freq;
        200::ms => now;
    }
}