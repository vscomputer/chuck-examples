PulseOsc osc => dac => WvOut2 waveOut => blackhole;

0.5 => osc.gain;
48 => int offset;

[0,4,7,12] @=> int notes[];
[.50,.40,.30,.20,.10] @=> float widths[];

for(0 => int w; w<widths.cap(); w++)
{
    for(0 => int i; i<4; i++)
    {
        for(0 => int j; j<notes.cap(); j++ )
        {
            widths[w] => osc.width;
            notes[j] + offset + i => Std.mtof => osc.freq;
            150::ms => now;
        }
    }
}