#!/usr/bin/env bash
set -e
BRANCH="${BRANCH:-master}"
NESTED="${NESTED:-false}"
NOBUILD="${NOBUILD:-false}"

usage() {
  cat <<-USAGE
$(basename $0)
Starts the webapp used during the "Boost Your Apps" SRE Webinar.


Arguments:
  --help, -h           Displays this help message.
  --version, -v        Displays the version.

Environment variables:
  BRANCH=[$BRANCH]     Sets the branch (chapter) to use for this repo and the app's backend.
                       (Everything on the frontend is on 'master'.)

  NOBUILD=[$NOBUILD]   This script will rebuild Docker images used for this app by default.
                       Set NOBUILD to 'true' to disable this.

Internal environment variables:
  NESTED=[$NESTED]     We use 'exec' to relaunch this script when one provides
                       a branch name to the BRANCH environment variable so that
                       it can start all of the services defined therein.

                       NESTED is set when this occurs to prevent the script from
                       continuously reloading itself when a BRANCH has been set.

Questions? Contact hello@contino.io or submit an issue to
https://github.com/contino/sre_webinar_app.
USAGE
}

version() {
  echo "$(basename $0), version $(git rev-parse HEAD | head -c 8)"
}

clone() {
  url="$1"
  directory="${2:-.}"
  git clone "$1" "$2"
}

clone_frontend() {
  test -d ./frontend || clone https://github.com/Razz/Project_Organizer_FrontEnd ./frontend
}

clone_backend() {
  test -d ./backend || clone https://github.com/Razz/Project_Organizer_BackEnd ./backend
  if test "$BRANCH" != "master"
  then
    GIT_DIR=./backend/.git git checkout "$BRANCH"
  fi
}

initialize_backend() {
  if test "$NOBUILD" == "false"
  then
    docker-compose build backend-init
  fi
  docker-compose run --rm backend-init
}

start_app() {
  if test "$NOBUILD" == "false"
  then
    docker-compose up --build database frontend backend
  else
    docker-compose up database frontend backend
  fi
}

vendor_frontend_node_modules_for_speed() {
  docker-compose run --rm vendor-frontend
}

if [ "$1" == '--help' ] || [ "$1" == '-h' ]
then
  usage
  exit 0
fi

if [ "$1" == '--version' ] || [ "$1" == '-v' ]
then
  version
  exit 0
fi

for app in docker-compose git
do
  if ! &>/dev/null which "$app"
  then
    >&2 echo "ERROR: Ensure that you have '$app' installed on your machine."
    exit 1
  fi
done

if test "$BRANCH" == "master" && ! test -d ./frontend/node_modules
then
  >&2 echo "INFO: Welcome to the SRE webinar app"'!'" We're doing some \
optimizations to make 'flipping' through chapters faster."
  vendor_frontend_node_modules_for_speed
  >&2 echo "INFO: Optimizations complete."
fi

if test "$BRANCH" != "master" && test "$NESTED" == "false"
then
  >&2 echo "INFO: Checking out branch: $BRANCH"
  git checkout "$BRANCH" && exec env NESTED=true "$(basename $0)" || exit 1
fi

clone_frontend &&
  clone_backend &&
  initialize_backend &&
  start_app
