SinOsc osc => ADSR env => LPF lpf => Pan2 pan => dac;
(1::ms, 100::ms, 0, 1::ms) => env.set;

FileIO io;
StringTokenizer tok;
//<<<  >>>;
2::second => dur beat;
48 => int offset;

0.2 => osc.gain;

-1 => lpf.op;
1 => lpf.Q;

while(true)
{
    io.open("part.txt", FileIO.READ);
    while(io.more())
    {           
        io.readLine() => string line;                
        if(io.more())
        {
            if (line.find("//") == 0 )
            {
                line => ProcessComment;
            }
            else if (line.find("R") == 0)
            {                        
                line => ProcessRest;
            }
            else if (line.length() > 0)
            {                     
                line => ProcessNote;
            }
        }                        
    }    
    io.close();
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
    beat / div => now;
}

fun void ProcessNote(string line)
{    
    tok.set(line);
    tok.next() => Std.atoi => int note;
    tok.next() => Std.atoi => int div;
    <<< note, div >>>;
    note => Std.mtof => osc.freq;
    1 => env.keyOn;
    ProcessExtras(tok);
    beat / div => now;
}

fun void ProcessExtras(StringTokenizer tok)
{
    while(tok.more())
    {        
        tok.next() => string extra;
        if(extra.find("P")==0)
        {
            extra.substring(1) => Std.atof => pan.pan;
        }
        if(extra.find("F")==0)
        {
            extra.substring(1) => Std.atof => lpf.freq;
        }
        if(extra.find("Q")==0)
        {
            extra.substring(1) => Std.atof => lpf.Q;
        }
    }
}