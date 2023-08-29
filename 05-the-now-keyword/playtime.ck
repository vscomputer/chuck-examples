1::second / 2 => dur beat;

<<< "Start time:", now >>>;

SinOsc osc => dac;

200 => osc.freq;
0.5 => osc.gain;

<<< "Time:", now, "Osc frequency:", osc.freq() >>>;
beat => now;

300 => osc.freq;

<<< "Time:", now, "Osc frequency:", osc.freq() >>>;
beat / 2 => now;

400 => osc.freq;

<<< "Time:", now, "Osc frequency:", osc.freq() >>>;
beat / 2 => now;

<<< "End Time:", now >>>;