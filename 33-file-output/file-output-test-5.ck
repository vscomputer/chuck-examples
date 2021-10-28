int divisor;
int offset;

FileIO partFile;
"part.txt" => string fileName;
partFile.open( fileName, FileIO.WRITE );

fun void SetDivisor(int newDivisor)
{
    newDivisor => divisor;
    <<< "Divisor is", divisor >>>;
}
SetDivisor(16);

fun void SetOffset(int newOffset)
{
    newOffset => offset;
    <<< "Offset is", offset >>>;
}
SetOffset(60);

SinOsc osc => ADSR env => dac;
0.25 => osc.gain;
(1::ms, 100::ms, 0, 1::ms) => env.set;

Hid hi;
HidMsg msg;
1 => int keepGoing;

if( !hi.openKeyboard( 0 ) ) me.exit();
<<< "keyboard '" + hi.name() + "' ready,", "Step sequencer awaiting input for", fileName >>>;

fun void HandleNote(int note)
{
    partFile <= note <= " " <= divisor <= IO.newline();
    <<< note, divisor >>>;
    PlayBeep(note);
}

fun void HandleRest()
{
    partFile <= "R" <= " " <= divisor <= IO.newline();
    <<< "R", divisor >>>;    
}

fun void PlayBeep(int note)
{
    note => Std.mtof => osc.freq;
    1 => env.keyOn;
}

fun void HandleKeyPress(int which)
{
    //handle each key individually :(
    
    //Handle offset changes
    if(which == 44) // z
    {
        SetOffset(offset - 12);
    }
    if(which == 45) // y
    {
        SetOffset(offset + 12);
    }

    //Handle divisor changes
    if(which == 2)
    {
        SetDivisor(1);
    }
    if(which == 3)
    {
        SetDivisor(2);
    }
    if(which == 4)
    {
        SetDivisor(3);
    }
    if(which == 5)
    {
        SetDivisor(4);
    }
    if(which == 7)
    {
        SetDivisor(6);
    }
    if(which == 9)
    {
        SetDivisor(8);
    }
    if(which == 10)
    {
        SetDivisor(16);
    }
    if(which == 11)
    {
        SetDivisor(32);
    }

    //Computer keyboard
    if(which == 30) //a
    {
        HandleNote(offset);
    }
    if(which == 31) //s
    {
        HandleNote(offset + 2);
    }
    if(which == 32) //d
    {
        HandleNote(offset + 4);
    }
    if(which == 33) //f
    {
        HandleNote(offset + 5);
    }
    if(which == 34) //g
    {
        HandleNote(offset + 7);
    }
    if(which == 35) //h
    {
        HandleNote(offset + 9);
    }
    if(which == 36) //j
    {
        HandleNote(offset + 11);
    }
    if(which == 37) //k
    {
        HandleNote(offset + 12);
    }
    if(which == 17) //w
    {
        HandleNote(offset + 1);
    }
    if(which == 18) //e
    {
        HandleNote(offset + 3);
    }
    if(which == 20) //t
    {
        HandleNote(offset + 6);
    }
    if(which == 21) //y
    {
        HandleNote(offset + 8);
    }
    if(which == 22) //u
    {
        HandleNote(offset + 10);
    }

    //rest
    if(which == 25) //p
    {
        HandleRest();
    }

    //exit
    if(which == 1)
    {
        0 => keepGoing;
    }

}

while( keepGoing == 1 )
{
    hi => now;

    while( hi.recv( msg ) && msg.which != 29  ) //ignore ctrl key
    {
        if( msg.isButtonDown() )
        {
            HandleKeyPress(msg.which);
        }                
    }
}
<<< "wrote to", fileName >>>;
partFile.close();