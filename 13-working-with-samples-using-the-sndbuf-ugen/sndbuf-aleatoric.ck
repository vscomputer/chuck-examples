<<< "Sampling with SndBuf" >>>;

SndBuf guitar => ADSR env1 => NRev rev1 => Pan2 pan => dac;
SndBuf guitar2 => ADSR env2 => NRev rev2 => dac;
1::second => dur beat;
0.1 => rev1.mix => rev2.mix;
0.75 => guitar.gain => guitar2.gain;

(5::ms, beat / 4, 0, 5::ms) => env1.set;
(200::ms, beat, 0, 5::ms) => env2.set;
me.dir() + "guitar.wav" => string filename;

filename => guitar.read => guitar2.read;
<<< guitar.samples() >>>;

while(true)
{
    playGuitar(2.0);
    playGuitar(4.0/3.0);
    playGuitar(2.0);
    playGuitar(1.5);
}

fun void playGuitar(float rate)
{
    for(0 => int i; i < 8; i++)
    {
        rate => guitar.rate;
        (0 - rate) / 2  => guitar2.rate;
        Math.random2f(-1.0, 1.0) => pan.pan;
        Math.random2(0, guitar.samples()) => guitar.pos => guitar2.pos;
        1 => env2.keyOn;
        1 => env1.keyOn;
        beat / 4 => now;
        1 => env1.keyOn;
        beat / 4 => now;                        
    }
}
