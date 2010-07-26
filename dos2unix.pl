#!/usr/bin/perl

#In Windows, the end of a line is CRLF (Carriage-Return, Line-Feed). In Unix-like systems, it is just LF. So when you try to run that script, every line has an extra CR on the end.

die "Usage: $0 < files >\n" unless @ARGV;

for $file (@ARGV) 
{
    open IN, $file or die "$0: Cannot open $file for input!\n";

    my @lines = <IN>;

    close IN;
    open OUT, "> $file" or die "$0: Cannot open $file for output!\n";

    s/\r$// for @lines;
    print OUT for @lines;
}
