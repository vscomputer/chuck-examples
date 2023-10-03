public class MusicTri extends TriOsc
{
    48 => int offset;

    SinOsc lfo => this;
    2 => this.sync;
    6 => lfo.freq;
    5 => lfo.gain;

    fun void note(float noteNumber)
    {
        Std.mtof(noteNumber + offset) => this.freq;
    }

    fun void setLfo(float freq, float gain)
    {
        freq => lfo.freq;
        gain => lfo.gain;
    }
};

MusicTri osc => dac;
MusicTri osc2 => Pan2 pan1 => dac;
MusicTri osc3 => Pan2 pan2 => dac;

Delay delay1 => dac.left;
Delay delay2 => dac.right;

1::second => delay1.max => delay2.max;
1::second / 6 => delay1.delay => delay2.delay;
delay1 => delay2;
delay2 => delay1;

0.4 => delay1.gain => delay2.gain;

pan1.left => delay1;
pan2.left => delay1;
pan1.right => delay2;
pan2.right => delay2;


0.2 => osc2.width;
0.7 => osc3.width;

0.2 => osc.gain => osc2.gain => osc3.gain;
osc.setLfo(8, 2);
osc2.setLfo(6, 5);
osc3.setLfo(6, 7);

-0.6 => pan1.pan;
0.6 => pan2.pan;

while (true)
{
    36 => osc.offset;
    48 => osc2.offset;
    60 => osc3.offset;
    [0,4,7,11,14] @=> int notes[];
    notes[Math.random2(0,2)] => osc.note;
    for(0 => int i; i < notes.cap(); i++)
    {
        notes[Math.random2(0,4)] => osc2.note;
        notes[Math.random2(0,4)] => osc3.note;
        1::second / 6 => now;
    }

    // 1 => osc.lfo.op;
    // 12 +=> osc.offset;
    // for(0 => int i; i < notes.cap(); i++)
    // {
    //     i * 10 => osc.lfo.gain;
    //     notes[i] => osc.note;
    //     1::second / 4 => now;
    // }
}