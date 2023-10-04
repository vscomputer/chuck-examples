0 => int removeSynth;
0 => int removePanning;
me.dir() + "live.ck" => string synthFile;
me.dir() + "panning.ck" => string panFile;

1::second / 2 => dur beat;

while(true)
{
    Machine.remove(removeSynth);
    Machine.remove(removePanning);

    Machine.add(synthFile) => removeSynth;
    Machine.add(panFile) => removePanning;
    beat * 16 => now;
}