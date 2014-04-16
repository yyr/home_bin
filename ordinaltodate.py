#!/usr/bin/env python
""" Usage example:
    $ %s 735300
    2014-03-08 """

import sys
import datetime


if len(sys.argv) < 2:
    print('Insufficient number of  arguments.')
    print(__doc__ % sys.argv[0])
    # sys.exit('Usage: %s <integer number>' % sys.argv[0])
else:
    print(datetime.date.fromordinal(int(sys.argv[1])))
