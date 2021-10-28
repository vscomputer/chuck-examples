SinOsc osc => ADSR env => Pan2 pan => NRev rev[2] => dac;

FileIO partFile;
partFile.open( "part.txt", FileIO.READ );

0.25 => osc.gain;
(1::ms, 100::ms, 0, 1::ms) => env.set;
0.1 => rev[0].mix => rev[1].mix;

while(true)
{
    while(partFile.eof() == false)
    {
        partFile => int note;
        partFile => float panPos;
        partFile => int decay;

        note => Std.mtof => osc.freq;    
        panPos => pan.pan;
        decay::ms => env.decayTime;

        1 => env.keyOn;
        
        125::ms => now;
    }
    0 => partFile.seek;
}
partFile.close();