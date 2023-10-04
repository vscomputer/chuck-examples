class LowpassDelay extends Chugraph
{
    inlet => LPF lpf => Delay delay => outlet;
    500 => lpf.freq;
    1::second => delay.max;
    0.5 => delay.gain;
    1::second / 2 => delay.delay;
    delay => delay;

    lpf => outlet;
}


SawOsc osc => LowpassDelay graph[2] => dac;

0.5 => osc.gain;
220 => osc.freq;

1::second / 4 => graph[1].delay.delay;

48 => int offset;
[0,4,7,11] @=> int notes[];
while(true)
{
    for(0 => int i; i < notes.cap(); i++)
    {
        Std.mtof(offset + notes[i]) => osc.freq;
        1::second / 4 => now;
    }
}