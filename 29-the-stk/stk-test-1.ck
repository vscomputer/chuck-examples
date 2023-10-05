BandedWG stk => dac;

//Delays, for fun
stk => Delay delays[2] => dac;
1::second => delays[0].max => delays[1].max;
500::ms => delays[0].delay;
250::ms => delays[1].delay;
0.5 => delays[0].gain => delays[1].gain;
delays[0] => delays[1];
delays[1] => delays[0];

[0,4,7,11] @=> int notes[];

48 => int offset;

0.5 => stk.bowPressure;
0 => stk.preset;

while(true)
{
    Math.random2(0,3) => stk.preset;
    <<< stk.preset() >>>;
    Math.random2(0,2) => int position;    
    (position * 12) + offset + notes[Math.random2(0, notes.cap() -1)] => int note; 
    //48 => int note;
    note => Std.mtof => stk.freq;
    1.0 => stk.pluck;
    125::ms => now;
    1.0 => stk.pluck;
    125::ms => now;
    //1.0 => stk.stopBowing;
    //200::ms => now;
}