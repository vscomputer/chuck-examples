<<< "hi-hat.ck" >>>;
Noise osc => BPF filter1 => ADSR env1 => Pan2 pan => dac;

0.5::second => dur beat;
(1::ms, beat / 16, 0,1::ms) => env1.set;
0.15 => osc.gain;
4 => filter1.Q;

while(true)
{
    Math.random2(1000,10000) => filter1.freq;
    Math.random2f(-0.8,0.8) => pan.pan;
    Math.random2(4, 16) => int beatDivisor;
    beat / beatDivisor => env1.decayTime;
    1 => env1.keyOn;
    beat / 4 => now;
}