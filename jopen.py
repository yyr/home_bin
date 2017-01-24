#!/usr/bin/env python
import sys

js = {
    "Journal of Physical Oceanography":
    "http://journals.ametsoc.org/toc/phoc/current",
    "BAMS: Bulletin of the American Meteorological Society.":
    "http://journals.ametsoc.org/toc/bams/current",
    "Journal of the Atmospheric Sciences":
    "http://journals.ametsoc.org/loi/atsc/current",
    "Monthly Weather Review": "http://journals.ametsoc.org/loi/mwre/current",
    "Journal of Climate": "http://journals.ametsoc.org/loi/clim/current",
    "Atmospheric Research":
    "http://www.sciencedirect.com/science/journal/01698095",
    "JGR Atmospheres":
    "http://agupubs.onlinelibrary.wiley.com/hub/jgr/journal/10.1002/%28ISSN%292169-8996/",
    "JMSJ: Journal of Meteorological Society of Japan.":
    "https://www.jstage.jst.go.jp/browse/jmsj",
    "Atmospheric Chemistry and Physics":
    "http://www.atmos-chem-phys.net/volumes_and_issues.html",
    "Climate Dynamics": "http://link.springer.com/journal/382"
}


def main(args=None):
    for c, j in enumerate(js.keys()):
        print("%i  - %s" % (c + 1, j))
    print("-1  - For all the links")
    useropt = raw_input()

    if useropt is None:
        print("Bad Input")
        sys.exit()
    else:
        import subprocess
        url = js.values()[int(useropt) - 1]
        proc = "firefox -url " + url
        print("Opening: " + url)
        subprocess.Popen(proc.split())


if __name__ == '__main__':
    main()
