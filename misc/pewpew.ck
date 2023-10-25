"laser-single.wav" => string laser;
dac => WvOut waveOut => blackhole; 
"laser-result.wav" => waveOut.wavFilename;

100::ms => dur rate;

fun void pew()
{
    SndBuf buffer => dac;

    Math.random2f(0.1, 0.3) => buffer.gain;
    Math.random2f(0.8, 1.2) => float rateMod;
    rateMod => buffer.rate;
    laser => buffer.read;
    buffer.length() * rateMod => now;
}

0.5 => float min;
5.0 => float max;

for (0 => int i; i < 40; i++)
{
    spork ~ pew();
    Math.random2f(min, max) * rate => now;
}