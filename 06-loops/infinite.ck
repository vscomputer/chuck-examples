SinOsc osc => dac;

0.5 => osc.gain;

while(true)
{
    440 => osc.freq;
    50::ms => now;
    660 => osc.freq;
    50::ms => now;
    880 => osc.freq;
    50::ms => now;
}