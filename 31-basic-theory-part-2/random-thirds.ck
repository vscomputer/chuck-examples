SinOsc osc => Delay delay[2];
SinOsc osc2 => delay;
delay => dac => WvOut2 outFile => blackhole;
osc => dac;
osc2 => dac;


2::second => delay[0].max => delay[1].max;

"random-thirds.wav" => outFile.wavFilename;

0.25 => osc.gain => osc2.gain; 
0.5 => delay[0].gain => delay[1].gain;

1::second / 60 => dur frame;

10::frame => delay[0].delay;
20::frame => delay[1].delay;

delay[0] => delay[1];

[0,2,4,5,7,9,11,12,14,16,17,19] @=> int major[];

60 => int offset;
while(true)
{
    Math.random2(0,8) => int i;
    offset + major[i] => Std.mtof => osc.freq;
    offset + major[i + 2]  => Std.mtof => osc2.freq;
    <<< major[i], major[i + 2] >>>;
    20::frame => now;
}
