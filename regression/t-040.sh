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
cmd git add a sub/b
cmd guilt status
