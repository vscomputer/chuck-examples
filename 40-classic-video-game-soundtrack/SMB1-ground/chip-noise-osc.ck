public class ChipNoiseOsc
{   
    Noise osc => ADSR env => LPF lpf => dac; 
    FileIO io;
    StringTokenizer tok;

    0.2 => osc.gain;
    1.2::second => dur bar;
    36 => int offset;

    fun void SetBarDuration(dur newDuration)
    {
        newDuration => bar;
        <<< "bar length is", bar / 44100 >>>;
    }

    fun void PlayFile(string fileName)
    {
        <<< io.open(fileName, FileIO.READ) >>>;
        while(io.more())
            {           
            io.readLine() => string line;        
            
            if (line.find("//") == 0 || line.length() == 0)
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
        
        bar / div => dur duration;
        SetNoise(note, duration);
        1 => env.keyOn;
        ProcessExtras(tok);
        duration => now;
        1 => env.keyOff;
    }

    fun void SetNoise(int note, dur duration)
    {
        if(note == 1)
        {
            (44100 / 16) * 1 => lpf.freq;
            (1::ms, duration / 8, 0.0, 1::ms) => env.set;
        }
        if(note == 2)
        {            
            (44100 / 16) * 4 => lpf.freq;
            (1::ms, duration / 8, 0.0, 1::ms) => env.set;
        }
        if(note == 3)
        {
            (44100 / 16) * 4 => lpf.freq;
            (1::ms, duration, 0.0, 1::ms) => env.set;
        }
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
}