SinOsc osc => ADSR env => dac;
(1::ms, 100::ms, 0, 1::ms) => env.set;

FileIO io;

<<< io.open("int2.txt", FileIO.READ) >>>;

2::second => dur beat;
60 => int offset;

while(true)
{
    while (io.eof() == false)
    {
        io => int note;
        io => int div; // divisor для 1/8 и 1/16 бита
        io => float vol; // volume 
        <<< note, div >>>;
        note + offset => Std.mtof => osc.freq;
        vol => osc.gain;
        1 => env.keyOn;
        beat / div => now;
        <<< "last thing in the inner loop", io.tell() >>>;
    }
    <<< "last thing before the seek", io.tell() >>>;
    0 => io.seek; // показывает что выбрать дальше, 0 - выбирает первый токен, чтобы сделать луп - но почему-то не делает
}