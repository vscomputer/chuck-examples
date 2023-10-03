public class SynthSaw extends SawOsc
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

SynthSaw osc => LPF lpf => dac;

200 => lpf.freq;

-1 => lpf.op;



0.2 => osc.gain;
osc.setLfo(8, 5);

while (true)
{
    -1 => osc.lfo.op;
    48 => osc.offset;
    [0,4,7,11] @=> int notes[];
    for(0 => int i; i < notes.cap(); i++)
    {
        notes[i] => osc.note;
        1::second / 4 => now;
    }

    1 => osc.lfo.op;
    12 +=> osc.offset;
    for(0 => int i; i < notes.cap(); i++)
    {
        i * 10 => osc.lfo.gain;
        notes[i] => osc.note;
        1::second / 4 => now;
    }
}