
"mellow-flute-c3.wav" => string filename;

class Sampler extends Chugraph
{
    SndBuf buffer => ADSR ampEnv => outlet;
    (1::second,1::second,0.0, 1::ms ) => ampEnv.set;
    
    fun void open(string filename)
    {
        buffer.read(filename);
    }

    0 => int startPos;

    fun void play(int semitones)
    {
        startPos => buffer.pos;
        1 => ampEnv.keyOn;
        transpose(1, semitones) => buffer.rate;
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

Sampler sampler => dac;

sampler.open(filename);

0.5 => sampler.gain;

0.5::second => dur beat;

1::ms => sampler.ampEnv.attackTime;
beat  => sampler.ampEnv.decayTime;

0 * 44100 => sampler.startPos;

[-12,-9, -5,-2, 0, 3, 7, 10] @=> int notes[];

while(true)
{    
    sampler.play(notes[Math.random2(0, notes.cap()-1)] + (12 * Math.random2(-2,2)));
    beat => now;
}