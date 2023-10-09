SinOsc osc => ADSR env => dac;
env => NRev reverb => dac;
0.25 => osc.gain;
(1::ms, 100::ms, 0,1::ms) => env.set;
0.1 => reverb.mix;

OscIn oscIn;
OscMsg oscMsg;

9000 => oscIn.port;
oscIn.addAddress("/myOsc/Hello");

while(true)
{
    <<< "waiting for an OSC message..." >>>;
    oscIn => now;

    while(oscIn.recv(oscMsg) !=0)
    {
        oscMsg.getInt(0) => int note;
        <<< "Playing note", note >>>;
        note => Std.mtof => osc.freq;
        1 => env.keyOn;
    }
}