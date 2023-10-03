SndBuf2 drumBreak; 
drumBreak.chan(0) => Dyno dyno => Gain gain => Dyno limiter => dac.left => WvOut2 waveOut => blackhole;
drumBreak.chan(1) => Dyno dyno2 => Gain gain2 => Dyno limiter2 => dac.right; //=> WvOut2 waveOut => blackhole;
me.dir() + "shortBreak2.wav" => drumBreak.read;
"compressBreak.wav" => waveOut.wavFilename;

<<< drumBreak.channels() >>>;

30 => dyno.ratio => dyno2.ratio;
0::ms => dyno.attackTime => dyno2.attackTime;
0.05 => dyno.thresh => dyno2.thresh;

24 => gain.gain => gain2.gain;

0.9 => limiter.thresh => limiter2.thresh;
0::ms => limiter.attackTime => limiter2.attackTime;

while(true)
{
    -1 => dyno.op => dyno2.op;
    -1 => gain.op => gain2.op;

    0 => drumBreak.pos;
    2::second => now;
    0 => drumBreak.pos;
    2::second => now;

    1 => dyno.op => dyno2.op;
    1 => gain.op => gain2.op;

    0 => drumBreak.pos;
    2::second => now;
    0 => drumBreak.pos;
    2::second => now;
}

waveOut.closeFile();