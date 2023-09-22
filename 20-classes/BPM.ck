public class BPM
{
    dur myDuration[3];
    static dur quarterNote, eighthNote, sextupletNote, bar;
    
    fun void tempo(float beat)
    {
        60.0/(beat) => float SPB;
        SPB::second => quarterNote;
        quarterNote / 2 => eighthNote;
        eighthNote / 3 => sextupletNote;
        quarterNote * 4 => bar;
        
        [quarterNote, eighthNote, sextupletNote] @=> myDuration;
    }
}