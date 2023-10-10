
"guitar.wav" => string filename;
//"Mell Flute C3.WAV" => string filename;

class Sampler extends Chugraph
{
    SndBuf buffer => ADSR ampEnv => Gain noiseGain => outlet;
    (1::second,2::second,0.0, 1::ms ) => ampEnv.set;
    
    fun void open(string filename)
    {
        buffer.read(filename);
    }

    0 => int startPos;
    buffer.samples() => int loopLength;
    
    fun void setLoopLength(int samples)
    {
        samples => loopLength;
    }

    fun void play(int semitones)
    {
        1 => ampEnv.keyOn;
        startPos => buffer.pos;            
        transpose(1, semitones) => buffer.rate;
        1::ms => now;
        <<< ampEnv.state(), ampEnv.value() >>>;
        while( ampEnv.value() != 0.0 )
        {
            
            1::ms => now;            
            if(buffer.pos() > startPos + loopLength)
            {                
                startPos => buffer.pos;
            }
            else
            {
                continue;
            }
        }
    }

    fun float transpose(float frequency, int semitones)
    {
        1.0594630943592952645618252949463 => float semitone;
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

}

Sampler sampler => Delay delay[2] => dac;
sampler => dac;

2::second => delay[0].max => delay[1].max;

sampler.open(filename);

0.5 => sampler.gain;

0.5::second => dur beat;

beat / 2 => delay[0].delay;
beat / 4 => delay[1].delay;
0.75 => delay[0].gain => delay[1].gain;
delay[0] => delay[1] => delay[0];

1::ms => sampler.ampEnv.attackTime;
2::beat  => sampler.ampEnv.decayTime;

3 * 44100 => sampler.startPos;

22050 / 16 => sampler.loopLength;

[-12,-9, -5,-2, 0, 3, 7,10] @=> int notes[];

while(true)
{
    notes[Math.random2(0, notes.cap()-1)] => int note;
    spork ~ sampler.play(note);
    beat * 2 => now;        
}



