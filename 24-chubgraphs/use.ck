SynthVoice voice => Dyno dyno => dac;
[0,4,7,11,14,16,19,23,24] @=> int notes[];
//[0,0,12,10] @=> int notes[];
10 => voice.cutoff;
2 => voice.ChooseOsc1;
3 => voice.ChooseOsc2;
10 => voice.detune;
0 => voice.oscOffset;
1.5 => voice.pitchMod;
50 => voice.cutoffMod;
0 => voice.ChooseLfo;
5 => voice.SetLfoFreq;
0 => voice.noise;
5 => voice.reverb;
1::ms => voice.adsr.attackTime;
150::ms => voice.adsr.decayTime;
1 => voice.adsr.gain;
while(true)
{
    Math.random2(1,3) => int nextOsc;
    nextOsc => voice.ChooseOsc1;
    nextOsc => voice.ChooseOsc2;
    Math.random2(1,10) => voice.SetLfoFreq;
    Math.random2(1,15) => voice.rez;
    Math.random2(1,100) => voice.env;
    notes[Math.random2(0, notes.cap()-1)] + 12 => voice.keyOn;
    1::second / 8 => now;
    1 => voice.keyOff;
}