class FilteredOsc extends Chugraph
{
    SawOsc osc(440) => LPF lpf => Gain vca(.25) => outlet;
}

FilteredOsc osc => dac;

1::second => now;