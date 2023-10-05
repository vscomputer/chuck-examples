//set up audio chain
SinOsc osc => ADSR env1 => NRev rev => dac;
0.5 => osc.gain;
(1::ms, 100::ms, 0.0, 1::ms) => env1.set;
0.1 => rev.mix;

//set up keyboard
Hid hi;
HidMsg msg;
if( !hi.openKeyboard( 0 ) ) me.exit();
<<< "keyboard '" + hi.name() + "' ready", "" >>>;

fun void PlayBeep(int key)
{
    key => Std.mtof => osc.freq;
    1 => env1.keyOn;
    100::ms => now;
    1 => env1.keyOff;
}

while( true )
{    
    hi => now; 
    while( hi.recv( msg ) && msg.which != 29  ) //ignore ctrl key
    {        
        if( msg.isButtonDown() )
        {
            spork ~ PlayBeep(msg.ascii);            
        }                
    }
}