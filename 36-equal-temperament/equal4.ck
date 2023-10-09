SndBuf buffer => Dyno dynoC => dac;
buffer => Delay delayL => Dyno dynoL => dac.left;
Delay delayR => Dyno dynoR => dac.right;

0.5::second => dur beat;

4::beat => delayL.max => delayR.max;

beat * .75 => delayL.delay;
beat * .75 => delayR.delay;
0.85 => delayL.gain => delayR.gain;

delayL => delayR;
delayR => delayL;

me.dir() + "guitar.wav" => string filename;
filename => buffer.read;

1 => buffer.gain;
-0.5 => buffer.rate;
4 * 44100 => int spot;

<<< 0, buffer.rate() >>>;

    spot => buffer.pos;
    .75::beat => now;
    spot => buffer.pos;
    .75::beat => now;
    spot => buffer.pos;
    .5::beat => now;

1.0594630943592952645618252949463 => float semitone;


while(true)
{
    for(1 => int i; i < 13; i++)
    {
        transpose(buffer.rate(), 7) => buffer.rate;
        <<< i , buffer.rate() >>>;
        i++;
        spot => buffer.pos;
        .75::beat => now;
        spot => buffer.pos;
        .75::beat => now;
        transpose(buffer.rate(), -12) => buffer.rate;
        spot => buffer.pos;
        .5::beat => now;
        transpose(buffer.rate(), 7) => buffer.rate;
        <<< i , buffer.rate() >>>;    
        spot => buffer.pos;
        .75::beat => now;
        spot => buffer.pos;
        .75::beat => now;
        spot => buffer.pos;
        .5::beat => now;
        
    }
}

fun float transpose(float rate, int semitones)
{    
    rate => float result;
    if(semitones > 0)
    {
        for(1 => int j; j <= semitones; j++)
        {
            result * semitone => result;        
        }
    }
    else if(semitones < 0)
    {                 
        for(1 => int j; j <= Math.abs(semitones); j++)
        {            
            result * (1 / semitone ) => result;        
        }
    }
    return result;
}