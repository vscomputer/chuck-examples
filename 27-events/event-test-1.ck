class WaitWithPosition extends Event
{
    int position;
}

48 => int offset;

[0,4,7,11] @=> int notes[];

fun void playArp(WaitWithPosition wait)
{
    SinOsc osc => dac;
    0.25 => osc.gain;    
    while (true)
    {
        for(0 => int i; i < notes.cap(); i ++ )
        {
            offset + notes[i] + wait.position => Std.mtof => osc.freq;
            0.25::second => now;
        }
       <<< wait.position, "waiting..." >>>;
       wait => now;
       <<< wait.position, "...go" >>>;
    }
}

WaitWithPosition wait;

0 => wait.position;
spork ~ playArp(wait);
2::second => now;

12 => wait.position;
spork ~ playArp(wait);
2::second => now;

24 => wait.position;
spork ~ playArp(wait);

while(true)
{
    2::second => now;   
    wait.signal();     
}