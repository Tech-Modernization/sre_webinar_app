#!/usr/bin/env bash
set -e
BRANCH="${BRANCH:-master}"
NESTED="${NESTED:-false}"

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
  if test "$BRANCH" != "master" && test "$NESTED" == "false"
  then
    GIT_DIR=./backend/.git git checkout "$BRANCH"
  fi
}

initialize_backend() {
  docker-compose run --rm backend-init
}

start_app() {
  docker-compose up database frontend backend
}

for app in docker-compose git
do
  if ! &>/dev/null which "$app"
  then
    >&2 echo "ERROR: Ensure that you have '$app' installed on your machine."
    exit 1
  fi
done

if test "$BRANCH" != "master" && test "$NESTED" == "false"
then
  >&2 echo "INFO: Checking out branch: $BRANCH"
  git checkout "$BRANCH" && exec env NESTED=true "$(basename $0)" || exit 1
fi

clone_frontend &&
  clone_backend &&
  initialize_backend &&
  start_app
