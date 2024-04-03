class FilteredOsc extends Chugraph
{
    fun @construct()
    {
        SawOsc osc(440) => LPF lpf => Gain g(.25) => outlet;
        3000 => lpf.freq;
    }
}

FilteredOsc osc => dac;

1::second => now;