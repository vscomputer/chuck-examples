ChipTriOsc triOsc;
ChipPulseOsc pulseOsc1;
ChipPulseOsc pulseOsc2;

1.2::second => dur bar;
bar => triOsc.SetBarDuration;
bar => pulseOsc1.SetBarDuration;

0.25 => pulseOsc1.SetPulseWidth;
0.25 => pulseOsc2.SetPulseWidth;

spork ~ triOsc.PlayFile("tri-1.txt"); 
spork ~ pulseOsc1.PlayFile("p1-1.txt"); 
spork ~ pulseOsc2.PlayFile("p2-1.txt"); 
2::bar => now;

spork ~ triOsc.PlayFile("tri-2.txt"); 
spork ~ pulseOsc1.PlayFile("p1-2.txt");
spork ~ pulseOsc2.PlayFile("p2-2.txt"); 
4::bar => now;

spork ~ triOsc.PlayFile("tri-2.txt"); 
spork ~ pulseOsc1.PlayFile("p1-2.txt");
spork ~ pulseOsc2.PlayFile("p2-2.txt"); 
4::bar => now;