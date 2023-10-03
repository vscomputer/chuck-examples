SinOsc osc1 => Dyno dyno => dac => WvOut2 waveOut => blackhole;

"addSines.wav" => waveOut.wavFilename;

0::ms => dyno.attackTime;
0.8 => dyno.thresh;

1.0 => osc1.gain;
220 => osc1.freq;

2::second => now;

SinOsc osc2 => dyno;
.5 => osc2.gain;
110 => osc2.freq;

2::second => now;