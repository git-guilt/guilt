#!/usr/bin/env bash
#
# Test that all commands that should fail when there is no commit
# indeed do fail in a controlled way.
#

source "$REG_DIR/scaffold"

cmd guilt init
cmd list_files
# To ensure we get predictable output, we copy the file locally before
# we add it.  We can't have "cmd" seeing "$REG_DIR".
cp "$REG_DIR/data/add.patch" add.patch
cmd guilt import add.patch
rm add.patch
cmd list_files
shouldfail guilt new abc
cmd guilt applied
cmd guilt unapplied
shouldfail guilt push
shouldfail guilt pop
shouldfail guilt branch foo
cmd guilt diff
cmd guilt diff -z
cmd guilt export expdir
cmd rm expdir/series expdir/add.patch
cmd rmdir expdir
cmd guilt files
shouldfail guilt fold
shouldfail guilt fork
shouldfail guilt goto add.patch
shouldfail guilt graph
shouldfail guilt guard
shouldfail guilt header
# Not tested: "guilt help". The usage text changes too often.
shouldfail guilt import-commit HEAD
cmd guilt next
# Not tested: "guilt patchbomb". Too hard.
cmd guilt prev
shouldfail guilt rebase
shouldfail guilt refresh
cmd guilt rename add.patch addfile.patch
shouldfail guilt repair --full
cmd touch testfile.txt
cmd guilt add testfile.txt

# "guilt rm" only works if the file is committed.  Here, we get an
# error message where git tells us to use the "-f" option.  The "guilt
# rm" command does not support that option, so we can't use that.
shouldfail guilt rm testfile.txt

shouldfail guilt select --reapply foo
cmd guilt series
cmd guilt status
cmd guilt top
cmd guilt unapplied

# A no-op when no patch is applied.
cmd guilt commit -a

# Note that "guilt delete" removes addfile.patch from the series file,
# but keeps the actual file on disk.  This is expected.
cmd guilt delete addfile.patch

cmd list_files
