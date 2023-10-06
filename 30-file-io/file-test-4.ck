FileIO io;

io.open("int.txt", FileIO.READ) => int success;

int display;
while(io.eof() == false)
{
    io => display;
    <<< display >>>;
}
