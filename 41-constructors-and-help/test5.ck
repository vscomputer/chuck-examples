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

    fun @construct(float oscFreq, Osc osc)
    {
        osc => LPF lpf => Gain g(.25) => outlet;
        oscFreq => osc.freq;
        3000 => lpf.freq;
    }
}

FilteredOsc osc(110, new SawOsc) => dac;
FilteredOsc osc2(165, new SqrOsc) => dac;

1::second => now;