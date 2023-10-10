
"guitar.wav" => string filename;
//"Mell Flute C3.WAV" => string filename;

class Sampler extends Chugraph
{
    LiSa lisa => ADSR ampEnv => Gain noiseGain => outlet;
    (1::second,1::second,0.0, 1::ms ) => ampEnv.set;
    
    fun void open(string filename)
    {
        load(filename);
    }

    fun void load( string filename )
    {        
        SndBuf buffer;
        filename => buffer.read;
                
        buffer.samples()::samp => lisa.duration;
        
        for( 0 => int i; i < buffer.samples(); i++ )
        {            
            lisa.valueAt( buffer.valueAt(i), i::samp );        
        }
    }

    0::second => dur startPos;

    fun void play(int semitones)
    {        
        1 => ampEnv.keyOn;
        transpose(1, semitones) => lisa.rate;        
        startPos => lisa.playPos;
        1 => lisa.play;
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
beat  => sampler.ampEnv.decayTime;

3::second => sampler.startPos;

[-12,-9, -5,-2, 0, 3, 7,10] @=> int notes[];

while(true)
{
    notes[Math.random2(0, notes.cap()-1)] => int note;    
    sampler.play(note);    
    beat * 2 => now;        
}



