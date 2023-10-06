PulseOsc osc => LPF lpf => ADSR env1 => dac => WvOut2 waveOut => blackhole;

TriOsc LFO => blackhole;
-1 => lpf.op;

env1 => Delay delay[2]  => dac;

1500 => lpf.freq;

4::second => delay[0].max => delay[1].max;

"pulse-test-2.wav" => waveOut.wavFilename;

110 => osc.freq;

0.25 => osc.gain;
.1 => osc.width;

0.5::second => dur beat;
1::beat => delay[0].delay;
2::beat => delay[1].delay;
delay[0] => delay[1] => delay [0];
.75 => delay[0].gain => delay[1].gain;

[0,3,7,10,14] @=> int chord[];

36 => int offset;

0.40 => LFO.gain;
1 => LFO.freq;


fun void processLfo()
    {        
        while(true)
        {
            (LFO.last()) + 0.5 => osc.width;            
            1::ms => now;
        }
    }
    spork ~ processLfo();

    (2::beat,100::ms, 0.5, 1::beat) => env1.set;

while(true)
{
    Math.random2(0,3) * 12 => int octave;
    Math.random2(0,chord.cap()-1) => int note;
    Math.random2f(10.0,100.0); 
    octave + chord[note] + offset => Std.mtof => osc.freq;        
    <<< osc.width() >>>;
    1 => env1.keyOn;
    2::beat => now;
    1 => env1.keyOff;
    2::beat => now;
}