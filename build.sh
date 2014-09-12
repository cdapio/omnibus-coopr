#!/usr/bin/env bash

__usage() { echo "Usage: ${0}:"; echo "  ${0} <all|project [project] ...>"; exit 1; };

if [[ ${COOPR_BUILD_PROJECTS} ]]; then
  __OUTPUT="Building ${COOPR_BUILD_PROJECTS}"
elif [[ ${#} -eq 1 ]] && [[ ${1} == 'all' ]]; then
  __OUTPUT="Building all"
elif [[ ${#} -ge 1 ]]; then
  __OUTPUT="Building ${*}"
  COOPR_BUILD_PROJECTS=${*}
else
  __usage
fi

# export, or we won't be in the build env
export COOPR_BUILD_PROJECTS

__plugins=$(vagrant plugin list | awk '{print $1}')

# Check for plugins, install if missing
for __p in vagrant-berkshelf vagrant-omnibus ; do
  if [[ $(echo ${__plugins} | grep ${__p}) ]]; then
    echo "Found plugin: ${__p}"
  else
    echo "Installing plugin: ${__p}"
    vagrant plugin install ${__p}
  fi
done

echo "Destroying any running VMs..."
vagrant destroy -f

echo ${__OUTPUT}
exec vagrant up
