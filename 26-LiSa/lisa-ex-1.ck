SinOsc osc => ADSR env => NRev rev => dac;
rev => LiSa lisa => dac;
lisa => Delay delay[2] => dac;

0.5::second => dur beat;

beat => delay[0].max => delay[1].max;
30::ms => delay[0].delay;
40::ms => delay[1].delay;

880 => osc.freq;
0.25 => osc.gain;

(1::ms, 5::ms, 0, 1::ms) => env.set;

0.2 => rev.mix;

4::beat => lisa.duration;

1 => lisa.record;
1 => env.keyOn;
4::beat => now;
0 => lisa.record;
1 => lisa.play;
while(true)
{
    0::beat => lisa.playPos;
    [0.25, 0.5, 1.0, 1.5, 2.0] @=> float rates[];
    rates[Math.random2(0,4)] => lisa.rate;
    0.25::beat => now;
}

