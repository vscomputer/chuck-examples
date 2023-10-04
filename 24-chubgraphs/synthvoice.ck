public class SynthVoice extends Chugraph
{
    SawOsc saw1 => LPF lpf => ADSR adsr => Dyno limiter => NRev rev => outlet;
    SawOsc saw2 => lpf;
    Noise noiseSource => lpf;

    0 => noiseSource.gain;

    TriOsc tri1, tri2;
    SqrOsc sqr1, sqr2;
    
    SinOsc SinLfo;
    SawOsc SawLfo;
    SqrOsc SqrLfo;
    SinLfo => Gain pitchLfo => blackhole;
    SinLfo => Gain filterLfo => blackhole;

    fun void SetLfoFreq(float frequency)
    {
        frequency => SinLfo.freq => SawLfo.freq => SqrLfo.freq;
    }

    6.0 => SetLfoFreq;
    0 => filterLfo.gain;
    0 => pitchLfo.gain;
    
    2 => saw1.sync => saw2.sync => tri1.sync => tri2.sync => sqr1.sync => sqr2.sync;
    pitchLfo => saw1;
    pitchLfo => saw2;
    pitchLfo => tri1;
    pitchLfo => tri2;
    pitchLfo => sqr1;
    pitchLfo => sqr2;
    
    0::ms => limiter.attackTime;
    0.8 => limiter.thresh;

    0.1 => tri1.gain => tri2.gain;
    0.1 => saw1.gain => saw2.gain;
    0.1 => sqr1.gain => sqr2.gain;

    10 => float filterCutoff;
    filterCutoff => lpf.freq;

    1::ms => adsr.attackTime;
    150::ms => adsr.decayTime;
    0 => adsr.sustainLevel;
    1::ms => adsr.releaseTime;

    24 => int offset;
    0 => float filterEnv;

    1 => float osc2Detune;
    0 => int oscOffset;

    fun void SetOsc1Freq(float frequency)
    {
        frequency => tri1.freq => sqr1.freq => saw1.freq;
    }

    fun void SetOsc2Freq(float frequency)
    {
        frequency => tri2.freq => sqr2.freq => saw2.freq;
    }

    fun void keyOn(int noteNumber)
    {        
        Std.mtof(offset + noteNumber) => SetOsc1Freq;
        Std.mtof(offset + noteNumber + oscOffset) - osc2Detune => SetOsc2Freq;
        1 => adsr.keyOn;
        spork ~ filterEnvelope();        
    }

    fun void ChooseOsc1(int oscType)
    {
        if(oscType == 0)
        {
            tri1 =< lpf;
            saw1 =< lpf;
            sqr1 =< lpf;
        }
        if(oscType == 1)
        {
            tri1 => lpf;
            saw1 =< lpf;
            sqr1 =< lpf;
        }
        if(oscType == 2)
        {
            tri1 =< lpf;
            saw1 => lpf;
            sqr1 =< lpf;
        }
        if(oscType == 3)
        {
            tri1 =< lpf;
            saw1 =< lpf;
            sqr1 => lpf;
        }
    }

    fun void ChooseOsc2(int oscType)
    {
        if(oscType == 0)
        {
            tri2 =< lpf;
            saw2 =< lpf;
            sqr2 =< lpf;
        }
        if(oscType == 1)
        {
            tri2 => lpf;
            saw2 =< lpf;
            sqr2 =< lpf;
        }
        if(oscType == 2)
        {
            tri2 =< lpf;
            saw2 => lpf;
            sqr2 =< lpf;
        }
        if(oscType == 3)
        {
            tri2 =< lpf;
            saw2 =< lpf;
            sqr2 => lpf;
        }
    }

    fun void ChooseLfo(int oscType)
    {
        if(oscType == 0)
        {
            SinLfo =< filterLfo;
            SinLfo =< pitchLfo;
            SawLfo =< filterLfo;
            SawLfo =< pitchLfo;
            SqrLfo =< filterLfo;
            SqrLfo =< pitchLfo;
        }
        if(oscType == 1)
        {
            SinLfo => filterLfo;
            SinLfo => pitchLfo;
            SawLfo =< filterLfo;
            SawLfo =< pitchLfo;
            SqrLfo =< filterLfo;
            SqrLfo =< pitchLfo;
        }
        if(oscType == 2)
        {
            SinLfo =< filterLfo;
            SinLfo =< pitchLfo;
            SawLfo => filterLfo;
            SawLfo => pitchLfo;
            SqrLfo =< filterLfo;
            SqrLfo =< pitchLfo;
        }
        if(oscType == 3)
        {
            SinLfo =< filterLfo;
            SinLfo =< pitchLfo;
            SawLfo =< filterLfo;
            SawLfo =< pitchLfo;
            SqrLfo => filterLfo;
            SqrLfo => pitchLfo;
        }
    }

    fun void keyOff(int noteNumber)
    {
        noteNumber => adsr.keyOff;        
    }

    fun void filterEnvelope()
    {           
        filterCutoff => float startFreq;
        while((adsr.state() != 0 && adsr.value() == 0) == false)
        {
            (filterEnv * adsr.value()) + startFreq + filterLfo.last() => lpf.freq;            
            10::ms => now;
        }

    }

    fun void cutoff(float amount)
    {
        if(amount > 100)
        {
            100 => amount;
        }
        if(amount < 1)
        {
            0 => amount;
        }
        (amount / 100) * 5000 => filterCutoff;
        10::ms => now;
    }

    fun void rez(float amount)
    {
        if(amount > 100)
        {
            100 => amount;
        }
        if(amount < 1)
        {
            0 => amount;
        }
        20 * (amount / 100) + 0.3 => lpf.Q;
    }

    fun void env(float amount)
    {
        if(amount > 100)
        {
            100 => amount;
        }
        if(amount < 1)
        {
            0 => amount;
        }
        5000 * (amount / 100) => filterEnv;        
    }

    fun void detune(float amount)
    {
        if(amount > 100)
        {
            100 => amount;
        }
        if(amount < 1)
        {
            0 => amount;
        }
        5 * (amount / 100) => osc2Detune;        
    }

    fun void pitchMod(float amount)
    {
        if(amount > 100)
        {
            100 => amount;
        }
        if(amount < 1)
        {
            0 => amount;
        }
        84 * (amount / 100) => pitchLfo.gain;        
    }

    fun void cutoffMod(float amount)
    {
        if(amount > 100)
        {
            100 => amount;
        }
        if(amount < 1)
        {
            0 => amount;
        }
        500 * (amount / 100) => filterLfo.gain;        
    }

    fun void noise(float amount)
    {
        if(amount > 100)
        {
            100 => amount;
        }
        if(amount < 1)
        {
            0 => amount;
        }
        1.0 * (amount / 100) => noiseSource.gain; 
    }

    fun void reverb(float amount)
    {
        if(amount > 100)
        {
            100 => amount;
        }
        if(amount < 1)
        {
            0 => amount;
        }
        0.2 * (amount / 100) => rev.mix; 
    }

    fun void help()
    {
        <<< "Classic mono synth voice" >>>;
        <<< "Designed by Clint Hoagland, 03/22/2021" >>>;
        <<< "usage:" >>>;
        <<< "keyOn: triggers adsr (0-127 in semitones)">>>;
        <<< "offset: controls note offset in semitones" >>>;
        <<< "cutoff: filter cutoff (0-100)" >>>;
        <<< "rez: filter resonance (0-100)" >>>;
        <<< "env: filter ADSR tracking (0-100)" >>>;
        <<< "ChooseOsc1: select osc type (0-3)" >>>;
        <<< "ChooseOsc2: select osc type (0-3)" >>>;
        <<< "      (silence, tri, saw, square)" >>>;
        <<< "ChooseLFO: select LFO type (0-3)" >>>;
        <<< "   (disabled, sine, saw, square)" >>>;
        <<< "detune: detune the two voice oscs (1-100)" >>>;
        <<< "oscOffset: offset the two voice oscs (in semitones)" >>>;
        <<< "adsr: works like a standard adsr" >>>;
        <<< "limiter: used as a hard limiter Dyno" >>>;
        <<< "SetLfoFreq: sets the LFO rate in Hz" >>>;
        <<< "pitchMod: osc LFO tracking amount (0-100)" >>>;
        <<< "cutoffMod: filter LFO tracking amount (0-100)">>>;
        <<< "noise: noise amount (0-100)" >>>;
        <<< "reverb: reverb amount (0-100)" >>>;
    }

}

SynthVoice voice;
voice.help();
