Moog osc => Delay delay[2] => dac;

1::second => delay[0].max => delay[1].max;
0.5 => delay[0].gain => delay[1].gain;
0.5::second => delay[0].delay;
0.25::second => delay[1].delay;
osc => dac;

0.25 => osc.gain;
220 => osc.freq;

0 => osc.filterQ;

48 => int offset;
[0,4,7,11] @=> int notes[];
while(true)
{
    for(0 => int i; i < notes.cap(); i++)
    {
        Std.mtof(offset + notes[i]) => osc.freq;
        1 => osc.noteOn;
        1::second / 4 => now;
    }
}