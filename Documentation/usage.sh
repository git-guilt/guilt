#!/bin/sh

set -e
name=$(basename $1)
u=$(grep '^USAGE="' $1) || {
	echo "Cannot find usage for $name" >&2
	exit 1
}
u=$(echo "$u" |  sed 's/USAGE="//; s/"$//')
echo "'guilt ${name#guilt-}' $u"  > usage-$name.txt
