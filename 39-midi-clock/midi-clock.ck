dur tick;
dur beat;
dur bar;

MidiOut drumMachine;
drumMachine.open(2);

MidiMsg midiStart;
250 => midiStart.data1;
0 => midiStart.data2;
0 => midiStart.data3;

MidiMsg midiStop;
252 => midiStop.data1;
0 => midiStop.data2;
0 => midiStop.data3;

MidiMsg midiClockPulse;
248 => midiClockPulse.data1;
0 => midiClockPulse.data2;
0 => midiClockPulse.data3;

fun void SetTempo(float tempo)
{
    tempo => float bpm;
    ((1 / bpm))::minute => beat;
    4::beat => bar;
    beat / 24 => tick;
}

fun void PulseMidiClock()
{
    while(true)
    {
        midiClockPulse => drumMachine.send;
        tick => now;
    }
}

80 => SetTempo;
spork ~ PulseMidiClock();
midiStart => drumMachine.send;

1::bar => now;
120 => SetTempo;
1::bar => now;
160 => SetTempo;
1::bar => now;
60 => SetTempo;
1::bar => now;
beat / 4 => now;

midiStop => drumMachine.send;
beat => now;