<<< "Filters" >>>;

SqrOsc osc => LPF filter => dac => WvOut waveOut => blackhole;

"filters.wav" => waveOut.wavFilename;

0 => filter.freq;
110 => osc.freq;
6 => filter.Q;
0.1 => osc.gain;
<<< "Hit Ctrl-C to stop if you're on a command line :)" >>>;
while(true)
{
    for(2000 => int i; i >0; i--)
    {
        i => filter.freq;
        0.1::ms => now;
    }
}