#!/usr/bin/env bash
#
# Test that commands fail cleanly when no temporary file can be created
#

source "$REG_DIR/scaffold"

# usage: failing_mktemp <cmd>..
# Run a command with a mktemp that always fails.
function failing_mktemp
{
	(
		mkdir -p "$REPODIR.bin"
		printf '#!/bin/sh\nexit 1\n' > "$REPODIR.bin/mktemp"
		chmod +x "$REPODIR.bin/mktemp"
		PATH="$REPODIR.bin:$PATH" "$@"
		rv=$?
		rm -rf "$REPODIR.bin"
		exit $rv
	)
}

# usage: fixup_time_info <patch>
# The commit date of an applied patch is taken from the patch file, so
# reset it after the file changed, to get reproducible hashes.
function fixup_time_info
{
	cmd guilt pop
	touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
	cmd guilt push
}

cmd setup_repo

cmd guilt push -n 3
echo "change" >> def

shouldfail failing_mktemp guilt refresh
shouldfail failing_mktemp guilt header
cmd list_files

# With a working mktemp the same commands work.
cmd guilt refresh
fixup_time_info remove
cmd guilt header

shouldfail failing_mktemp guilt fold mode
cmd list_files
cmd guilt fold mode
fixup_time_info remove
cmd list_files
