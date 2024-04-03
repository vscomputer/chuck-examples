class FilteredOsc extends Chugraph
{
    fun @construct()
    {
        SawOsc osc(440) => LPF lpf => Gain g(.25) => outlet;
        3000 => lpf.freq;
    }

    fun @construct(float oscFreq)
    {
        SawOsc osc(oscFreq) => LPF lpf => Gain g(.25) => outlet;
        3000 => lpf.freq;
    }
}

FilteredOsc osc(220) => dac;
FilteredOsc osc2(137.5) => dac;
FilteredOsc osc3(165) => dac;

1::second => now;