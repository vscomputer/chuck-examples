1::second / 2 => dur beat;
beat - (now % beat) => now;

SynthVoice voice => Delay delay[2] => dac;
1::second => delay[0].max => delay[1].max;
0.2 => delay[0].gain => delay[1].gain;
1 => delay[0].op => delay[1].op;
beat / 4 => delay[0].delay;
beat / 2 => delay[1].delay;
delay => delay;
voice => dac;

50 => voice.cutoff;
10 => voice.env;
48 => voice.offset;
1 => voice.ChooseOsc1;
1 => voice.ChooseOsc2;
15 => voice.detune;
12 => voice.oscOffset;
0 => voice.pitchMod;
0 => voice.cutoffMod;
1 => voice.ChooseLfo;
4 => voice.SetLfoFreq;
0 => voice.noise;
40 => voice.reverb;
150::ms => voice.adsr.attackTime;
150::ms => voice.adsr.decayTime;
0 => voice.adsr.sustainLevel;
0.5 => voice.adsr.gain;
0 => voice.rez;

while(true)
{
    [0,4,7,11,12,14,19,23] @=> int notes[];
    while(true)
    {
        
        for(0 => int i; i < notes.cap(); i++)
        {
            36 => voice.offset;
            voice.keyOn(notes[Math.random2(0, notes.cap()-1)]);
            //voice.keyOn(12);
            beat / 4 => now;
            1 => voice.keyOff;
        }
    }
}
