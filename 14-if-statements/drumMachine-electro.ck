<<< "If/Else Drum Machine" >>>;

SndBuf kick => dac;
SndBuf snare => dac;
SndBuf cHat => dac;
SndBuf oHat => dac;

me.dir() + "kick.wav" => string kickFilename;
me.dir() + "clap.wav" => string snareFilename;
me.dir() + "c-hat.wav" => string cHatFilename;
me.dir() + "o-hat.wav" => string oHatFilename;

kickFilename => kick.read;
snareFilename => snare.read;
cHatFilename => cHat.read;
oHatFilename => oHat.read;

fun void SilenceAllBuffers()
{
    kick.samples() => kick.pos;
    snare.samples() => snare.pos;
    oHat.samples() => oHat.pos;
    cHat.samples() => cHat.pos;
}

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
    if(select == 3)
    {
        0 => snare.pos;
    }
    duration => now;
    SilenceAllBuffers();
}

SilenceAllBuffers();

// while(true)
// {
//     Drum(0, beat/2);
//     Drum(1, beat/2);
//     Drum(2, beat/2);
//     Drum(1, beat/2);
//     Drum(0, beat/2);
//     Drum(1, beat/2);
//     Drum(2, beat/2);
//     Drum(1, beat * 0.28);
//     Drum(1, beat * 0.22);
// }

while(true)
{
    for(0=> int i; i<4; i++)
    {
        Drum(0, beat/4);
    }
    Drum(3, beat /2);
    Drum(0, beat/4);
    Drum(0, beat/4);
    for(0=> int i; i<3; i++)
    {
        Drum(0, beat/3);
    }
    Drum(3, beat );
}

