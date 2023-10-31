ChipTriOsc triOsc;

1.2::second => dur bar;
bar => triOsc.SetBarDuration;

spork ~ triOsc.PlayFile("tri-1.txt"); 
2::bar => now;

spork ~ triOsc.PlayFile("tri-2.txt"); 
4::bar => now;

spork ~ triOsc.PlayFile("tri-2.txt"); 
4::bar => now;