#!/usr/bin/env bash

COOPR_DISTRIBUTIONS=${COOPR_DISTRIBUTIONS:-centos ubuntu}

die() { echo "ERROR: ${@}"; exit 1; }

__clean() {
  for __distro in ${COOPR_DISTRIBUTIONS}; do
    __containers=$(docker ps -a | grep omnibus-coopr-${__distro} | awk '{print $1}' 2>/dev/null)
    if [[ -n ${__containers} ]]; then
      for __id in ${__containers}; do
        docker stop ${__id} 2>/dev/null
        docker rm ${__id} 2>/dev/null
      done
    fi
    __images=$(docker images | grep omnibus-coopr-${__distro} | awk '{print $3}' | sort -u 2>/dev/null)
    if [[ -n ${__images} ]]; then
      for __img in ${__images}; do
        docker rmi ${__img} 2>/dev/null
      done
    fi
  done
  return
}

__build() {
  mkdir -p target
  local __failed
  for __distro in ${COOPR_DISTRIBUTIONS}; do
    # Create image
    __image=omnibus-coopr-${__distro}
    echo "Creating ${__image} from Dockerfile-${__distro}"
    docker build -f Dockerfile-${__distro} -t ${__image} .
    if [[ $? -eq 0 ]]; then
      echo "Copying artifacts from ${__image}"
      docker run -i -v $(pwd -P)/target:/tmp/target ${__image} /bin/bash -c 'cp -f /var/tmp/coopr-build/pkg/* /tmp/target'
      if [[ $? -eq 0 ]]; then
        echo "Copied ${__distro} packages to target successfully"
      else
        die "Copying ${__distro} packages failed!"
      fi
    else
      __failed+="${__distro} "
    fi
  done
  if [[ -n ${__failed} ]]; then
    die "Failed to build the following distribution packages: ${__failed}"
  fi
  __clean
  return
}

__ret=1
if [[ ${#} -eq 0 ]]; then
  echo "No arguments given, running: clean build"
  __clean ; __build
  __ret=$?
else
  while [[ ${#} -gt 0 ]]; do
    case ${1} in
      clean|build) __action=${1}; shift; __${__action}; __ret=$? ;;
      *) die "Unrecognized parameter!" ;;
    esac
  done
fi

exit ${__ret}
