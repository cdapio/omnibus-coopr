name 'coopr-server'
maintainer 'Cask'
homepage 'http://github.com/continuuity/loom'

install_path '/opt/coopr'
build_version   Omnibus::BuildVersion.semver
# build_version '0.9.7'
build_iteration 1

# creates required build directories
dependency 'preparation'

# coopr-provisioner dependencies/components
# dependency "somedep"
dependency 'coopr-server'

exclude "\.git*"
exclude "bundler\/git"
