SinOsc mod1 => ADSR env1 =>
SinOsc carrier => ADSR env2 => NRev revM =>
dac =>
WvOut2 wave => 
blackhole;

env2 => Delay d1 => NRev revL => dac.left;
d1 => Delay d2 => NRev revR => dac.right;
d2 => d1;

2::second => d2.max => d1.max;

1::second => d1.delay;
1::second => d2.delay;

0.5 => d1.gain => d2.gain;
0.4 => revL.mix => revR.mix;
0.2 => revM.mix;

"test.wav" => wave.wavFilename;
2 => carrier.sync;
0.4 => carrier.gain;

220 => carrier.freq;
211 => mod1.freq;

500 => mod1.gain;


(1::ms, 2.9::second, 0, 1::ms) => env1.set; 
(1::ms, 3::second, 0, 1::ms) => env2.set;
1 => env1.keyOn => env2.keyOn;
4::second => now;

1 => env1.keyOn => env2.keyOn;
4::second => now;

110 => carrier.freq;

1 => env1.keyOn => env2.keyOn;
4::second => now;

105.5 => mod1.freq;
55 => carrier.freq;
0.3 => carrier.gain;

1 => env1.keyOn => env2.keyOn;
10::second => now;