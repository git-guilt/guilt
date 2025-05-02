#!/usr/bin/env bash
#
# Test the fold code
#

source "$REG_DIR/scaffold"

cmd setup_repo

function fixup_time_info
{
	cmd guilt pop
	touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
	cmd guilt push
}

function empty_patch
{
	cmd guilt new "empty$1"
	fixup_time_info "empty$1"
}

function nonempty_patch
{
	if [ "$1" = -2 ]; then
		msg="Another commit message."
	else
		msg="A commit message."
	fi

	cmd guilt new -f -s -m "$msg" "nonempty$1"
	fixup_time_info "nonempty$1"
}

for using_diffstat in true false; do
	cmd git config guilt.diffstat $using_diffstat
	for patcha in empty nonempty; do
		for patchb in empty nonempty; do

			if [ $patcha = $patchb ]; then
				suffixa=-1
				suffixb=-2
			else
				suffixa=
				suffixb=
			fi

			echo "%% $patcha + $patchb (diffstat=$using_diffstat)"
			${patcha}_patch $suffixa
			${patchb}_patch $suffixb
			cmd guilt pop
			cmd guilt fold $patchb$suffixb
			fixup_time_info $patcha$suffixa
			cmd list_files
			cmd guilt pop
			cmd guilt delete -f $patcha$suffixa
			cmd list_files

		done
	done
done

# Test that "guilt fold" (without a filename) selects the next patch
# in the series.  First, create a series of 10 patches.
function create_n
{
	cmd guilt new $1
	echo $1 > number.txt
	git add number.txt
	cmd guilt ref
	fixup_time_info $1
}

function ensure
{
	cmd test `cat number.txt` -eq $1
}

for i in `seq 10`
do
	create_n $i
done

cmd guilt pop -a
cmd guilt push -n 4
cmd guilt fold
ensure 5
fixup_time_info 4
cmd list_files
cmd guilt fold
ensure 6
fixup_time_info 4
cmd list_files
cmd guilt push
ensure 7
cmd guilt push -a
ensure 10
# We can't fold a non-existing patch.
shouldfail guilt fold
cmd list_files
ensure 10
