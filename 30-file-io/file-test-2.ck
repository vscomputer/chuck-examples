SinOsc osc => ADSR env => dac;
(1::ms, 100::ms, 0, 1::ms) => env.set;

FileIO io;

<<< io.open("int2.txt", FileIO.READ) >>>;

2::second => dur beat;
60 => int offset;

while(true)
{
    while(io.eof() == false)
    {        
        io => int note;
        io => int div;
        io => float vol;
        <<< note, div, vol >>>;
        note + offset => Std.mtof => osc.freq;
        vol => osc.gain;
        1 => env.keyOn;
        beat / div => now;
    }
    0 => io.seek;
}