#!/usr/bin/env bash
#
# Test import-commit with a commit subject longer than 80 characters
#

source "$REG_DIR/scaffold"

cmd setup_git_repo

cmd git tag base

echo a > a
cmd git add a
cmd git commit -m "This subject line is deliberately made much longer than eighty characters to test truncation"

cmd guilt init
cmd guilt import-commit base..HEAD
cmd guilt series
