SndBuf kick => dac;

me.dir() + "kick.wav" => string kickFileName;
kickFileName => kick.read;

fun void SilenceAllBuffers()
{
    kick.samples() => kick.pos;
}
SilenceAllBuffers();

0.5::second => dur beat;

fun void Drum(int select, dur duration, float gain)
{
    if(select == 0)
    {
        gain => kick.gain;
        0 => kick.pos;
    }
    duration => now;
    SilenceAllBuffers();
}

while(true)
{
    Drum(0, beat * 0.75, 0.5);
    Drum(0, beat * 0.25, 0.05);
}