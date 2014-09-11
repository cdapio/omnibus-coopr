name 'loom-provisioner'
maintainer 'Continuuity'
homepage 'http://github.com/continuuity/loom'

install_dir '/opt/loom/provisioner'
build_version   Omnibus::BuildVersion.semver
# build_version '0.9.7'
build_iteration 1

# conflict with standalone
# conflicts 'loom-standalone'

# creates required build directories
dependency 'preparation'

# loom-provisioner dependencies/components
# dependency "somedep"
dependency 'loom-provisioner'

exclude "\.git*"
exclude "bundler\/git"
