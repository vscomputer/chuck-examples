TriOsc osc => ADSR env => dac;
FileIO io;
StringTokenizer tok;

0.2 => osc.gain;
1.2::second => dur bar;
48 => int offset;

<<< io.open("tri-1.txt", FileIO.READ) >>>;

while(io.more())
{           
    io.readLine() => string line;        
    
    if (line.find("//") == 0 )
    {
        line => ProcessComment;
    }
    else if (line.find("r") == 0)
    {                        
        line => ProcessRest;
    }
    else
    {                        
        line => ProcessNote;
    }                        
}

fun void ProcessComment(string line)
{
    <<< line >>>;
}

fun void ProcessRest(string line)
{
    tok.set(line);
    tok.next() => string rest;
    tok.next() => Std.atoi => int div;
    <<< rest, div >>>;
    bar / div => now;
}

fun void ProcessNote(string line)
{
    tok.set(line);
    tok.next() => Std.atoi => int note;
    tok.next() => Std.atoi => int div;
    <<< note, div >>>;
    note + offset => Std.mtof => osc.freq;    
    bar / div => dur duration;
    (1::ms, duration, 0, 1::ms) => env.set;
    1 => env.keyOn;
    ProcessExtras(tok);
    duration => now;
}

fun void ProcessExtras(StringTokenizer tok)
{
    while(tok.more())
    {        
        tok.next() => string extra;
        // if(extra.find("p")==0)
        // {
        //     extra.substring(1) => Std.atof => pan.pan;
        // }        
    }
}