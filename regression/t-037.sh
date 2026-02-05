#!/usr/bin/env bash
#
# Test the goto code
#
source "$REG_DIR/scaffold"

function fixup_time_info
{
	cmd guilt pop
	touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
	cmd guilt push
}

cmd setup_repo

#
# incremental push by 1, numerically
#
guilt series -n | while read n rest ; do
	cmd guilt goto -n $n

	cmd list_files
done

shouldfail guilt goto -n 5	# There are only 4 patches in the series.
shouldfail guilt push

# Pop everything
cmd guilt goto -n 0

cmd list_files

#
# incremental push by 1, by name
#
guilt series | while read patch ; do
	cmd guilt goto $patch

	cmd list_files
done

#
# incremental pop by 1
#
guilt series -n | _tac | while read n patch ; do
	cmd guilt goto -n `expr $n - 1`
	cmd list_files
done

#
# Some random moving about
#

cmd guilt goto add
cmd list_files
cmd guilt goto mode
cmd list_files
cmd guilt goto modify
cmd list_files
cmd guilt goto -n 4
cmd list_files
cmd guilt goto -n 1
cmd list_files
cmd guilt goto -n 3
cmd list_files
cmd guilt goto -n 0
cmd list_files
cmd guilt goto -n 4
cmd list_files
shouldfail guilt goto -n 99
shouldfail guilt goto nope
cmd list_files

# Test the substring matching.  This matches both "modify", "remove"
# and "mode".
shouldfail guilt goto mo

# This regexp uniquely maches mode.
cmd guilt goto mo.e
cmd list_files

# This regexp uniquely matches "modify", when unanchored.
cmd guilt goto 'd[i]f'
cmd list_files

# This substring uniquely matches "add"
cmd guilt goto dd
cmd list_files
