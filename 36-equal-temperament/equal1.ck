SinOsc osc1 => dac;

0.5 => osc1.gain;
100 => osc1.freq;

<<< 0, osc1.freq() >>>;
2::second => now;


for(1 => int i; i < 13; i++)
{
    osc1.freq() * 1.5  => osc1.freq;
    <<< i , osc1.freq() >>>;
    i++;
    2::second => now;
    (osc1.freq() / 2) * 1.5  => osc1.freq;
    <<< i , osc1.freq() >>>;    
    2::second => now;
}