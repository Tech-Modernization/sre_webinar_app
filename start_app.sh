#!/usr/bin/env bash
set -e

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
}

initialize_backend() {
  docker-compose run --rm backend-init
}

start_logging_stack() {
  docker-compose up -d splunk
}

start_observability_stack() {
  docker-compose up -d prometheus prometheus-frontend backend-exporter grafana \
    jaeger jaeger-frontend
}

start_app() {
  docker-compose up -d database frontend backend
}

for app in docker-compose git
do
  if ! &>/dev/null which "$app"
  then
    >&2 echo "ERROR: Ensure that you have '$app' installed on your machine."
    exit 1
  fi
done

if [ -z ${SPLUNK_PASSWORD} ]
then
  echo "Required environment variable SPLUNK_PASSWORD is not set."
  exit 1
else
  clone_frontend &&
    clone_backend &&
    initialize_backend &&
    start_logging_stack &&
    start_observability_stack &&
    start_app
fi
