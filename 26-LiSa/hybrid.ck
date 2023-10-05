SinOsc osc => ADSR env => NRev rev => dac;
adc => LiSa lisa => rev;

1::second / 2 => dur beat;

0.25 => osc.gain;

4::beat => lisa.duration;

(1::ms, 150::ms, 0, 1::ms) => env.set;

0.2 => rev.mix;

48 => int offset;


while(true)
{
    [0,4,7,11,12,16,19,23] @=> int notes[];
    1 => lisa.record;
    for(0 => int i; i < notes.cap(); i++)
    {
        Std.mtof(notes[i] + offset) => osc.freq;
        1 => env.keyOn;
        0.5::beat => now;
    }
    0 => lisa.record;
    1 => lisa.loop;
    1::ms => lisa.rampUp;
    1 => lisa.bi;

    for(0 => float i; i < 2; i + 1 => i)
    {   
        3::beat => lisa.loopStart;
        4::beat => lisa.loopEnd;
        4::beat => now;    
    }
    1::ms => lisa.rampDown;
    
    1 => lisa.record;
    for(0 => int i; i < notes.cap(); i++)
    {
        Std.mtof(notes[i] + offset + 5) => osc.freq;
        1 => env.keyOn;
        0.5::beat => now;
    }
    0 => lisa.record;
    1::ms => lisa.rampUp;

    for(0 => float i; i < 2; i + 1 => i)
    {           
        3::beat => lisa.loopStart;
        4::beat => lisa.loopEnd;
        4::beat => now;    
    }
    0::ms => lisa.rampDown;
}