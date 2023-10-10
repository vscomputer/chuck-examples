
"mellow-flute-c3.wav" => string filename;

class Sampler extends Chugraph
{
    SndBuf buffer => outlet;

    fun void open(string filename)
    {
        buffer.read(filename);
    }

    1 => buffer.loop;

}

Sampler sampler => dac;

sampler.open(filename);

10::second => now;
