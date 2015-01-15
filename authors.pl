#!/usr/bin/env perl
# Stole from old magit source code.
# :-)

/(\d{4}).*?_(.+)/&&\$a{$2}->{$1}for`git log --pretty=format:%aD_%an`;
print"Copyright (C) ".join(", ",sort keys %{$a{$_}})." $_.\n"for sort keys %a
