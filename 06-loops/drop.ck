SinOsc osc => dac;
0.5 => osc.gain;

for( 1000 => int i; i > 0; i--)
{
    i => osc.freq;
    <<< i >>>;
    4::ms => now;
}