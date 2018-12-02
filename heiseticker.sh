#!/bin/bash

# heiseticker.sh
#
# Script to parse the heise.de news ticker on the command line
#
# Needs feedstail:
#
# sudo apt-get install python-pip
# sudo pip install feedstail
#
#
# Thanks to the sixgun.org forum for helping me with this
# http://sixgun.org/forum/viewtopic.php?pid=67771
#
# New sed magic by mike.dld from Stack Overflow
# http://stackoverflow.com/questions/21960789/complex-changes-to-a-url-with-sed/21960947#21960947
#
# Code by Fabian A. Scherschel <fab@sixgun.org>

feedstail -u http://www.heise.de/newsticker/heise-atom.xml -r -i 60 -f "{published}> {title} {link}" | sed 's/^\(.\{3\}\)\(.\{13\}\)\(.\{6\}\)\(.\{3\}\)\(.*\)/\1\3\5/;s|\(://[^/]*/\).*\(-[0-9][0-9]*\)\.html/.*|\1\2|'
