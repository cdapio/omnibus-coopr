name 'loom-ngui'
maintainer 'Continuuity'
homepage 'http://github.com/continuuity/loom'

install_dir '/opt/loom/ngui'
build_version   Omnibus::BuildVersion.semver
# build_version '0.9.7'
build_iteration 1

# conflict with standalone
# conflicts 'loom-standalone'

# Version overrides
override :nodejs, version: '0.10.26'

# creates required build directories
dependency 'preparation'

# loom-ui dependencies/components
dependency 'loom-ngui'

exclude "\.git*"
exclude "bundler\/git"
