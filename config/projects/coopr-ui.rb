name 'coopr-ui'
maintainer 'Cask'
homepage 'http://github.com/continuuity/loom'

install_path '/opt/coopr'
build_version   Omnibus::BuildVersion.semver
# build_version '0.9.7'
build_iteration 1

# Version overrides
override :nodejs, version: '0.10.26'

# creates required build directories
dependency 'preparation'

# coopr-ui dependencies/components
dependency 'coopr-ui'

exclude "\.git*"
exclude "bundler\/git"
