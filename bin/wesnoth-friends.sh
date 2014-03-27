#!/bin/bash
TMPFILE=`mktemp /tmp/wesnoth.prefs.XXXXXXXXXX`
wget --quiet -O${TMPFILE} " http://wesnoth.gamingladder.info/friends.php?download"
grep -v '^friends=' ~/.wesnoth/preferences > ~/.wesnoth/preferences2
cat $TMPFILE >> ~/.wesnoth/preferences2
mv ~/.wesnoth/preferences2 ~/.wesnoth/preferences
rm $TMPFILE
