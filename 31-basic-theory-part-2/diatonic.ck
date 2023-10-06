TriOsc osc => dac;

1::second / 30 => dur frame;

[0,2,4,5,7,9,11,12] @=> int major[];

48 => int offset;
for(0 => int i; i < major.cap(); i++)
{
    offset + major[i] => Std.mtof => osc.freq;
    <<< major[i] >>>;
    10::frame => now;
}