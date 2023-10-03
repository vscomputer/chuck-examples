SndBuf2 drumBreak => Dyno dyno => Gain gain => Dyno limiter => dac => WvOut2 waveOut => blackhole;
me.dir() + "shortBreak2.wav" => drumBreak.read;
"compressBreak.wav" => waveOut.wavFilename;

30 => dyno.ratio;
0::ms => dyno.attackTime;
0.05 => dyno.thresh;

24 => gain.gain;

0.9 => limiter.thresh;
0::ms => limiter.attackTime;

while(true)
{
    -1 => dyno.op;
    -1 => gain.op;

    0 => drumBreak.pos;
    2::second => now;
    0 => drumBreak.pos;
    2::second => now;

    1 => dyno.op;
    1 => gain.op;

    0 => drumBreak.pos;
    2::second => now;
    0 => drumBreak.pos;
    2::second => now;
}

waveOut.closeFile();