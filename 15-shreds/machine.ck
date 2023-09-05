me.dir() + "kick.ck" => string kickFilename;
me.dir() + "arpeggio.ck" => string arpFilename;

0.5::second => dur beat;

Machine.add(kickFilename) => int kickId;

beat * 4 => now;

Machine.replace(kickId, arpFilename);

beat * 4 => now;

Machine.replace(kickId, kickFilename);
Machine.add(arpFilename) => int arpId;

beat * 4 => now;

Machine.remove(kickId);
Machine.remove(arpId);