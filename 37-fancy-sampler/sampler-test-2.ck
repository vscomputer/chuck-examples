
"mellow-flute-c3.wav" => string filename;

class Sampler extends Chugraph
{
    SndBuf buffer => ADSR ampEnv => outlet;
    (1::second,1::second,0.0, 1::ms ) => ampEnv.set;

    fun void open(string filename)
    {
        buffer.read(filename);
    }

    fun void play()
    {
        0 => buffer.pos;
        1 => ampEnv.keyOn;
    }

}

Sampler sampler => dac;

sampler.open(filename);

sampler.play();

2::second => now;

1::ms => sampler.ampEnv.attackTime;

sampler.play();

2::second => now;
