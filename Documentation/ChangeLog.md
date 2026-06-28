## Release 0.37.1

Minor fixes after the main release.

Summary of changes:

 - New features:
   - Add `guilt push -C` to specify diff context
   - Handle multiple patches for `guilt delete`
   - Add `guilt series -m` to show missing patches
 - Update contribution file
 - Improve `Documentation` `Makefile` (dependencies, minor fixes and better error handling)
 - Update bash completion script
 - Make source code more coherent
 - Better check for working tree
 - Add more regression tests
 - Speed up removing references
 - Other minor fixes (like additional quoting or typos)

_Axel Beckert_ (1):

 - Fix typos found by lintian

_Frediano Ziglio_ (21):

 - docs: Rename Contribute file to prepare to change format
 - docs: Update Contributing file
 - Use target macro instead of rewriting it
 - Split rule that can create 2 files
 - Use immediate expansion of macro instead of lazy expansion
 - Adjust documentation build dependencies
 - Improve `usage.sh` script
 - Compute dependencies from usage TXT files in Makefile
 - Add missing commands to bash completion
 - Implement `guilt push -C` to set context
 - Quote variables in Makefile
 - Do not use exec to just change program arguments
 - Improve `unset_guards` function
 - Avoid using obsolete `guilt-XXX` commands
 - Quote some reference names
 - Use `remove_ref` instead of `remove_patch_refs` for single patch
 - Simplify `remove_ref`
 - Speed up `remove_patch_refs` if possible
 - Add support to delete multiple patches at a time
 - Do not suggest applied patch completing guilt delete command
 - Add support for `guilt series -m`

_Per Cederqvist_ (10):

 - Remove a trailing blank line in `guilt-goto`
 - `do_get_header`: skip more fake mbox lines
 - Use sed instead of awk to print a given line
 - Consistently use spaces inside arithmetic expansions
 - Always explicitly pass the third argument to commit
 - Create a Docker image suitable for running the tests
 - Revert "Cache git toplevel directory"
 - Check working tree in many subcommands
 - Add test cases for running guilt from `$GUILT_DIR/$branch`
 - Ensure `git help` displays man pages from source during regression runs

## Release 0.37

New website, new release... and new maintainer.

After a chat with the original author, @jeffpc I decided to step up as a maintainer.

The intention is to preserve the original design but incorporate fixes and updates, in particular:

 - code written in POSIX shell using base system commands and awk;
 - compatibility with Linux, FreeBSD/Darwin and SunOS.

This version is a collection of changes found here and there plus changes from me and the company I work for.

Notable changes:

 - added `guilt rename` to rename patches (from _Viacheslav Galaktionov_);
 - added `guilt goto` go set current patch (from _Per Cederqvist_);
 - added `-n` option to `guilt series` to show patch numbers (from _Per Cederqvist_);
 - improved reflog messages (from _Per Cederqvist_);
 - avoid some collision with some configurations (from _Paul Molodowitch_);
 - better handling of `git format-patch` patches;
 - lot of compatibility patches for various systems;
 - better handling of patch names and guards;
 - lot of minor optimizations.

_Frediano Ziglio_ (70):

 - Fix indentation
 - Rewrite part of the guard code
 - Add a test for new implemented functions
 - Minor compatibilities for Alpine Linux
 - Compatibilty for FreeBSD
 - Simplify sed expressions
 - Account for different dd outputs
 - Fix regular expression
 - Fix portability getting file size
 - Replace expr call with arithmetic expansion $(( ))
 - Writes a test for do_get_header function
 - Improve format_last_modified performances on Linux
 - Cache toplevel directory
 - Reduce process creation for splitting name and email
 - Fix compatibility with OpenIndiana
 - Fix minor compatibility with AWK
 - Fix compatibility with OpenIndiana dd output
 - Fix compatibility with grep regular expression
 - Skip first "From " line from git format-patch style patches
 - Fix some erros inserting patches
 - Improve guilt import test
 - Fix function name in comment
 - Fix renaming patch name in series
 - Fix a portability bug for SunOS
 - Check all guards before setting them in set_guards
 - Fix "touch" command syntax for SunOS
 - Fix typo in message "sucessfully" -> "successfully"
 - Simplify while loop
 - Use --name-only option for diff-tree instead of filtering with cut
 - Update comments on header parsing
 - Parse patch fields using while loop
 - Do not create and destroy temporary files all over
 - Do not add manually changed files if we applied a patch
 - Simplify cat command
 - Fix tests using old git version
 - Simplify "guilt series -n"
 - Include "guilt rename" into commands failing checking repository
 - Test refs exists before trying to rename it
 - Add a test for guilt rename
 - Make sure we created temporary directory in push_patch
 - Makes sure we define variables before using them
 - Add bash completion script
 - Use cd_to_toplevel_cached for "git rename"
 - Fix a typo in a comment
 - Always use "applied" and "status" to access patch metadata
 - help: Do not call git commands
 - Search executables with find with a bit more compatible predicate
 - Create temporary directory from the main shell
 - Change metadata files pointed by links, not the links
 - Replace expr call with arithmetic expansion $(( ))
 - Use GNU Awk for SunOS
 - Use stat -c command to compute file size for SunOS
 - Improve error reporting for regression utilities
 - Avoid cat in regression utility
 - Improve make install/uninstall
 - Improve format_last_modified function for Linux and SunOS
 - Avoid to keep reopening files
 - Avoids create a temporary file for error reports
 - Use sed instead of awk to print a given line
 - Reduce calls to "cat" command
 - Use grep -x option
 - Update action version to use new Node.js
 - Avoid calling cat command in guilt-branch
 - Do not create a subprocess just to redirect output
 - Use sed to get the second to last
 - Avoid to call git twice to get symbolic reference
 - Avoid calling sed for stripping initial string
 - Cache git toplevel directory
 - Update release name
 - Remove support for git 1.5

_Paul Molodowitch_ (1):

 - use --no-ext-diff

_Per Cederqvist_ (12):

 - guilt-push: Update reflog for the first pushed patch
 - Remove duplicated code in the test scaffold
 - Fix error in guilt-rm(1): the files are removed, not added
 - regression: explicitly use the master branch
 - Minor tweaks to HOWTO.md
 - Add the -n option to "guilt series"
 - Add "guilt goto"
 - guilt-pop: Improve reflog messages
 - Provide better reflog strings for fold, new and refresh
 - Teach "git fold" to select the first unapplied patch by default
 - Create makefile.yml
 - run-tests: cat the logfile when running as a github action

_Simon Rowe_ (1):

 - Various speed ups

_Viacheslav Galaktionov_ (4):

 - guilt: add rename command
 - rename: fix syntax error
 - help: allow running outside of git repo
 - help: fallback to system-wide man pages
