SinOsc osc1 => dac;

0.5 => osc1.gain;
100 => osc1.freq;

<<< 0, osc1.freq() >>>;
1::second => now;

1.0594630943592952645618252949463 => float semitone;

for(1 => int i; i < 13; i++)
{
    osc1.freq() * semitone => osc1.freq;
    <<< i, osc1.freq() >>>;
    1::second => now;
}

