SinOsc osc => ADSR adsr => JCRev rev[2] => dac;
rev => Dyno dyno[2] => LiSa lisa => BPF lpf;
-1 => lpf.op;

0::ms => dyno[0].attackTime;
0::ms => dyno[1].attackTime;

0.8 => dyno[0].thresh;
0.8 => dyno[1].thresh;


dac => WvOut waveOut => blackhole;
"lisa1.wav" => waveOut.wavFilename;

1::second => lisa.duration;
1::ms => lisa.recRamp;

lpf => Echo delay[3];
for(0 => int i; i < delay.cap(); i++)
{
    1 => delay[i].op;
    2::second => delay[i].max;
    0.250::second * (i+1) => delay[i].delay;
    0.5 => delay[i].mix;
}

delay[0] => dac.left;
delay[1] => dac;
delay[2] => dac.right;



0.3 => osc.gain;
0.4 => rev[0].mix => rev[1].mix;

( 1::ms, 100::ms, 0, 0::ms) => adsr.set;
[-24,-12,0,3,7,10,12] @=> int notes[];
lisa.record(1);
for(0 => int i; i < notes.cap(); i++)
{
    Std.mtof(notes[i] + 72) => osc.freq;
    1 => adsr.keyOn;
    1::second / 6 => now;
}

//1::second => now;
lisa.record(0);

lisa.play(1);
lisa.loop(1);
lisa.bi(1);
spork ~ FilterLFO();

fun void FilterLFO()
{
    while(true)
    {
        (Math.random2f(50,800), Math.random2f(1.0,8.0)) => lpf.set;        
        0.25::second => now;
    }
}

while(true)
{
    (0, 1) => lisa.rate;
    lisa.play(1);
    for(0 => int i; i<4; i++)
    {
        1::second => now;
    }
    (0, .667) => lisa.rate; 
    lisa.play(1);
    for(0 => int i; i<4; i++)
    {
        1::second => now;
    }
    (0, 1) => lisa.rate;
    lisa.play(1);
    for(0 => int i; i<4; i++)
    {
        1::second => now;
    }
    (0, 1.333) => lisa.rate; 
    lisa.play(1);
    for(0 => int i; i<4; i++)
    {
        1::second => now;
    }
}