SinOsc osc => ADSR env => NRev rev => dac;
rev => LiSa lisa => dac;

0.5::second => dur beat;
4::beat => lisa.duration;

(1::ms, 5::ms, 0, 1::ms) => env.set;

880 => osc.freq;
0.25 => osc.gain;

0.2 => rev.mix;

1 => lisa.record;
1 => env.keyOn;
4::beat => now;
0 => lisa.record;
1 => lisa.play;
1 => lisa.bi;
8::beat => now;