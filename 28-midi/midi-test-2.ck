//set up audio chain
LPF lpf => NRev rev => Dyno dyno => dac;
500 => lpf.freq;
5 => lpf.Q;
0.05 => rev.mix;

//Get MIDI device input
MidiIn midi;
MidiMsg msg;
0 => int device;
if( me.args() ) me.arg(0) => Std.atoi => device;
if( !midi.open( device ) ) me.exit();
<<< "MIDI device:", midi.num(), " -> ", midi.name() >>>;

fun void PlayBeep(int key, int velocity)
{
    SawOsc osc => ADSR env1 => lpf;
    0.25 * (velocity / 127.0) => osc.gain;
    (1::ms, 1000::ms, 0.0, 1::ms) => env1.set;
    

    key => Std.mtof => osc.freq;
    1 => env1.keyOn;
    1000::ms => now;
    1 => env1.keyOff;
}

while( true )
{    
    midi => now; 
    while( midi.recv( msg ) ) 
    {        
        if( msg.data1 == 144 )
        {
            spork ~ PlayBeep(msg.data2, msg.data3);    
            <<< msg.data1, msg.data2, msg.data3 >>>;        
        }
        if( msg.data1 == 176)
        {
            4000 * (msg.data3 / 127.0) => lpf.freq;
        }
    }
}