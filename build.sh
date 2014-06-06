#!/usr/bin/env bash

__usage() { echo "Usage: ${0}:"; echo "  ${0} <all|project [project] ...>"; exit 1; };

if [[ ${LOOM_BUILD_PROJECTS} ]]; then
  echo "Building ${LOOM_BUILD_PROJECTS}"
elif [[ ${#} -eq 1 ]] && [[ ${1} == 'all' ]]; then
  echo "Building all"
elif [[ ${#} -ge 1 ]]; then
  echo "Building ${*}"
  LOOM_BUILD_PROJECTS=${*}
else
  __usage
fi

exec vagrant up
