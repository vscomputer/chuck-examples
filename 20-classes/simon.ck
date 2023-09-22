<<< "Simon" >>>;

// private class ChordProvider
// {
//     [0,3,7] @=> int chord[];    
//     0 => int position;
// }
ChordProvider s;
BPM bpm;

SqrOsc osc => LPF lpf => ADSR env1 => dac;
SqrOsc osc2 => lpf;
0.4 => osc.gain;
0.1 => osc2.gain;
400 => lpf.freq;
bpm.quarterNote => dur beat;
(1::ms, beat/4, 0, 1::ms) => env1.set;
36 => int offset;
int position;

while(true)
{    
    beat / 4 => dur sixteenth;
    Std.mtof(s.chord[0] + offset + s.position) => osc.freq;
    Std.mtof(s.chord[0] + offset + s.position - 24) => osc2.freq;
    1 => env1.keyOn;
    sixteenth * 3 => now;
    1 => env1.keyOn;
    sixteenth * 3 => now;
    1 => env1.keyOn;
    sixteenth * 2 => now;
}