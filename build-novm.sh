#!/usr/bin/env bash

__usage() { echo "Usage: ${0}:"; echo "  ${0} <all|project [project] ...>"; exit 1; };

if [[ ${COOPR_BUILD_PROJECTS} ]]; then
  __OUTPUT="Building ${COOPR_BUILD_PROJECTS}"
elif [[ ${#} -eq 1 ]] && [[ ${1} == 'all' ]]; then
  COOPR_BUILD_PROJECTS="coopr-cli coopr-provisioner coopr-server coopr-ui"
  __OUTPUT="Building all (${COOPR_BUILD_PROJECTS})"
elif [[ ${#} -ge 1 ]]; then
  __OUTPUT="Building ${*}"
  COOPR_BUILD_PROJECTS=${*}
else
  __usage
fi

# export, or we won't be in the build env
export COOPR_BUILD_PROJECTS

echo ${__OUTPUT}

bundle install --binstubs
mkdir -p /var/cache/omnibus
for proj in ${COOPR_BUILD_PROJECTS}; do
  bin/omnibus build ${proj} || { echo "Failed building ${proj}" && exit 1; }
  rm -rf /opt/coopr
done
