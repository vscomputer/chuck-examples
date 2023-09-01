<<< "If Statements Drum Machine" >>>;

SndBuf kick => dac;
SndBuf snare => dac;
SndBuf cHat => dac;
SndBuf oHat => dac;

me.dir() + "kick.wav" => string kickFileName;
me.dir() + "snare.wav" => string snareFileName;
me.dir() + "c-hat.wav" => string cHatFileName;
me.dir() + "o-hat.wav" => string oHatFileName;

kickFileName => kick.read;
snareFileName => snare.read;
cHatFileName => cHat.read;
oHatFileName => oHat.read;

fun void SilenceAllBuffers()
{
    kick.samples() => kick.pos;
    snare.samples() => snare.pos;
    cHat.samples() => cHat.pos;
    oHat.samples() => oHat.pos;
}
SilenceAllBuffers();

0.45::second => dur beat;

fun void Drum(int select, dur duration)
{
    if(select == 0)
    {
        0 => kick.pos;
        0 => cHat.pos;
    }
    if(select == 1)
    {
        0 => oHat.pos;
    }
    if(select == 2)
    {
        0 => kick.pos;
        0 => cHat.pos;
        0 => snare.pos;
    }
    duration => now;
    SilenceAllBuffers();
}

fun void HouseLoop()
{
    Drum(0, 0.5::beat);
    Drum(1, 0.5::beat);

    Drum(2, 0.5::beat);
    Drum(1, 0.5::beat);

    Drum(0, 0.5::beat);
    Drum(1, 0.5::beat);

    Drum(2, 0.5::beat);
    Drum(1, 0.5::beat); 
}

while(true)
{
    HouseLoop();
}