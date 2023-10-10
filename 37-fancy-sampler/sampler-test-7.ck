class Sampler extends Chugraph
{
    LiSa lisa => ADSR ampEnv => outlet;
    (1::ms,1::second,1.0, 1::ms ) => ampEnv.set;

    fun void open(string filename)
    {
        load(filename);
        1.0 => lisa.rate; 
        1 => lisa.loop; 
        1 => lisa.bi; 
    }

    fun void load( string filename )
    {        
        SndBuf buffy;        
        filename => buffy.read;
                
        buffy.samples()::samp => lisa.duration;
        
        for( 0 => int i; i < buffy.samples(); i++ )
        {            
            lisa.valueAt( buffy.valueAt(i), i::samp );        
        }
    }

    0::ms => dur playPos; 

    fun void play(int semitones)
    {                        
        transpose(1, semitones) => lisa.rate;

        playPos => lisa.playPos;
        playPos => lisa.loopStart;
        playPos + 1::second => lisa.loopEnd;

        1 => ampEnv.keyOn;
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

"guitar.wav" => string filename;

Sampler sampler => Pan2 pan => dac;

sampler.open(filename);

0.5 => sampler.gain;

1::second => dur beat;

0::beat => sampler.playPos;

1::ms => sampler.ampEnv.attackTime;
1::beat  => sampler.ampEnv.decayTime;

[-12,-9, -5,-2, 0, 3, 7, 10] @=> int notes[];

<<< Chugraph.help() >>>;

while(true)
{    
    sampler.play(notes[Math.random2(0, notes.cap()-1)] + (12 * Math.random2(0,2)));
    Math.random2f(-1.0, 1.0) => pan.pan;
    1::beat => now;
}


