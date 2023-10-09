dac => WvOut wvOut => blackhole;

"doowop.wav" => wvOut.wavFilename;

0.5::second => dur beat;

fun void PlayNote(int note, dur duration)
{
    60 => int offset;
    TriOsc osc => ADSR env => dac;
    0.25 => osc.gain;
    note + offset => Std.mtof => osc.freq;
    (1::ms, duration - 2::ms,0, 1::ms) => env.set;
    1 => env.keyOn;
    duration => now;
}

fun void PlayMelody()
{
    1.5::beat => now;
    PlayNote(16, 0.5::beat);
    PlayNote(17, 0.5::beat);
    PlayNote(16, 0.5::beat);
    PlayNote(14, 0.5::beat);
    PlayNote(12, 0.5::beat);

    PlayNote(9, 1.5::beat);
    PlayNote(16, 0.5::beat);
    PlayNote(17, 0.5::beat);
    PlayNote(16, 0.5::beat);
    PlayNote(14, 0.5::beat);
    PlayNote(12, 0.5::beat);

    PlayNote(11, 1.5::beat);
    1.5::beat => now;
    PlayNote(9, 0.5::beat);
    PlayNote(7, 0.5::beat);

    PlayNote(9, 0.5::beat);
    PlayNote(12, 0.5::beat);
    PlayNote(9, 0.5::beat);
    PlayNote(7, 0.5::beat);
    2::beat => now;

    4::beat => now;
}


fun void PlayChords()
{
    for (0 => int j; j < 2; j++)
    {
        for( 0 => int i; i < 4; i++)
        {
            spork ~  PlayNote(0, 1::second);
            spork ~  PlayNote(4, 1::second);
            spork ~  PlayNote(7, 1::second);
            0.5::second => now;
        }

        for( 0 => int i; i < 4; i++)
        {
            spork ~  PlayNote(-3, 1::second);
            spork ~  PlayNote(0, 1::second);
            spork ~  PlayNote(4, 1::second);
            0.5::second => now;
        }

        for( 0 => int i; i < 4; i++)
        {
            spork ~  PlayNote(-10, 1::second);
            spork ~  PlayNote(-7, 1::second);
            spork ~  PlayNote(-3, 1::second);
            0.5::second => now;
        }

        for( 0 => int i; i < 4; i++)
        {
            spork ~  PlayNote(-5, 1::second);
            spork ~  PlayNote(-1, 1::second);
            spork ~  PlayNote(2, 1::second);
            0.5::second => now;
        }
    }

        spork ~  PlayNote(0, 1::second);
        spork ~  PlayNote(4, 1::second);
        spork ~  PlayNote(7, 1::second);
        0.5::second => now;
        1::second => now;
}

// spork ~ PlayMelody();
// 4::beat => now;
spork ~ PlayChords();
18::second => now;


