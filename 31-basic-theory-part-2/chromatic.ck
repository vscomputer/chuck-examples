TriOsc osc => dac;

1::second / 30 => dur frame;

48 => int offset;
for(0 => int i; i <= 12; i++)
{
    offset + i => Std.mtof => osc.freq;
    <<< i >>>;
    10::frame => now;
}