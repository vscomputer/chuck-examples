<<< "breaks.ck" >>>;

public class ChopBuffer extends SndBuf2
{
    function void cutBreak(int sliceChoice, dur duration)
    {
        this.samples() / 32 => int slice;
        slice * sliceChoice => int position;
        this.pos(position);
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
        this.gain() - (this.gain() / 8 ) => float rampHeight;
        this.gain() / 8 => this.gain;
        for(0 => int i; i < divisor; i++)
        {
            this.gain() + (rampHeight / divisor) => this.gain;
            durationSlice => now;
        }
    }

    function void rampUp(int sliceChoice, dur duration, int divisor)
    {
        spork ~ volumeRamp(duration, divisor);
        stutter(sliceChoice, duration, divisor);
    }
}

ChopBuffer fakeAmen => Pan2 pan => dac;
fakeAmen => NRev rev => dac;
ChopBuffer strings => pan;
strings => rev;

rev =< dac;
0.4 => rev.mix;
0.5 => rev.gain;

0.6 => fakeAmen.gain => strings.gain;
me.dir() + "break2.wav" => string filename;
filename => fakeAmen.read;
fakeAmen.samples() => fakeAmen.pos;

me.dir() + "HATT1.wav" => string stringsFilename;
stringsFilename => strings.read;
strings.samples() => strings.pos;

1.4 => float MAIN_RATE;
second / (2 * MAIN_RATE) => dur beat;

MAIN_RATE => fakeAmen.rate => strings.rate;

fun void fakeAmenScore()
{
    while(true)
    {
        <<< "this is launching!" >>>;
        fakeAmen.cutBreak(8, 2 * beat);
        fakeAmen.cutBreak(24, 2 * beat);
        fakeAmen.cutBreak(2, 1 * beat);
        fakeAmen.cutBreak(2, 1 * beat);
        fakeAmen.cutBreak(8, 1.5 * beat);
        fakeAmen.cutBreak(8, 0.25 * beat);
        fakeAmen.cutBreak(8, 0.25 * beat);

        fakeAmen.cutBreak(8, 2 * beat);
        fakeAmen.cutBreak(24, 2 * beat);
        rev => dac.right;
        fakeAmen.cutBreak(2, 1 * beat);
        rev =< dac.right;
        rev => dac.left;
        fakeAmen.cutBreak(2, 1 * beat);
        rev =< dac;
        fakeAmen.cutBreak(8, 2 * beat);

        fakeAmen.cutBreak(8, .25 * beat);
        fakeAmen.cutBreak(8, .25 * beat);
        fakeAmen.cutBreak(8, .25 * beat);
        fakeAmen.cutBreak(8, .25 * beat);
        fakeAmen.cutBreak(2, .25 * beat);
        fakeAmen.cutBreak(1, .25 * beat);
        fakeAmen.cutBreak(2, .25 * beat);
        fakeAmen.cutBreak(2, .25 * beat);
        fakeAmen.cutBreak(8, .5 * beat);
        fakeAmen.cutBreak(2, 1.5 * beat);
        fakeAmen.cutBreak(8, .5 * beat);
        fakeAmen.cutBreak(2, 1.5 * beat);
        fakeAmen.cutBreak(8, 1.5 * beat);
        fakeAmen.cutBreak(8, 0.25 * beat);
        fakeAmen.cutBreak(8, 0.25 * beat);

        fakeAmen.cutBreak(8, 1 * beat);
        MAIN_RATE * -1 => fakeAmen.rate;
        fakeAmen.cutBreak(10, 1 * beat);
        MAIN_RATE => fakeAmen.rate;
        fakeAmen.cutBreak(2, 0.5 * beat);
        fakeAmen.cutBreak(2, 1.5 * beat);
        fakeAmen.cutBreak(8, 1.5 * beat);
        fakeAmen.cutBreak(4, 1.5 * beat);
        MAIN_RATE - .4 => fakeAmen.rate;
        fakeAmen.cutBreak(2, 0.25 * beat);
        MAIN_RATE => fakeAmen.rate;
        fakeAmen.cutBreak(6, 0.25 * beat);
        MAIN_RATE - .3 => fakeAmen.rate;
        fakeAmen.cutBreak(2, 0.25 * beat);
        MAIN_RATE - .2 => fakeAmen.rate;
        fakeAmen.cutBreak(2, 0.25 * beat);
        MAIN_RATE => fakeAmen.rate;

        MAIN_RATE / 2 => fakeAmen.rate;
        -0.5 => pan.pan;
        fakeAmen.cutBreak(8, 1 * beat);
        0.5 => pan.pan;
        fakeAmen.cutBreak(10, 1 * beat);
        0 => pan.pan;
        MAIN_RATE => fakeAmen.rate;
        fakeAmen.cutBreak(2, 1 * beat);
        fakeAmen.cutBreak(2, 1 * beat);
        fakeAmen.cutBreak(8, 1.5 * beat);
        fakeAmen.cutBreak(4, 1.5 * beat);
        fakeAmen.cutBreak(2, 1 * beat);

        fakeAmen.stutter(0, 1 * beat, 8);
        fakeAmen.stutter(2, 1 * beat, 8);
        fakeAmen.cutBreak(2, 1 * beat);
        fakeAmen.cutBreak(2, 1 * beat);
        fakeAmen.cutBreak(8, 1 * beat);
        fakeAmen.cutBreak(2, 1 * beat);
        fakeAmen.stutter(2, 1 * beat, 4);
        fakeAmen.stutter(2, 0.5 * beat, 8);
        fakeAmen.stutter(2, 0.5 * beat, 12);

        rev => dac;
        fakeAmen.rampUp(2, 2 * beat, 16);
        -0.8 => pan.pan;
        fakeAmen.rampUp(0, 1 * beat, 8);
        0.8 => pan.pan;
        fakeAmen.rampUp(2, 1 * beat, 16);
        rev =< dac;
        0 => pan.pan;
        fakeAmen.cutBreak(2, 1 * beat);
        fakeAmen.cutBreak(2, 1 * beat);
        fakeAmen.cutBreak(8, 1.5 * beat);
        -1.0 => pan.pan;
        fakeAmen.cutBreak(8, 0.25 * beat);
        1.0 => pan.pan;
        fakeAmen.cutBreak(8, 0.25 * beat);
        0 => pan.pan;

        -1.0 => pan.pan;
        fakeAmen.stutter(8, 1 * beat, 4);
        1.0 => pan.pan;
        fakeAmen.stutter(8, 1 * beat, 4);
        0 => pan.pan;
        fakeAmen.rampUp(2, 1 * beat, 4);
        fakeAmen.stutter(2, 1 * beat, 8);

        fakeAmen.cutBreak(2, 1 * beat);
        fakeAmen.cutBreak(2, 1 * beat);
        MAIN_RATE * 1.5 => fakeAmen.rate;
        fakeAmen.rampUp(2, 1* beat, 8);
        -0.8 => pan.pan;
        MAIN_RATE => fakeAmen.rate;
        fakeAmen.stutter(2, 0.25 * beat, 4);
        -0.4 => pan.pan;
        MAIN_RATE - 0.1 => fakeAmen.rate;
        fakeAmen.stutter(6, 0.25 * beat, 4);
        0.4 => pan.pan;
        MAIN_RATE - 0.2 => fakeAmen.rate;
        fakeAmen.stutter(2, 0.25 * beat, 4);
        0.8 => pan.pan;
        MAIN_RATE - 0.3 => fakeAmen.rate;
        fakeAmen.stutter(2, 0.25 * beat, 4);
        0 => pan.pan;
        MAIN_RATE => fakeAmen.rate;
    }
}

fun void stringsScore()
{
    while(true)
    {
        <<< "strings launching" >>>;
        strings.cutBreak(8, 2 * beat);
        strings.cutBreak(24, 2 * beat);
        strings.cutBreak(2, 1 * beat);
        strings.cutBreak(2, 1 * beat);
        strings.cutBreak(8, 1.5 * beat);
        strings.cutBreak(8, 0.25 * beat);
        strings.cutBreak(8, 0.25 * beat);

        strings.cutBreak(8, 2 * beat);
        strings.cutBreak(24, 2 * beat);
        rev => dac.right;
        strings.cutBreak(2, 1 * beat);
        rev =< dac.right;
        rev => dac.left;
        strings.cutBreak(2, 1 * beat);
        rev =< dac;
        strings.cutBreak(8, 2 * beat);

        strings.cutBreak(8, .25 * beat);
        strings.cutBreak(8, .25 * beat);
        strings.cutBreak(8, .25 * beat);
        strings.cutBreak(8, .25 * beat);
        strings.cutBreak(2, .25 * beat);
        strings.cutBreak(1, .25 * beat);
        strings.cutBreak(2, .25 * beat);
        strings.cutBreak(2, .25 * beat);
        strings.cutBreak(8, .5 * beat);
        strings.cutBreak(2, 1.5 * beat);
        strings.cutBreak(8, .5 * beat);
        strings.cutBreak(2, 1.5 * beat);
        strings.cutBreak(8, 1.5 * beat);
        strings.cutBreak(8, 0.25 * beat);
        strings.cutBreak(8, 0.25 * beat);

        strings.cutBreak(8, 1 * beat);
        MAIN_RATE * -1 => strings.rate;
        strings.cutBreak(10, 1 * beat);
        MAIN_RATE => strings.rate;
        strings.cutBreak(2, 0.5 * beat);
        strings.cutBreak(2, 1.5 * beat);
        strings.cutBreak(8, 1.5 * beat);
        strings.cutBreak(4, 1.5 * beat);
        MAIN_RATE - .4 => strings.rate;
        strings.cutBreak(2, 0.25 * beat);
        MAIN_RATE => strings.rate;
        strings.cutBreak(6, 0.25 * beat);
        MAIN_RATE - .3 => strings.rate;
        strings.cutBreak(2, 0.25 * beat);
        MAIN_RATE - .2 => strings.rate;
        strings.cutBreak(2, 0.25 * beat);
        MAIN_RATE => strings.rate;

        MAIN_RATE / 2 => strings.rate;
        -0.5 => pan.pan;
        strings.cutBreak(8, 1 * beat);
        0.5 => pan.pan;
        strings.cutBreak(10, 1 * beat);
        0 => pan.pan;
        MAIN_RATE => strings.rate;
        strings.cutBreak(2, 1 * beat);
        strings.cutBreak(2, 1 * beat);
        strings.cutBreak(8, 1.5 * beat);
        strings.cutBreak(4, 1.5 * beat);
        strings.cutBreak(2, 1 * beat);

        strings.stutter(0, 1 * beat, 8);
        strings.stutter(2, 1 * beat, 8);
        strings.cutBreak(2, 1 * beat);
        strings.cutBreak(2, 1 * beat);
        strings.cutBreak(8, 1 * beat);
        strings.cutBreak(2, 1 * beat);
        strings.stutter(2, 1 * beat, 4);
        strings.stutter(2, 0.5 * beat, 8);
        strings.stutter(2, 0.5 * beat, 12);

        rev => dac;
        strings.rampUp(2, 2 * beat, 16);
        -0.8 => pan.pan;
        strings.rampUp(0, 1 * beat, 8);
        0.8 => pan.pan;
        strings.rampUp(2, 1 * beat, 16);
        rev =< dac;
        0 => pan.pan;
        strings.cutBreak(2, 1 * beat);
        strings.cutBreak(2, 1 * beat);
        strings.cutBreak(8, 1.5 * beat);
        -1.0 => pan.pan;
        strings.cutBreak(8, 0.25 * beat);
        1.0 => pan.pan;
        strings.cutBreak(8, 0.25 * beat);
        0 => pan.pan;

        -1.0 => pan.pan;
        strings.stutter(8, 1 * beat, 4);
        1.0 => pan.pan;
        strings.stutter(8, 1 * beat, 4);
        0 => pan.pan;
        strings.rampUp(2, 1 * beat, 4);
        strings.stutter(2, 1 * beat, 8);

        strings.cutBreak(2, 1 * beat);
        strings.cutBreak(2, 1 * beat);
        MAIN_RATE * 1.5 => strings.rate;
        strings.rampUp(2, 1* beat, 8);
        -0.8 => pan.pan;
        MAIN_RATE => strings.rate;
        strings.stutter(2, 0.25 * beat, 4);
        -0.4 => pan.pan;
        MAIN_RATE - 0.1 => strings.rate;
        strings.stutter(6, 0.25 * beat, 4);
        0.4 => pan.pan;
        MAIN_RATE - 0.2 => strings.rate;
        strings.stutter(2, 0.25 * beat, 4);
        0.8 => pan.pan;
        MAIN_RATE - 0.3 => strings.rate;
        strings.stutter(2, 0.25 * beat, 4);
        0 => pan.pan;
        MAIN_RATE => strings.rate;
    }
}

spork ~ fakeAmenScore();
spork ~ stringsScore();
60::second => now;