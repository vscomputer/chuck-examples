SinOsc osc => dac;
0.25 => osc.gain;

[ 110, 220, 440, 660, 770, 880, 1320] @=> int frequencies[];

while(true)
{
    for(0 => int i; i < frequencies.cap(); i++)
    {
        frequencies[i] => osc.freq;
        200::ms => now;
    }
}