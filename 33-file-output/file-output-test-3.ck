FileIO fout;


fout.open( "out3.txt", FileIO.APPEND );

for(1 => int i; i <= 1000; i++)
{
    

    if( !fout.good() )
    {
        cherr <= "can't open file for writing..." <= IO.newline();
        me.exit();
    }

    fout <= i <= IO.newline();

}
fout.close();

