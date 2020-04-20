#!/usr/bin/env bash
#See the various chapters of SRE-ifying this app.

usage() {
  cat <<-USAGE
$(basename $0)
Displays the chapters of SRE-ifying this app.
You can take any of the chapters shown and run \`BRANCH=<chapter> ./start_app.sh\`
to learn more.

This script takes no options.
USAGE
}

git branch -a | \
  grep -v 'master' | \
  grep 'origin' | \
  sed 's/.*origin\///'
