#!/usr/bin/env bash
#
# Test the series code
#

source "$REG_DIR/scaffold"

cmd setup_repo

# base
cmd guilt series

touch .git/patches/master/additional
touch .git/patches/master/additional~
echo non-existent >> .git/patches/master/series

# missing
cmd guilt series -m
