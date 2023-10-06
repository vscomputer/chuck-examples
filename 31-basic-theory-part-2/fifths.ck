TriOsc osc => dac;
TriOsc osc2 => dac;
dac => WvOut outFile => blackhole;

"fifths-example.wav" => outFile.wavFilename;

0.5 => osc.gain => osc2.gain;

1::second / 30 => dur frame;

[0,2,4,5,7,9,11,12,14,16,17,19] @=> int major[];

60 => int offset;
for(0 => int i; i < 7; i++)
{
    offset + major[i] => Std.mtof => osc.freq;
    offset + major[i + 4]  => Std.mtof => osc2.freq;
    <<< major[i], major[i + 4] >>>;
    20::frame => now;
}
30::frame => now;