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

    fun @construct(float oscFreq, float lpfFreq, float lpfQ)
    {
        SawOsc osc(oscFreq) => LPF lpf => Gain g(.25) => outlet;
        lpfFreq => lpf.freq;
        lpfQ => lpf.Q;
    }
}

FilteredOsc osc(110, 4400, 4 ) => dac;
FilteredOsc osc2(137.5, 880, 0.6) => dac;
FilteredOsc osc3(165, 1000, 2) => dac;

1::second => now;
osc3.help();