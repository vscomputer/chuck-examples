me.dir() + "alvin.ck" => string alvin;
me.dir() + "simon.ck" => string simon;
me.dir() + "theodore.ck" => string theodore;

ChordProvider cp;
Chords chords;
BPM bpm;

Machine.add(alvin) => int stopAlvin;
Machine.add(simon) => int stopSimon;
Machine.add(theodore) => int stopTheodore;
80 => bpm.tempo;

 

0 => cp.position;
chords.minor @=> cp.chord;
bpm.bar => now;

5 => cp.position;
chords.minor @=> cp.chord;
bpm.bar => now;

7 => cp.position;
chords.sus4 @=> cp.chord;
bpm.bar => now;

7 => cp.position;
chords.dom7 @=> cp.chord;
bpm.bar => now;

0 => cp.position;
chords.minor @=> cp.chord;
bpm.quarterNote * 2 => now;
chords.dom7 @=> cp.chord;
bpm.quarterNote * 2 => now;

5 => cp.position;
chords.minor @=> cp.chord;
bpm.quarterNote * 2 => now;
8 => cp.position;
chords.maj7 @=> cp.chord;
bpm.quarterNote * 2 => now;

7 => cp.position;
chords.sus4 @=> cp.chord;
bpm.bar => now;

chords.dom7 @=> cp.chord;
bpm.bar => now;

Machine.remove(stopAlvin);
Machine.remove(stopSimon);
Machine.remove(stopTheodore);