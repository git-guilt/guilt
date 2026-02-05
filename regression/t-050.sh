#!/usr/bin/env bash
#
# Test the series code
#

source "$REG_DIR/scaffold"

cmd setup_repo

cmd guilt series

cmd guilt series -v
cmd guilt series -n
cmd guilt series -n -v

guilt series | while read n ; do
	cmd guilt push

	cmd guilt series -v
	cmd guilt series -v -n
done

cmd list_files
