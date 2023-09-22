<<< "Theodore" >>>;

// private class ChordProvider
// {
//     [0,3,7] @=> int chord[];    
//     0 => int position;
// }
ChordProvider t;
BPM bpm;

bpm.quarterNote => dur beat;
48 => int offset;

fun void PlayNote(int note, int position, dur duration)
{        
    SinOsc lfo => SawOsc osc => LPF lpf => ADSR env1 => dac.left;
    env1 => Delay delay => dac.right;
    duration => delay.max;    
    duration / 4 => delay.delay;
    delay => delay;
    1 => delay.gain;
    
    3 => lfo.gain;
    6 => lfo.freq;
    2 => osc.sync;
    0.1 => osc.gain;
    500 => lpf.freq;
    Std.mtof(note + offset + position) => osc.freq;
    (1::ms, duration * 2, 0, 1::ms) => env1.set;
    1 => env1.keyOn;
    duration => now;    
}

while(true)
{
    for(0 => int i; i < t.chord.cap(); i++)
    {        
        spork ~ PlayNote(t.chord[i], t.position, beat);
    }
    beat => now;

}