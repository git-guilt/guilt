#!/usr/bin/env bash
#
# Test the status code
#

source "$REG_DIR/scaffold"

cmd setup_repo
cmd guilt push -a

# Untracked files are reported with a "?" prefix.
echo x > untracked1
mkdir -p dir
echo y > dir/untracked2
echo z >> def
# Names with spaces and backslashes must be printed unchanged.
echo s > "un tracked"
echo t > 'back\slash'
cmd guilt status
cmd guilt status -x
cmd guilt status -m
cmd guilt status -n

# Before the first commit, every tracked file is reported as added.
mkdir fresh
cd fresh
git init -q
cmd guilt init
echo a > a
mkdir sub
echo b > sub/b
echo c > "sp ace"
cmd git add a sub/b "sp ace"
cmd guilt status
