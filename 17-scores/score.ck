<<< "score.ck" >>>;

me.dir() + "bass1.ck" => string bass1Filename;
me.dir() + "bass2.ck" => string bass2Filename;
me.dir() + "kick-snare.ck" => string kickSnareFilename;
me.dir() + "panning1.ck" => string panningFilename;
me.dir() + "hi-hat.ck" => string hiHatFilename;
me.dir() + "pad.ck" => string padFilename;

0.5::second => dur beat;

beat * 4 => dur bar;

//start with kick and snare, 4 bars
Machine.add(kickSnareFilename) => int kick;
4 * bar => now;
//add in bass2, 8 bars
Machine.add(bass2Filename) => int bass2;
8 * bar => now;
// add in hi hat, 4 bars
Machine.add(hiHatFilename) => int hats;
4 * bar => now;
//kill the kick and snare, 4 bars
Machine.remove(kick);
4 * bar => now;
//remove hi hat and bass 2
Machine.remove(bass2);
Machine.remove(hats);

//start the pad, 4 bars
Machine.add(padFilename) => int pad;
4 * bar => now;
//Add bass 1
Machine.add(bass1Filename) => int bass1;
4 * bar => now;
//add in panner, hats and kick, 8 bars
Machine.add(panningFilename) => int panner;
Machine.add(hiHatFilename) => hats;
Machine.add(kickSnareFilename) => kick;
8 * bar => now;
//kill bass1 and pad, start bass 2, 8 bars
Machine.remove(bass1);
Machine.add(bass2Filename) => int bass2;
Machine.remove(pad);
8 * bar => now;
//start pad back up, kill kick, 4 bars
Machine.add(padFilename) => pad;
Machine.remove(kick);
4 * bar => now;

//Kill everything but the kick, snare, and panner
Machine.remove(pad);
Machine.remove(hats);
Machine.remove(pad);
Machine.add(kickSnareFilename) => kick;
8 * bar => now;
//add the pad back in, 4 bars
Machine.add(padFilename) => pad;
4 * bar => now;
//remove pad, add bass, 4 bars
Machine.remove(pad);
Machine.add(bass1Filename) => bass1;
4 * bar => now;
//add hats, 8 bars
Machine.add(hiHatFilename) => hats;
8 * bar => now;
//remove panner, 8 bars
Machine.remove(panner);
8 * bar => now;
//remove hats and kick, end song
Machine.remove(hats);
Machine.remove(kick);
8 * bar => now;
//remove all the basses
Machine.remove(bass1);
Machine.remove(bass2);
