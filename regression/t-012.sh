#!/usr/bin/env bash
#
# Test that all commands that should fail when run from
# $GUILT_DIR/$branch do indeed fail.  This file only tests command
# that are useful without any argument; the rest are tested in
# t-013.sh.  Commands that should work are tested in t-014.sh.
#
# Here is a table of all commands, if they should fail or not when run
# from $BUILT_DIR/$branch, and where that is tested.  The table is
# sorted on command name.
#
# +---------------+---------+--------------+
# | command       | should  | tested       |
# |               | work?   |              |
# +---------------+---------+--------------+
# | add           | no      | t-013.sh     |
# +---------------+---------+--------------+
# | applied       | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | branch        | no      | t-012.sh     |
# +---------------+---------+--------------+
# | commit        | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | delete        | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | diff          | no      | t-012.sh     |
# +---------------+---------+--------------+
# | export        | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | files         | no      | t-012.sh     |
# +---------------+---------+--------------+
# | fold          | no      | t-012.sh     |
# +---------------+---------+--------------+
# | fork          | no      | t-012.sh     |
# +---------------+---------+--------------+
# | goto          | no      | t-013.sh     |
# +---------------+---------+--------------+
# | graph         | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | guard         | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | header        | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | help          | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | import        | no      | t-013.sh     |
# +---------------+---------+--------------+
# | import-commit | no      | t-013.sh     |
# +---------------+---------+--------------+
# | init          | no      | t-012.sh     |
# +---------------+---------+--------------+
# | new           | no      | t-013.sh     |
# +---------------+---------+--------------+
# | next          | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | patchbomb     | unknown | interactive: |
# |               |         | untestable   |
# +---------------+---------+--------------+
# | pop           | no      | t-012.sh     |
# +---------------+---------+--------------+
# | prev          | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | push          | no      | t-012.sh     |
# +---------------+---------+--------------+
# | rebase        | no      | t-012.sh     |
# +---------------+---------+--------------+
# | refresh       | no      | t-012.sh     |
# +---------------+---------+--------------+
# | rename        | no      | t-013.sh     |
# +---------------+---------+--------------+
# | repair        | unknown | interactive: |
# |               |         | untestable   |
# +---------------+---------+--------------+
# | rm            | no      | t-013.sh     |
# +---------------+---------+--------------+
# | select        | no      | t-012.sh     |
# +---------------+---------+--------------+
# | series        | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | status        | no      | t-012.sh     |
# +---------------+---------+--------------+
# | top           | yes     | t-014.sh     |
# +---------------+---------+--------------+
# | unapplied     | yes     | t-014.sh     |
# +---------------+---------+--------------+

source "$REG_DIR/scaffold"

cmd setup_repo

cmd guilt push

dir=.git/patches/master

# First, we test all commands that don't require any arguments.
tests="branch diff files fold fork init pop push rebase refresh select status"
for t in $tests; do
	(cd $dir && shouldfail guilt $t)
done
