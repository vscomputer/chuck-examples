<<< "breaks.ck" >>>;

SndBuf fakeAmen => Pan2 pan => dac;
fakeAmen => NRev rev => dac;
rev =< dac;
0.4 => rev.mix;
0.5 => rev.gain;

0.6 => fakeAmen.gain;
me.dir() + "break2.wav" => string filename;
filename => fakeAmen.read;

1.4 => float MAIN_RATE;
second / (2 * MAIN_RATE) => dur beat;

MAIN_RATE => fakeAmen.rate;

function void cutBreak(int sliceChoice, dur duration)
{
    fakeAmen.samples() / 32 => int slice;
    slice * sliceChoice => int position;
    fakeAmen.pos(position);
    duration => now;
}

function void stutter(int sliceChoice, dur duration, int divisor)
{
    for(0 => int i; i < divisor; i++)
    {
        cutBreak(sliceChoice, duration / divisor);                
    }
}

function void volumeRamp(dur duration, int divisor)
{
    duration / divisor => dur durationSlice;
    fakeAmen.gain() - (fakeAmen.gain() / 8 ) => float rampHeight;
    fakeAmen.gain() / 8 => fakeAmen.gain;
    for(0 => int i; i < divisor; i++)
    {
        fakeAmen.gain() + (rampHeight / divisor) => fakeAmen.gain;
        durationSlice => now;
    }
}

function void rampUp(int sliceChoice, dur duration, int divisor)
{
    spork ~ volumeRamp(duration, divisor);
    stutter(sliceChoice, duration, divisor);
}

while(true)
{
    cutBreak(8, 2 * beat);
    cutBreak(24, 2 * beat);
    cutBreak(2, 1 * beat);
    cutBreak(2, 1 * beat);
    cutBreak(8, 1.5 * beat);
    cutBreak(8, 0.25 * beat);
    cutBreak(8, 0.25 * beat);

    cutBreak(8, 2 * beat);
    cutBreak(24, 2 * beat);
    rev => dac.right;
    cutBreak(2, 1 * beat);
    rev =< dac.right;
    rev => dac.left;
    cutBreak(2, 1 * beat);
    rev =< dac;
    cutBreak(8, 2 * beat);

    cutBreak(8, .25 * beat);
    cutBreak(8, .25 * beat);
    cutBreak(8, .25 * beat);
    cutBreak(8, .25 * beat);
    cutBreak(2, .25 * beat);
    cutBreak(1, .25 * beat);
    cutBreak(2, .25 * beat);
    cutBreak(2, .25 * beat);
    cutBreak(8, .5 * beat);
    cutBreak(2, 1.5 * beat);
    cutBreak(8, .5 * beat);
    cutBreak(2, 1.5 * beat);
    cutBreak(8, 1.5 * beat);
    cutBreak(8, 0.25 * beat);
    cutBreak(8, 0.25 * beat);

    cutBreak(8, 1 * beat);
    MAIN_RATE * -1 => fakeAmen.rate;
    cutBreak(10, 1 * beat);
    MAIN_RATE => fakeAmen.rate;
    cutBreak(2, 0.5 * beat);
    cutBreak(2, 1.5 * beat);
    cutBreak(8, 1.5 * beat);
    cutBreak(4, 1.5 * beat);
    MAIN_RATE - .4 => fakeAmen.rate;
    cutBreak(2, 0.25 * beat);
    MAIN_RATE => fakeAmen.rate;
    cutBreak(6, 0.25 * beat);
    MAIN_RATE - .3 => fakeAmen.rate;
    cutBreak(2, 0.25 * beat);
    MAIN_RATE - .2 => fakeAmen.rate;
    cutBreak(2, 0.25 * beat);
    MAIN_RATE => fakeAmen.rate;

    MAIN_RATE / 2 => fakeAmen.rate;
    -0.5 => pan.pan;
    cutBreak(8, 1 * beat);
    0.5 => pan.pan;
    cutBreak(10, 1 * beat);
    0 => pan.pan;
    MAIN_RATE => fakeAmen.rate;
    cutBreak(2, 1 * beat);
    cutBreak(2, 1 * beat);
    cutBreak(8, 1.5 * beat);
    cutBreak(4, 1.5 * beat);
    cutBreak(2, 1 * beat);

    stutter(0, 1 * beat, 8);
    stutter(2, 1 * beat, 8);
    cutBreak(2, 1 * beat);
    cutBreak(2, 1 * beat);
    cutBreak(8, 1 * beat);
    cutBreak(2, 1 * beat);
    stutter(2, 1 * beat, 4);
    stutter(2, 0.5 * beat, 8);
    stutter(2, 0.5 * beat, 12);

    rev => dac;
    rampUp(2, 2 * beat, 16);
    -0.8 => pan.pan;
    rampUp(0, 1 * beat, 8);
    0.8 => pan.pan;
    rampUp(2, 1 * beat, 16);
    rev =< dac;
    0 => pan.pan;
    cutBreak(2, 1 * beat);
    cutBreak(2, 1 * beat);
    cutBreak(8, 1.5 * beat);
    -1.0 => pan.pan;
    cutBreak(8, 0.25 * beat);
    1.0 => pan.pan;
    cutBreak(8, 0.25 * beat);
    0 => pan.pan;

    -1.0 => pan.pan;
    stutter(8, 1 * beat, 4);
    1.0 => pan.pan;
    stutter(8, 1 * beat, 4);
    0 => pan.pan;
    rampUp(2, 1 * beat, 4);
    stutter(2, 1 * beat, 8);

    cutBreak(2, 1 * beat);
    cutBreak(2, 1 * beat);
    2.1 => fakeAmen.rate;
    rampUp(2, 1* beat, 8);
    -0.8 => pan.pan;
    1.4 => fakeAmen.rate;
    stutter(2, 0.25 * beat, 4);
    -0.4 => pan.pan;
    1.3 => fakeAmen.rate;
    stutter(6, 0.25 * beat, 4);
    0.4 => pan.pan;
    1.2 => fakeAmen.rate;
    stutter(2, 0.25 * beat, 4);
    0.8 => pan.pan;
    1.1 => fakeAmen.rate;
    stutter(2, 0.25 * beat, 4);
    0 => pan.pan;
    1.4 => fakeAmen.rate;
}