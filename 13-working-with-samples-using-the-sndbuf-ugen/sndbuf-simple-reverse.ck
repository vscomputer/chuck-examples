<<< "Samples and the SndBuf Ugen" >>>;

SndBuf guitar => dac;

me.dir() + "guitar.wav" => string filename;
filename => guitar.read;

//guitar.samples() => guitar.pos; //stops playback

-0.5 => guitar.rate;
guitar.samples() -1 => guitar.pos;
10::second => now;