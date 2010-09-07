#!/usr/bin/perl
#    =**************************************
#    = Name: BASH History Cleaner
#    = Description:This will scan your ~/.bas
#    =     h_history file for commands specified in
#    =     the @commands array and remove them. I u
#    =     se this mainly to remove su from the his
#    =     tory, as well as clean up the cd's and s
#    =     tuff.
#    If you want it to it will back up the file first.
#    This would work well as a cron job. Just make sure it's run by the user whose home directory will be scanned (it takes the home directory from the environment).
#    = By: Ryan F
#    =
#    = Assumes:Adapt the code to your use bef
#    =     ore you run it. Default will NOT make a
#    =     backup of the file. It works on my PC, I
#    =     make no guarantees that it will work on
#    =     yours.
#    =
#    =This code is copyrighted and has    = limited warranties.Please see http://w
#    =     ww.Planet-Source-Code.com/vb/scripts/Sho
#    =     wCode.asp?txtCodeId=640&lngWId=6    =for details.    =**************************************
#

    # This script cleans your ~/.bash_history of certain commands
    # I use this mainly to remove sudo references
    # You could either run it yourself or (probably beter) run it from cron
    # Written by Ryan F
    # Note: This is not foolproof- even after adjusting to prevent skipped
    # commands, it still does
    use Tie::File;
    # Make a backup (named .bash_hist-bak<date> in day-month-year format)?
    # Values are 'True', 'False' --Default False
    $MAKEBACKUP='False';
    # Get location of history file (assuming in home dir)
    $Home= $ENV{'HOME'};
    $HistFile= "$Home/.bash_history";
    # Print messages to SDTOUT?
    $PrintMes = 'True';
    $DebugMes = 'False';
    # List of commands to remove
    @commands= ('su','sudo','cd','ls','less','more','exit','man','info','cat',
    		'chown','chgrp','env');
    #Make sure file exists
    -f $HistFile or die('Cannot open history file. Exiting');
    # Back up .bash_history
    if ($MAKEBACKUP eq "True")
    {
    # Get date- does anyone know how to do this without a tmp variable?
    ($tmp,$tmp,$tmp,$mday,$mon,$yr,$tmp,$tmp,$tmp)= localtime(time);

    $theDate= sprintf("%02d%2d%4d",$mon+1,$mday,$yr+1900); # $theDate;
    system("cp",$HistFile, "$Home/.bash_hist-bak$theDate");
    };
    # First grab the first word of command, check against list.
    # Then, if applicable, check after all <,>,|.
    tie @cmdFile, 'Tie::File', $HistFile or die "Cannot open $HistFile";
    # Five times through should be enough--
    # Not very efficient, but I couldn't get anything else
    # to work very well
    for (0..4)
    {
    # Get num of records
    $numCmd= @cmdFile -1;
    if ($PrintMes eq 'True') {
    print '$numCmd=', $numCmd,"\n";
    }
    for $i (0..$numCmd)
    {
    # Use a different array so we don't lose the arguments to other
    # programs in $HistFile
    $theCmd[$i]= $cmdFile[$i];
    if ($DebugMes eq 'True') {
    print "\$theCmd[$i]=", "$theCmd[$i]\t\t";
    }
    $theCmd[$i] =~ s/^(\w+)\b.*/\1/;
    if ($DebugMes eq 'True') {
    print "\$theCmd[$i]=", "$theCmd[$i]\n";
    }
    foreach $command (@commands)
    {
    if ($command eq $theCmd[$i])
    {
    # PROBLEM: Number of recs shrinks- so line 73 ends up using ''
    # a lot on next iteration (highly inneficient)
    $tmp= splice @cmdFile, $i, 1 or die 'Cannot splice';
    if ($DebugMes eq 'True') {
    	 print 'Removed=',"$tmp\n";
    	}
    	# Prevent skipping lines
    $i--;
    }
    }
    }
    $firstThru=0;
    }
    untie @cmdFile;
