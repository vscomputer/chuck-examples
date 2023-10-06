SinOsc osc => ADSR env => dac;
(1::ms, 100::ms, 0, 1::ms) => env.set;

FileIO io;

<<< io.open("int.txt", FileIO.READ) >>>;

while(io => int val)
{         
    <<< val >>>;
    60 + val => Std.mtof => osc.freq;    
    1 => env.keyOn;
    250::ms => now;    
}