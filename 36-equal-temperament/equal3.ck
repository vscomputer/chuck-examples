SinOsc osc1 => dac;

0.5 => osc1.gain;
440 => osc1.freq;

<<< 0, osc1.freq() >>>;
1::second => dur beat;
beat => now;

1.0594630943592952645618252949463 => float semitone;

for(1 => int i; i < 13; i++)
{
    transpose(osc1.freq(), 7) => osc1.freq;
    <<< i , osc1.freq() >>>;
    i++;
    beat => now;
    transpose(osc1.freq(), -12) => osc1.freq;
    transpose(osc1.freq(), 7) => osc1.freq;
    <<< i , osc1.freq() >>>;    
    beat => now;
}

fun float transpose(float frequency, int semitones)
{    
    frequency => float result;
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

