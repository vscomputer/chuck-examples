class MyOsc extends Chugraph 
{
    //set up graph
    SawOsc osc => LPF lpf => Dyno limiter => outlet;
    SawOsc osc2 => lpf;
    Noise noise => lpf;

    //set initial values
    0.2 => osc.gain => osc2.gain;
    0 => noise.gain;
    400 => lpf.freq;
    0::second => limiter.attackTime;
    48 => int offset;
    7 => int osc2Offset;
    
    //make helper functions
    fun void note(float noteNumber)
    {
        Std.mtof(noteNumber + offset) => osc.freq;
        Std.mtof(noteNumber + offset + osc2Offset) => osc2.freq;
    }

    fun void SetOsc2(int newOffset)
    {
        newOffset => osc2Offset;
    }

}

class HPFDelay extends Chugraph
{
    //set up sub graph
    inlet => HPF hpf => Delay delay => outlet;
    hpf => outlet;

    //default values
    800 => hpf.freq;
    1::second => delay.max;
    0.5 => delay.gain;
    0.5::second => delay.delay;
    delay => delay;

    //helper functions
}

HPFDelay hpfdelay[2];
Gain gain;
<<< gain.channels() >>>;

MyOsc osc => hpfdelay => dac;
0.25::second => hpfdelay[1].delay.delay;

1 => hpfdelay[0].op => hpfdelay[1].op;

0.5 => osc.gain;
7 => osc.SetOsc2;
600 => osc.lpf.freq;

[0,3,7,12,15,19,-12,-9] @=> int notes[];

while(true)
{
    Math.random2(0, notes.cap() - 1) => int note;
    notes[note] => osc.note;
    1::second / 4 => now;
}


